call env_variable.bat

@echo off

:: # Check to make sure nrfjprog is installed before moving on
WHERE >nul 2>nul nrfjprog
IF %ERRORLEVEL% NEQ 0 (
ECHO "nrfjprog was not found in PATH, please install using windows installed as found on nordicsemi.com"
goto :end
)

:: # Check to make sure mergehex is installed before moving on
WHERE >nul 2>nul mergehex
IF %ERRORLEVEL% NEQ 0 (
ECHO "mergehex was not found in PATH, please install using windows installed as found on nordicsemi.com"
goto :end
)

echo "## Looking to make sure s132_nrf52_7.0.1_softdevice.hex exists"
if not exist %SOFTDEVICE_HEX% (
echo "#### s132 hex file does not exist! Make sure the softdevice is in the same folder as this script!"
goto :end
)
echo.

echo "## Looking to make sure %BOOTLOADER_DIR%\bootloader.hex exists"
if not exist %BOOTLOADER_DIR%\bootloader.hex (
echo "#### %BOOTLOADER_DIR%\bootloader.hex file does not exist! Please make sure its compiled, copied, and renamed into this folder!"
goto :end
)
echo.

echo "## Merging %SOFTDEVICE_HEX% and %BOOTLOADER_DIR%\bootloader.hex, then flashing it to nRF52-DK; make sure the DK is powered on and connected to the PC"
mkdir %HEX_DIR%
mergehex -m %SOFTDEVICE_HEX% %BOOTLOADER_DIR%\bootloader.hex -o %HEX_DIR%\merged_SD_bootloader.hex
nrfjprog --program %HEX_DIR%\merged_SD_bootloader.hex --chiperase
nrfjprog -r
echo.


echo "## Please power cycle the DK and then with nRF Connect, make sure the board is in bootloader mode and ADV as DfuTarg"
echo.

:end
pause