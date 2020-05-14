# nrf52-dfu-maker
These are .bat scripts used to make DFU (Device Firmware Update) for NRF52. There are 3 .bat file to accomplish each step to flash OTA-DFU enabled firmware. This scripts are based on [this](https://devzone.nordicsemi.com/nordic/short-range-guides/b/software-development-kit/posts/getting-started-with-nordics-secure-dfu-bootloader) guide from Nordic and [this](https://github.com/gamnes/nRF52832-buttonless-dfu-development-tutorial) tutorial.

Make sure you have your compiled bootloader.hex using your generated private and public key, refer to the guide mentioned above. Also you have to set the file and directory path of each file in user_variable.bat. The user_variable.bat looks something like this:
```
SET SETTING_HEX=.\hex\settings.hex
SET APP_HEX=D:\eclipse_cpp-1903\workspace-nrf52\beacon_dfu\build\nrf52832_beacon_dfu.hex
SET APP_SETTING_HEX=.\hex\app_setting.hex

SET SOFTDEVICE_HEX=D:\Nordic\nRF5SDK16-0098a08e2\components\softdevice\s132\hex\s132_nrf52_7.0.1_softdevice.hex
SET SOFTDEVICE_CODE=0xCB
SET BOOTLOADER_HEX=.\bootloader\bootloader.hex

SET PRIVATE_KEY=.\key\private.key
SET ZIP_DIR=%cd%\..\dfu-zip\

```
At this momment, these scripts are lack of error checking, so be carefull to put your file and set the path to the file in user_variable.bat. 
