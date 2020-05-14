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

