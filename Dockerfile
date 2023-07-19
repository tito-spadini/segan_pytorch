# Base image
FROM nvidia/cuda:12.2.0-base-ubuntu22.04

# Miniconda install
ENV CONDA_AUTO_UPDATE_CONDA=false
ENV PATH=/opt/conda/bin:$PATH
ARG PYTHON_VERSION=3.7.16

RUN apt update
RUN apt install -y --no-install-recommends git
RUN apt install -y --no-install-recommends sox
RUN apt install -y --no-install-recommends gcc
RUN apt install -y --no-install-recommends htop
RUN apt install -y --no-install-recommends tmux
RUN apt install -y --no-install-recommends unzip
RUN apt install -y --no-install-recommends vim
RUN apt install -y --no-install-recommends wget
RUN rm -rf /var/lib/apt/lists/*

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
RUN rm Miniconda3-latest-Linux-x86_64.sh

# Conda environment creation
RUN /opt/conda/bin/conda create -y --name segan_pt python=$PYTHON_VERSION

# Conda environment activation
RUN echo "source activate segan_pt" > ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]

# PyTorch and TensorFlow install via conda
RUN conda install -y -c pytorch pytorch==0.4.1 torchvision cuda90
RUN conda install tensorflow-gpu
RUN conda install tensorboardx

# Dependencies install via pip
RUN pip install git+https://github.com/santi-pdp/ahoproc_tools@master
RUN pip install toml
RUN pip install cython
RUN pip install librosa==0.9.2
RUN pip install pillow==6.2

# Final config
RUN git clone https://github.com/tito-spadini/segan_pytorch
WORKDIR /segan_pytorch
RUN chmod +x *.sh
CMD ["bash"]