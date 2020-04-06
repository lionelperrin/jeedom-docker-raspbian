This repository contains the suitable docker-compose / Dockerfile to start a fresh instance of [Jeedom](https://www.jeedom.com).

# Installation steps

 1. Install docker on your machine. When using raspbian, docker can be installed with: `apt-get install docker docker-compose`.
 2. Copy/Rename the `env_template` file into .env and set the required variables (mainly passwords).
 3. Start jeedom: `docker-compose up`.
 4. After building the images, jeedom will be started and available on port 9080. Follow the Get Started guide for Jeedom to proceed with the configuration.
 5. Backups can be sent using a command like `docker-compose -f docker-compose.backup.yml run --rm backup`.

# What's in this repo?

 - the jeedom-core#stable folder is a git-subtree of the stable branch of the root project github/jeedom-core. The only change with the standard repo is the base image of the Dockerfile (raspbian instead of debian).
   `git subtree add --prefix jeedom-core#stable https://github.com/jeedom/core.git stable --squash`
 - the backup folder contains a shell script to archive the jeedom backage on [Azure Blob Storage](https://docs.microsoft.com/azure/storage/blobs/storage-blobs-introduction)
