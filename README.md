# Sphinx-Server
Sphinx-Server allows you to build Sphinx documentation using a Docker image based on Alpine.

Build Status Docker pulls Docker layers Docker automated build

## Functionalities:

- Sphinx documentation served by a python server
- UML support with PlantUML
- dot support with Graphviz
- Autobuild with sphinx-autobuild
- HTTP authentication

## Limitations:

This image is not bundled with LaTeX but you can generate .tex files and compile them outside of the container

## Installation

### With Docker Hub

Pull the image from Docker Hub using:

``docker pull wessenstam/sphinx_server``

If you only want to compile files without using the server, you can use the following command (for example) at the root of your documentation:

``docker run -t -v "$(pwd)":/web wessenstam/sphinx-server make html``

## From source
Clone this repository on your computer and build the image using the following command:

``docker build -t sphinx-server .``

## Usage
You may add a .sphinx-server.yml file at the root of your project documentation if you want to use a custom configuration. You can see the default .sphinx-server.yml in this repository that will be used if you don't add yours.

### Container creation

#### Without autobuild (production mode):

If you want to enable HTTP authentication, just add a .sphinx-server.yml file at the root of your project documentation and add a credentials section. You also need to set autobuild to false.

Run the following command at the root of your documentation:

``docker run -itd -v "$(pwd)":/web -p 8000:8000 --name sphinx-server wessenstam/sphinx_server``

#### With autobuild enabled:

Autobuild is enabled by default. You may add folders and files to the ignore list.

Run the following command at the root of your documentation:

``docker run -itd -v "$(pwd)":/web -u $(id -u):$(id -g) -p 8000:8000 --name sphinx-server wessenstam/sphinx_server``

The web server will be listening on port 8000. All the files in the current directory will be mounted in the container.

## Interacting with the server

To stop the server, use ``docker stop sphinx-server``
To start the server, use ``docker start sphinx-server``
To remove the server, use ``docker rm -v sphinx-server``
You can use the following command to open a shell into the container:

``docker exec -it sphinx-server /bin/sh``
You can then run commands like make html to build the documentation.
