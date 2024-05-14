# Swupdate for NVIDIA Tegra (Jetson) platforms

This dynamic layer provides an example implementation for
Nvidia Jetson and [swupdate](https://sbabic.github.io/swupdate).

The simplest way to use on tegra is to add to a forked copy of
[tegra-demo-distro](https://github.com/OE4T/tegra-demo-distro) which
also contains relevant images and submodules used to build tegra images.
However, this is not strictly required.  The only dependency required
is the [meta-tegra](https://github.com/OE4T/meta-tegra) layer.

## Build with KAS

The files under [conf/kas](conf/kas) support building with
the [kas](https://kas.readthedocs.io/).

The setups here reprensent the last configuration tested.

### Install kas
```
pip3 install kas
```

### Build with kas

Use the scripts at [scripts](scripts), for instance

```
./scripts/build-jetson-orin-nano-devkit-nvme.sh
```
to build for the jetson-orin-nano-devkit-nvme `MACHINE` on the
default branch configuration.

The default build will build for whatever branch of this
repository you've cloned.  To build with a different branch,
specify the branch name as the first argument to the script


## Build with tegra-demo-distro

Use these instructions to add to tegra-demo-distro on whatever
branch you'd like to target (kirkstone and later are supported).

```
cd repos
git submodule add https://github.com/sbabic/meta-swupdate
cd ../layers
ln -s ../repos/meta-swupdate
```

Then use the `setup-env` script to start a bitbake shell, and add
this layer to your build
```
bitbake-layers add-layer ../layers/meta-swupdate
```

In your local.conf (or distro/machine configuration) add
these lines:
```
IMAGE_INSTALL:append = " swupdate"
USE_REDUNDANT_FLASH_LAYOUT = "1"
IMAGE_FSTYPES:append = " tar.gz"
```
If you desire an image other than demo-image-base as your base image,
you may add a definition for `SWUPDATE_CORE_IMAGE_NAME` with the
desired base image.

Finally, build the update image using:
```
bitbake swupdate-image-tegra
```

## Deploy and Test
* Tegraflash the inital image (demo-image-base or, whatever
image you've set as `SWUPDATE_CORE_IMAGE_NAME`
* Deploy the .swu file built with swupdate-image-tegra
to the target
* Run the update with:
```
swupdate -i </path/to/swu/file>
```
* Reboot to apply the update.
  * The root partition should change
  * The `nvbootctrl dump-slots-info` output should show boot
from the alternate boot slot with `Capsule update status:1`.
