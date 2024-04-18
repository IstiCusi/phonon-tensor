#!/usr/bin/env bash

function tensor() {
    local image="tensor"
    local base_command="docker run --gpus all -it -v $(pwd):/home/phonon/workingdir -v /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY $image"

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

