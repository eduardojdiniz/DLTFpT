#!/bin/bash
sudo docker run -v $(pwd):/home/jovyan/work -it --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes dltfpt-stack
