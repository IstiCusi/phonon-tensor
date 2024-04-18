# Phonon Tensor Docker

Welcome to the IstiCusi/phonon-tensor repository! This Docker scripts are
designed to facilitate the development and execution of TensorFlow applications
with GPU support. The container is configured to provide an enhanced
development experience with LunarVim as the editor, integrated for better code
management and editing in C, C++, and Python.

## Motivation

On some linux distributions it is hard (if not nearly possible) to keep 
all dependencies well resolved for **Tensor Flow**. To let the host use still
the newest NVIDIA drivers (including CUDA), this docker image provides even
the beginners with a working environment to startup fast GPU-based tensor flow
calculations. 

The docker image is based on:

- Ubuntu 22.04
- CUDA 12.3.0 
- Lib Tensor Flow C/C++ 2.16.1

## Prerequisites on the Host

To ensure smooth setup and operation of the Docker environment, the host machine needs to meet the following requirements:

- **Operating System**: The host must be a Linux-based system, as the scripts and configurations are specifically tailored for Linux.
- **Docker**: Docker must be installed to create and manage the containerized environment. This allows for the isolation of the TensorFlow setup and its dependencies.
- **wget**: Required for fetching files and resources over the network. Ensure wget is installed to handle downloads within the scripts.
- **git**: Necessary for cloning the repository and managing version control. Ensure git is installed to access the latest updates and script versions.
- **internet access**: You need a good internet connection, so that packages can be downloaded by the docker file

Make sure these tools are installed and properly configured before proceeding with the setup.

## Features

- GPU Support: Optimized for leveraging GPUs with TensorFlow to enhance
  performance for machine learning tasks.
- LunarVim Integration: A Neovim-based development environment set up to improve
  productivity and user experience for developers.
- Pre-configured Templates: Includes setups for C, C++, and Python located at
  `/docker/templates/c/`, `/docker/templates/cpp/`,
- and within the Python environment, respectively. These templates are tailored
  to provide a quick start for projects.
- Libraries: Key libraries such as ncurses are included to support complex
  text-based applications within the container.

## Installation

Follow these steps to get started with the Tensor Docker Container:

### Clone the Repository

Clone the repository and navigate into the directory using the following commands

```bash
git clone https://github.com/IstiCusi/phonon-tensor.git
cd phonon-tensor
```

### Run the Installer Script

Execute the `installer.sh` script to set up the environment. This script will
download the necessary TensorFlow libraries, configure directory structures,
and build the Docker image. Run the script with: `./installer.sh`

This script will prompt you to integrate the `tensor_run.sh` into your
`.zshrc` or `.bashrc` files for easy access to the container
functionalities.

## Startup

- To start an interactive TensorFlow GPU session using the container, simply
  run: `tensor`

- To execute a Python script that utilizes TensorFlow within this environment,
  use: `tensor <file>`

## Uninstallation

To uninstall the Docker container and clean up the modifications made during
installation:

1. Remove the Docker image using the command: `docker rmi tensor`

2. Remove the tensor_run.sh sourcing from your `.zshrc` or `.bashrc` file.

3. Delete the `~/.phonon-docker` directory if no longer needed.

## Usage

When you started the container by `tensor` you will find yourself in the
`/home/phonon/` folder. There you will find a `workingdir` directory, that
points to the host folder, your started the docker. You can therefore easily
access your working files on the host. Be aware, that the docker runs under
it's own root access (not of your machine clearly). files build by it are owned
by the root of the docker container.

### Start the LunarVim

For easy access, you can simple start the lunarvim ide with `vv`. It provides
complete python, c and c++ syntax completion.

### Template folders

You file find c, c++ and python project templates at /home/phonon/templates.
Copy them in your `workingdir` to startup projects quickly.

## Support

For any issues, questions, or contributions, please feel free to
open an issue or submit a pull request on the GitHub repository page. We are
grateful to these projects and their contributors for their open-source
commitments and encourage users to comply with the respective licenses if they
use these tools in their own projects.

## Legal Section

This project makes use of several external tools and libraries, and we wish to
acknowledge their contribution and provide information about their licenses.

### TensorFlow: TensorFlow is utilized within this Docker container for its

powerful machine learning libraries and capabilities. TensorFlow is an
open-source platform developed by the TensorFlow team at Google. It is
available under the Apache License 2.0. We extend our thanks to the TensorFlow
community for developing and maintaining such a powerful tool. More information
about TensorFlow and its license can be found at <https://www.tensorflow.org>.

### LunarVim: LunarVim, a configuration framework for Neovim, is integrated into

our development environment to enhance productivity and usability for coding.
LunarVim is built on top of Neovim and is freely available under the open-source
license. We thank the LunarVim and Neovim teams for providing such a versatile
and powerful tool for developers. Further details about LunarVim and its
licensing can be accessed at <https://github.com/LunarVim/LunarVim>.

### Neovim: As the core upon which LunarVim is built, Neovim is an extension of

Vim aiming to improve user experience, plugins, and GUIs. Neovim is open-source
software and is available under the Apache License 2.0. Appreciation goes to
the Neovim community for their continuous efforts in improving the developer
experience. For more information about Neovim and its licensing, visit
<https://neovim.io>.

## TODOs

- The jupyter support is not working and port 8888 needs to be handed to the host
- docker container could be potentially added to github. 
- de-installer script
- extension of the template library and an example library 
- explanation of the docker preliminaries for rookies
- better direct one button, one copy, one click installation (maybe including preliminaries)

