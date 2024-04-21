#!/bin/zsh
function tensor() {
    local image="tensor"
    local base_command="docker run --gpus all -it -v $(pwd):/home/phonon/workingdir -v /tmp/.X11-unix:/tmp/.X11-unix --env DISPLAY=$DISPLAY -p 8888:8888 $image"

    if [[ -z "$1" ]]; then
        echo "Starting Jupyter TensorFlow GPU session..."
        eval "$base_command bash -c 'source /etc/bash.bashrc && jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root'"
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

