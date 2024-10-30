# shellcheck shell=bash

export BOARD_NAME="ITX 3568Q"
export BOARD_MAKER="Firefly"
export BOARD_SOC="Rockchip RK3568J"
export BOARD_CPU="ARM Cortex A55"
export UBOOT_PACKAGE="u-boot-radxa-rk3588"
export UBOOT_RULES_TARGET="itx-3568q-rk3568j"
export COMPATIBLE_SUITES=("jammy" "noble")
export COMPATIBLE_FLAVORS=("server" "desktop")

function config_image_hook__itx-3568q() {
    local rootfs="$1"
    local overlay="$2"
    local suite="$3"

    if [ "${suite}" == "jammy" ] || [ "${suite}" == "noble" ]; then
        # Kernel modules to load at boot time
        echo "sprdbt_tty" >> "${rootfs}/etc/modules"
        echo "sprdwl_ng" >> "${rootfs}/etc/modules"

        # Kernel modules to blacklist
        echo "blacklist bcmdhd" > "${rootfs}/etc/modprobe.d/bcmdhd.conf"

        # Enable bluetooth
        cp "${overlay}/usr/bin/hciattach_opi" "${rootfs}/usr/bin/hciattach_opi"
        cp "${overlay}/usr/lib/systemd/system/sprd-bluetooth.service" "${rootfs}/usr/lib/systemd/system/sprd-bluetooth.service"
        chroot "${rootfs}" systemctl enable sprd-bluetooth
    fi

    return 0
}