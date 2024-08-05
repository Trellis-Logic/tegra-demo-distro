FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " file://deepstream-nvdsanalytics-demo.service"

inherit systemd

do_install:append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/deepstream-nvdsanalytics-demo.service ${D}${systemd_system_unitdir}
}

PACKAGES += "${PN}-nvdsanalytics-demo"
SYSTEMD_SERVICE:${PN}-nvdsanalytics-demo = "deepstream-nvdsanalytics-demo.service"
SYSTEMD_PACKAGES = "${PN}-nvdsanalytics-demo"
FILES:${PN}-nvdsanalytics-demo = "${systemd_system_unitdir}/deepstream-nvdsanalytics-demo.service"
RDEPENDS:${PN}-nvdsanalytics-demo = "${PN} ${PN}-samples"
