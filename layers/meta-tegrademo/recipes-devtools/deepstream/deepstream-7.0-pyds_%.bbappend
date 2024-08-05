FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " file://deepstream-nvdsanalytics-demo.service"

inherit systemd

do_install:append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/deepstream-nvdsanalytics-demo.service ${D}${systemd_system_unitdir}
    install -d ${D}/opt/nvidia/deepstream/deepstream-7.0/samples/models/Primary_Detector/
    cd ${D}/opt/nvidia/deepstream/deepstream-7.0/samples/models/Primary_Detector/
    ln -s resnet18_trafficcamnet.etlt_b1_gpu0_int8.engine resnet18_trafficcamnet.etlt_b30_gpu0_int8.engine
}

PACKAGES += "${PN}-nvdsanalytics-demo"
SYSTEMD_SERVICE:${PN}-nvdsanalytics-demo = "deepstream-nvdsanalytics-demo.service"
SYSTEMD_PACKAGES = "${PN}-nvdsanalytics-demo"
FILES:${PN}-nvdsanalytics-demo = " \
    ${systemd_system_unitdir}/deepstream-nvdsanalytics-demo.service \
    /opt/nvidia/deepstream/deepstream-7.0/samples/models/Primary_Detector \
    /opt/nvidia/deepstream/deepstream-7.0/samples/models/Primary_Detector/resnet18_trafficcamnet.etlt_b30_gpu0_int8.engine \
"
RDEPENDS:${PN}-nvdsanalytics-demo = "${PN} ${PN}-samples"
