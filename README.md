# nrf52-dfu-maker

These are .bat scripts used to make DFU (Device Firmware Update) OTA for NRF52. All of this scripts and guide are based on [this](https://devzone.nordicsemi.com/nordic/short-range-guides/b/software-development-kit/posts/getting-started-with-nordics-secure-dfu-bootloader) guide from Nordic and [this](https://github.com/gamnes/nRF52832-buttonless-dfu-development-tutorial) tutorial. Go there to get complete explanation and guideline. 

## How to use
### 1. Preparation, modify env_variable.bat 
#### a. Set SDK_ROOT, Set the path where you install the NRF5 SDK.
#### b. Set APP_HEX, Set the path to your compiled application. 
In the example below, we set the APP_HEX to ble_app_beacon example from nordic.
#### c. set SOFTDEVICE_HEX, set the path to Nordic's precompiled softdevice hex. 
#### d. set SOFTDEVICE_CODE, set softdevice_code. Refer to: 
```
nrfutil pkg generate --help
```
At this time of writing, one snippet of output of above command looks like in below, here you can chose the SOFTDEVICE_CODE according to 
the softdevice version you use.
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
#### e. set output ZIP_DIR, set output directory of zip package used to flash OTA.

#### Below is an example to set env_variable.bat
```
:: set installed NRF5 SDK path
SET SDK_ROOT=D:\Nordic\nRF5SDK16-0098a08e2

:: set your compiled application hex path
SET APP_HEX=D:\Nordic\nRF5SDK16-0098a08e2\examples\ble_peripheral\ble_app_beacon\pca10040\s132\armgcc\_build\nrf52832_xxaa.hex

:: set where precompiled Nordic's sofdevice path
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

### 2. Generate public and private key 
```
00_generate_private_public_keys.bat
```
This will generate keys that later will be compiled with bootloader and dfu-zipper.

### 3. Make bootloader 
```
01_make_bootloader.bat
```
This scripts will copy generated private key to %SDK_ROOT%\examples\dfu\dfu_public_key.c. Then execute make to build secure_bootloader using %SDK_ROOT%\examples\dfu\secure_bootloader\pca10040_s132_ble\armgcc\, then copy the hex file to %BOOTLOADER_DIR% and rename it as bootloader.hex. 

### 4. Flash SD and bootloader
```
02_flash_SD_and_bootloader
```
This will merge softdevice and bootloader together, then flash it into nrf52 chip using nrfjprog on SWD interface. Make sure your nrf52 is connected.

### 5. Flash application and settings
```
03_flash_app_and_setting
```
This will merge your application and application.settings hex together and flash it into nrf52. Settings.hex is needed by bootloader to correctly startups your application. Refer to [this](https://github.com/gamnes/nRF52832-buttonless-dfu-development-tutorial#step-4--create-a-product-release-image-including-all-components).
### 6. Generate DFU zip package
```
04_dfu_zipper
```
Finnaly to make you able to update your nrf52 by OTA, you need a zipped package containing softdevice and application.

At this momment, these scripts are lack of error checking, so be carefull to put your file and set the path to the file in user_variable.bat. 

