DESCRIPTION = "Minimal image supporting docker"

require demo-image-common.inc

CORE_IMAGE_BASE_INSTALL += "nvidia-docker \
                            tegra-libraries-multimedia \
                            "
