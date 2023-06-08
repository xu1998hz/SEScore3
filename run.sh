sudo apt update
sudo apt upgrade

sudo apt install nvidia-driver-510 nvidia-dkms-510
sudo reboot

# above are codes to set up the driver

sudo apt install python3-pip
pip3 install nvitop

# install cuda
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda

# install anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
chmod 777 Anaconda3-2022.10-Linux-x86_64.sh
./Anaconda3-2022.10-Linux-x86_64.sh
sudo reboot

# install cnndm
conda install -c conda-forge cudnn==8

pip3 install -r requirements.txt

# mounting the new file system

lsblk # run this command to find the name of the attached volume
sudo mkdir /data
sudo mount {device_name} /data

sudo file -s /dev/nvme3n1
sudo mount /dev/nvme3n1 /data

# to mount the disk permanently
sudo cp /etc/fstab /etc/fstab.orig
sudo lsblk -o +UUID # to get the UUID for the disk, step 2
sudo vim /etc/fstab

# add the below line in /etc/fstab file, UUID looks like: aebf131c-6957-451e-8d34-ec978d9581ae
UUID={UUID from step 2}  /data  xfs  defaults,nofail  0  2

# change permissions
sudo chgrp adm /data
sudo chmod g+w /data
