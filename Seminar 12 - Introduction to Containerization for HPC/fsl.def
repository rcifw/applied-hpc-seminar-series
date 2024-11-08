singularity
Bootstrap: docker
From: rockylinux:8.10

%post
    # Install basic dependencies
    dnf -y install epel-release
    dnf -y update
    dnf -y install \
        wget \
        python3 \
        libquadmath \
        libgomp \
        mesa-libGL \
        bc \
        hostname \
        which

    # Download and install FSL
    wget https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py
    python3 fslinstaller.py -d /opt/fsl -V 6.0.7.8

%environment
    # Set FSL environment variables
    export FSLDIR=/opt/fsl
    export PATH=$FSLDIR/bin:$PATH
    export FSLOUTPUTTYPE=NIFTI_GZ
