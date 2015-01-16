FROM tleyden5iwx/ubuntu-cuda
MAINTAINER Ryan Baumann <ryan.baumann@gmail.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y libgtk2.0-dev glew-utils libglew-dev libmetis-dev libscotchparmetis-dev libdevil-dev libboost-all-dev libatlas-cpp-0.6-dev libatlas-dev imagemagick libatlas3gf-base libcminpack-dev libgfortran3 freeglut3-dev libgsl0-dev liblapack-dev unzip youtube-dl libav-tools dos2unix

WORKDIR /root

# Install VisualSFM
ADD http://ccwu.me/vsfm/download/VisualSFM_linux_64bit.zip /root/VisualSFM_linux_64bit.zip
RUN unzip VisualSFM_linux_64bit.zip
RUN cd vsfm; make

# Install PBA
ADD http://grail.cs.washington.edu/projects/mcba/pba_v1.0.5.zip /root/pba.zip
RUN unzip pba.zip
ADD pba.patch /root/pba/pba.patch
RUN cd pba; dos2unix makefile_no_gpu; patch -p1 < pba.patch
RUN cd pba; make -f makefile_no_gpu; cp -v bin/libpba_no_gpu.so ../vsfm/bin/libpba.so

# Install pmvs2
# ADD http://www.di.ens.fr/pmvs/pmvs-2-fix0.tar.gz /root/pmvs-2.tar.gz
ADD http://www.di.ens.fr/pmvs/pmvs-2.tar.gz /root/pmvs-2.tar.gz
RUN tar xzf pmvs-2.tar.gz
RUN cd pmvs-2/program/main/; cp mylapack.o mylapack.o.backup; make clean; cp mylapack.o.backup mylapack.o; make depend; make

# Install Graclus
ADD http://www.cs.utexas.edu/users/dml/Software/graclus1.2.tar.gz /root/graclus1.2.tar.gz
RUN tar xzf graclus1.2.tar.gz
ADD graclus.patch /root/graclus1.2/graclus.patch
RUN cd graclus1.2; patch -p0 < graclus.patch; make

# Install cmvs
ADD http://www.di.ens.fr/cmvs/cmvs-fix2.tar.gz /root/cmvs.tar.gz
RUN tar xzf cmvs.tar.gz
ADD cmvs.patch /root/cmvs/cmvs.patch
RUN cd cmvs; patch -p1 < cmvs.patch
RUN cp -v ~/pmvs-2/program/main/mylapack.o ~/cmvs/program/main
RUN cd cmvs/program/main; make; cp -v cmvs pmvs2 genOption ~/vsfm/bin

# Install vlfeat
ADD http://www.vlfeat.org/download/vlfeat-0.9.19-bin.tar.gz /root/vlfeat-0.9.19-bin.tar.gz
RUN tar xzf vlfeat-0.9.19-bin.tar.gz
RUN cp -v vlfeat-0.9.19/bin/glnxa64/* vsfm/bin/
ADD nv.ini /root/vsfm/bin/nv.ini

ENV PATH $PATH:/root/vsfm/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/root/vsfm/bin
