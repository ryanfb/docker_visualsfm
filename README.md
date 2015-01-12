docker_visualsfm
================

An experimental Dockerfile for building [VisualSFM](http://ccwu.me/vsfm/) and its dependencies.
 
* Test the build with `docker build .`
* Tag the build with `docker build -t visualsfm .`
* Run the build with `docker run -t -i visualsfm /bin/bash`

See also: [Docker on AWS GPU Ubuntu 14.04 / CUDA 6.5](http://tleyden.github.io/blog/2014/10/25/docker-on-aws-gpu-ubuntu-14-dot-04-slash-cuda-6-dot-5/)

Based on: [tleyden5iwx/ubuntu-cuda](https://registry.hub.docker.com/u/tleyden5iwx/ubuntu-cuda/)

And: [Building VisualSFM on Ubuntu 12.04 (Precise Pangolin) Desktop 64-bit](http://www.10flow.com/2012/08/15/building-visualsfm-on-ubuntu-12-04-precise-pangolin-desktop-64-bit/)
