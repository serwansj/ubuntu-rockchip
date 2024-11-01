# shellcheck shell=bash

export BOARD_NAME="ITX 3568Q"
export BOARD_MAKER="Firefly"
export BOARD_SOC="Rockchip RK3568J"
export BOARD_CPU="ARM Cortex A55"
export UBOOT_PACKAGE="u-boot-turing-rk3588"
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
    fi

    return 0
}
