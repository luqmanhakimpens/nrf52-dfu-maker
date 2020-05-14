# nrf52-dfu-maker
These are .bat scripts used to make DFU (Device Firmware Update) for NRF52. There are 3 .bat file to accomplish each step to flash OTA-DFU enabled firmware. This scripts are based on [this](https://devzone.nordicsemi.com/nordic/short-range-guides/b/software-development-kit/posts/getting-started-with-nordics-secure-dfu-bootloader) guide from Nordic and [this](https://github.com/gamnes/nRF52832-buttonless-dfu-development-tutorial) tutorial.

Make sure you have your compiled bootloader.hex using your generated private and public key, refer to the guide mentioned above. Also you have to set the file and directory path of each file in user_variable.bat. The user_variable.bat looks something like this:
```
:: set installed NRF5 SDK path
SET SDK_ROOT=D:\Nordic\nRF5SDK16-0098a08e2

:: set compiled application hex path
SET APP_HEX=D:\Nordic\nRF5SDK16-0098a08e2\examples\ble_peripheral\ble_app_beacon\pca10040\s132\armgcc\_build\nrf52832_xxaa.hex

:: set precompiled Nordic's SDK path
SET SOFTDEVICE_HEX=%SDK_ROOT%\components\softdevice\s132\hex\s132_nrf52_7.0.1_softdevice.hex

:: set softdevice_code, refer to "nrfutil pkg generate --help" command
SET SOFTDEVICE_CODE=0xCB

:: set output zipped dfu package
SET ZIP_DIR=.\dfu-zip

SET HEX_DIR=.\hex
SET SETTING_HEX=%HEX_DIR%\settings.hex
SET APP_SETTING_HEX=%HEX_DIR%\app_setting.hex
SET BOOTLOADER_DIR=.\bootloader
SET KEY_DIR=.\key
```
At this momment, these scripts are lack of error checking, so be carefull to put your file and set the path to the file in user_variable.bat. 

## SOFTDEVICE_CODE
Refer to: 
```
nrfutil pkg generate --help
```
At this time of writing, one snippet of output of above command looks like this:
```
|s112_nrf52_6.0.0|0xA7|
|s112_nrf52_6.1.0|0xB0|
|s112_nrf52_6.1.1|0xB8|
|s112_nrf52_7.0.0|0xC4|
|s112_nrf52_7.0.1|0xCD|
|s113_nrf52_7.0.0|0xC3|
|s113_nrf52_7.0.1|0xCC|
|s130_nrf51_1.0.0|0x67|
|s130_nrf51_2.0.0|0x80|
|s132_nrf52_2.0.0|0x81|
|s130_nrf51_2.0.1|0x87|
|s132_nrf52_2.0.1|0x88|
|s132_nrf52_3.0.0|0x8C|
|s132_nrf52_3.1.0|0x91|
|s132_nrf52_4.0.0|0x95|
|s132_nrf52_4.0.2|0x98|
|s132_nrf52_4.0.3|0x99|
|s132_nrf52_4.0.4|0x9E|
|s132_nrf52_4.0.5|0x9F|
|s132_nrf52_5.0.0|0x9D|
|s132_nrf52_5.1.0|0xA5|
|s132_nrf52_6.0.0|0xA8|
|s132_nrf52_6.1.0|0xAF|
|s132_nrf52_6.1.1|0xB7|
|s132_nrf52_7.0.0|0xC2|
|s132_nrf52_7.0.1|0xCB|
|s140_nrf52_6.0.0|0xA9|
|s140_nrf52_6.1.0|0xAE|
|s140_nrf52_6.1.1|0xB6|
|s140_nrf52_7.0.0|0xC1|
|s140_nrf52_7.0.1|0xCA|
|s212_nrf52_6.1.1|0xBC|
|s332_nrf52_6.1.1|0xBA|
|s340_nrf52_6.1.1|0xB9|
```
here you can chose softdevice_code according to above list.
