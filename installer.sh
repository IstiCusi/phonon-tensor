#!/usr/bin/env bash

original_dir=$(pwd)

# Erstelle temporäres Verzeichnis für die Installation
mkdir -p /tmp/phonon-docker && cd /tmp/phonon-docker

# Lade TensorFlow-Bibliotheken herunter
curl -L https://storage.googleapis.com/tensorflow/versions/2.16.1/libtensorflow-gpu-linux-x86_64.tar.gz | tar -xz

# Kopiere die notwendigen Dateien in das entsprechende Verzeichnis
rm -rf "$original_dir/docker/templates/c/include" "$original_dir/docker/templates/c/lib"
cp -r include lib "$original_dir/docker/templates/c/"
rm -rf "$original_dir/docker/templates/cpp/include" "$original_dir/docker/templates/cpp/lib"
cp -r include lib "$original_dir/docker/templates/cpp/"

# Aufräumen
rm -rf /tmp/phonon-docker

# Baue das Docker-Image
cd "$original_dir/docker"
docker build -f ThePhononDockerFile -t tensor .

# Zurück zum ursprünglichen Verzeichnis
cd ..

# Nachfragen, ob das Skript zur Ausführung hinzugefügt werden soll
read -p "Do you want to install the running script to your .zshrc and .bashrc files at the beginning of these files? (y/n) " response

if [[ $response =~ ^[Yy]$ ]]; then
    file_source="./tensor_run.sh"
    target_dir="$HOME/.phonon-docker"

    mkdir -p $target_dir
    cp $file_source $target_dir/tensor_run.sh
    chmod +x $target_dir/tensor_run.sh

    # Füge den Befehl zur Ausführung des Skripts den Shell-Startup-Dateien hinzu
    for file in .zshrc .bashrc; do
        file_path="$HOME/$file"
        if [ -f $file_path ]; then
            if ! grep -q "source $target_dir/tensor_run.sh" $file_path; then
                echo "Adding script to the beginning of $file..."
                temp_file=$(mktemp)
                echo "source $target_dir/tensor_run.sh" > $temp_file
                cat $file_path >> $temp_file
                mv $temp_file $file_path
            fi
        else
            echo "$file does not exist, no changes made."
        fi
    done
else
    echo "Installation skipped."
fi

