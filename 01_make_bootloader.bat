call env_variable.bat

@echo off
:: # Check to make sure make is installed before moving on
WHERE >nul 2>nul make
IF %ERRORLEVEL% NEQ 0 (
ECHO "make was not found in PATH, please install using windows installed as found on nordicsemi.com"
goto :end
)

:: # Check to make sure make is installed before moving on
WHERE >nul 2>nul arm-none-eabi-gcc
IF %ERRORLEVEL% NEQ 0 (
ECHO "arm-none-eabi-gcc was not found in PATH, please install using windows installed as found on nordicsemi.com"
goto :end
)

echo "## Looking to make sure %KEY_DIR%\dfu_public.key exists"
if not exist %KEY_DIR%\dfu_public_key.c (
echo "#### %KEY_DIR%\dfu_public_key.c file does not exist! Make sure to generate keys firsts!"
goto :end
)
echo.

mkdir %BOOTLOADER_DIR%

echo "## copying %KEY_DIR%\dfu_public_key.c to %SDK_ROOT%\examples\dfu\dfu_public_key.c"
copy %KEY_DIR%\dfu_public_key.c %SDK_ROOT%\examples\dfu\dfu_public_key.c
:: make -C D:\Nordic\nRF5SDK16-0098a08e2\examples\dfu\secure_bootloader\pca10040_s132_ble\armgcc\
make -C %SDK_ROOT%\examples\dfu\secure_bootloader\pca10040_s132_ble\armgcc
copy %SDK_ROOT%\examples\dfu\secure_bootloader\pca10040_s132_ble\armgcc\_build\nrf52832_xxaa_s132.hex %BOOTLOADER_DIR%\bootloader.hex

:end
pause