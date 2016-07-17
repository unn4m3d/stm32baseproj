#!/bin/bash

#echo "*****************************************************************"
#echo "*  Starting GDB server...                                       *"
#echo "*  For connect to it - run GDB in another console and:          *"
#echo "*   (gdb) target remote :4242                                   *"
#echo "*  For load ELF to STM32VLDiscovery                             *"
#echo "*   (gdb) load $1                                               *"
#echo "* Note: please use arm-none-eabi-gdb unstead of x86 targeted    *"
#echo "* gdb!                                                          *"
#echo "*****************************************************************"
#st-util 4242 /dev/stlinkv1_1

if [ ! "$STLINK_ADDR" ]; then
  echo "[WARNING] STLINK_ADDR is not set correctly, defaulting to 0x8000000"
  STLINK_ADDR=0x8000000
fi

if [ "$STLINK_VER" == "" ]; then
  echo "[WARNING] STLINK_VER is not set, defaulting to v1"
  STLINK_VER=v1
else
  case $STLINK_VER in
    1|2)
      echo "[WARNING] STLINK_VER is in wrong form ($STLINK_VER), setting to v$STLINK_VER"
      STLINK_VER=v$STLINK_VER
      ;;

    v1|v2)
      echo "[INFO] Correct STLINK_VER ($STLINK_VER) is set"
      ;;
    *)
      echo "[WARNING] Invalid STLINK_VER ($STLINK_VER), defaulting to v1"
      STLINK_VER=v1
      ;;
  esac
fi

#echo "*****************************************************************"
echo "[INFO] Flashing $1 at $STLINK_ADDR with st-link $STLINK_VER"
#echo "*****************************************************************"
echo -n "Are parameters correct ? [y/N] "
read answer
case "$answer" in
  "y"|"Y")
    echo "[INFO] Flashing..."
    ;;
  *)
    echo "[INFO] Aborting..."
    exit 0
    ;;
esac


st-flash write $STLINK_VER $1 $STLINK_ADDR
