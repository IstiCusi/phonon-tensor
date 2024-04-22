#!/usr/bin/env bash

function check_and_set_numa_nodes() {
    local numa_node_status=0
    for a in /sys/bus/pci/devices/*/numa_node; do
        if [[ "$(cat $a)" != "0" ]]; then
            numa_node_status=1
            break
        fi
    done

    if [[ $numa_node_status -eq 1 ]]; then
        echo "Not all NUMA nodes are set to 0. Do you want to set all NUMA nodes to 0? This requires sudo access. [y/n]"
        read answer
        if [[ "$answer" == "y" ]]; then
            echo "Setting all NUMA nodes to 0 with sudo..."
            for a in /sys/bus/pci/devices/*/numa_node; do
                echo 0 | sudo tee $a > /dev/null
            done
            echo "All NUMA nodes have been set to 0."
        else
            echo "Continuing without changing NUMA nodes."
        fi
    else
        echo "All NUMA nodes are already set to 0."
    fi
}


function tensor() {
    local image="tensor"
    local base_command="docker run -p 8888:8888 --gpus all -it -v $(pwd):/home/phonon/workingdir -v /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY $image"

    check_and_set_numa_nodes

    if [[ -z "$1" ]]; then
        echo "Starting interactive TensorFlow GPU session..."
        eval "$base_command bash"
    else
        local script_path=$1
        if [[ ! -f "$script_path" ]]; then
            echo "Error: Script '$script_path' does not exist."
            return 1
        fi

        echo "Running Python script '$script_path' in the TensorFlow container..."
        eval "$base_command bash -c 'cd /home/phonon/workingdir && python $script_path; exec bash'"
    fi
}

echo "Function tensor defined."

