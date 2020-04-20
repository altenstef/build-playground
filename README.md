# Readme

Simple dockerized build environment for the **Alten Yocto Playground** held on june 2nd in Apeldoorn.

# Pre-requirements
**linux distribution** (e.g. Ubuntu 16.04)
  Can also be a VM (notice that building time is depending on HW resources So having Multiple CPU Cores, free RAM and enough (**40GB+**) space speeds up the process.)

**Git**<br>
install git:
```
sudo apt-get install git
```

**Docker**: <br>
Install Docker && docker compose:
https://docs.docker.com/install/
https://docs.docker.com/compose/install/

**This archive**:<br>
```
git clone https://github.com/altenstef/build-playground.git
cd build-playground
```

# Determine Build-Target [RPI | EMULATOR]:

Decide if you want to build for either **QEMU** (Emulator) or a **Raspberry PI**.<br>
- For **QEMU** you have to do nothing, the local.conf is default setup for qemu (if changed restore with local.conf.qemu)<br>
- For **PI**; <br>
    - copy the local.conf.rpi over local.conf in this folder<br>
    - Change the ```MACHINE``` variable depending on the selected pi variant.; in the example configuration (local.conf.rpi) the raspberrypi-1 is the chosen. <br>
    **Options**:<br>
    MACHINE = "raspberrypi"<br>
    MACHINE = "raspberrypi0"<br>
    MACHINE = "raspberrypi0-wifi"<br>
    MACHINE = "raspberrypi2"<br>
    MACHINE = "raspberrypi3"<br>
    MACHINE = "raspberrypi4"<br>
    MACHINE = "raspberrypi-cm"<br>
    MACHINE = "raspberrypi-cm3"<br>

# Start using Docker & start build:
!Note that i'm no docker expert, this is just for reproducibility and to speed up the getting started !

Change the UID in the Dockerfile (https://github.com/altenstef/build-playground/blob/master/Dockerfile#L8) if it isn't the default (1000). Use command id to determine your user ID

From the playground git archive directory, bring up the docker image & container:
```
docker-compose build
docker-compose up -d
```
Enter the container if it is running:
```
docker-compose exec playground bash
```

When successfully entered the container you should see something like:
```
===================================================================
= Alten Playground Yocto Docker Container                         =
===================================================================

(c) Stef Boerrigter - Alten (2020)

Execute:
$ source oe-init-build-env
$ bitbake playground-image

alten@f06e00c06689:/opt/build-directory/yocto$
```

Now execute the two commands listed above:
```
source oe-init-build-env
bitbake playground-image
```

The bitbake command might take a few hours (depending on the speed of your build-system). For reference; on my i5 (4 threads) it took ~3 hours. Warnings can appear, i'll try to explain them in the playground itself. Take also in account that the build must keep network enabled (keep laptop for instance powered).

The build is finished when the console returns and the following is printed:

```
Initialising tasks: 100% |################################################################| Time: X:XX:XXX
Sstate summary: Wanted 0 Found 0 Missed 0 Current 1169 (0% match, 100% complete)
NOTE: Executing Tasks
NOTE: Setscene tasks completed
NOTE: Tasks Summary: Attempted 3358 tasks of which 3358 didn't need to be rerun and all succeeded.
```

### Running into Issues: ###
if you run into any problems / issue's, please provide the logging from the following command to me:
```
docker-compose logs
```

## QEMU - Emulator:
### Starting the qemu emulator:
The qemu emulator can be started with the following command.
```
runqemu nographic
```
Note: if host asks for root/sudo password: this is 'alten'

### Log-in to qemu image as root user:
```
Username: root
Password: alten
```

### Run Helloworld Application:
```
helloworld
```
Expected output:

```
Poky (Yocto Project Reference Distro) 3.0.1 qemuarm ttyAMA0

qemuarm login: root
Password:
root@qemuarm:~# helloworld
Hello World from the Alten Tech Playground
root@qemuarm:~#
```

### Exit Qemu:
```
Ctrl-A X
```
Press Ctrl + A, release them and press x.

## PI:
If you have chosen the RPI image, you can test with copying the sdcard.img on an SD card and insert it into a raspberry PI.
TODO

#TODO's:
- Update PI sd card creation and test
- Remove qemu machine? e.g. run pi image?
- 
