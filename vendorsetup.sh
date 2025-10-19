#
#  OrangeFox device-specific build settings for
#  CMF Phone 1  (codename: Tetris - uppercase maintained)
#

FDEVICE="Tetris"
#set -o xtrace    # uncomment for verbose build log

fox_get_target_device() {
    local chkdev
    chkdev=$(echo "$BASH_SOURCE" | grep -w ${FDEVICE})
    if [ -n "$chkdev" ]; then
        FOX_BUILD_DEVICE="${FDEVICE}"
    else
        chkdev=$(set | grep BASH_ARGV | grep -w ${FDEVICE})
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="${FDEVICE}"
    fi
}

# -------------------------------------------------------------
#  Detect our device
# -------------------------------------------------------------
if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
    fox_get_target_device
fi

if [ "$1" = "$FDEVICE" ] || [ "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    # ---------------------------------------------------------
    #  Locale
    # ---------------------------------------------------------
    export TW_DEFAULT_LANGUAGE="en"
    export LC_ALL="C"

    # ---------------------------------------------------------
    #  OrangeFox common recommended flags
    # ---------------------------------------------------------
    export FOX_USE_DATA_RECOVERY_FOR_SETTINGS=1
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
    export OF_NO_MIUI_PATCH_WARNING=1
    export OF_VANILLA_BUILD=0

    # ---------------------------------------------------------
    #  Device specifics
    # ---------------------------------------------------------
    export TARGET_DEVICE_ALT="A015"
    export FOX_AB_DEVICE=1                  # A/B & vendor_boot device

    # ---------------------------------------------------------
    #  LEDs / flashlight
    # ---------------------------------------------------------
    export OF_FLASHLIGHT_ENABLE=0
    export OF_USE_GREEN_LED=0

    # ---------------------------------------------------------
    #  Display & notch handling
    # ---------------------------------------------------------
    export OF_SCREEN_H=2400
    export OF_STATUS_H=90
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export OF_CLOCK_POS=1
    export OF_ALLOW_DISABLE_NAVBAR=0
    export OF_HIDE_NOTCH=1

    # ---------------------------------------------------------
    #  Toolbox / utilities baked into recovery
    # ---------------------------------------------------------
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_SED_BINARY=1
    export FOX_USE_XZ_UTILS=1
    export FOX_REPLACE_TOOLBOX_GETPROP=1
    export FOX_USE_NANO_EDITOR=1
    export OF_ENABLE_LPTOOLS=1
    export FOX_ENABLE_APP_MANAGER=0
    export FOX_DELETE_AROMAFM=1

    # ---------------------------------------------------------
    #  Encryption / AVB
    # ---------------------------------------------------------
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
    export OF_PATCH_AVB20=1
    export OF_DEFAULT_KEYMASTER_VERSION=4.1
    export FOX_BUGGED_AOSP_ARB_WORKAROUND="1546300800"   # 2019-01-01T00:00Z
    export OF_IGNORE_LOGICAL_MOUNT_ERRORS=1
    export OF_FBE_METADATA_MOUNT_IGNORE=1

    # ---------------------------------------------------------
    #  OTA behaviour
    # ---------------------------------------------------------
    export OF_KEEP_DM_VERITY=1

    # ---------------------------------------------------------
    #  Maintainer tag (shown in About page)
    # ---------------------------------------------------------
    export OF_MAINTAINER="Tetris-Development"
    # Optional personal suffix for the version string:
    # export FOX_MAINTAINER_PATCH_VERSION="01"

    # ---------------------------------------------------------
    #  Dump build-time variables into the log (helps debugging)
    # ---------------------------------------------------------
    if [ -n "$FOX_BUILD_LOG_FILE" ] && [ -f "$FOX_BUILD_LOG_FILE" ]; then
        (
            export | grep "FOX"
            export | grep "OF_"
            export | grep "TARGET_"
            export | grep "TW_"
        ) >> "$FOX_BUILD_LOG_FILE"
    fi
fi
#