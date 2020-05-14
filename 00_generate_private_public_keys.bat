call env_variable.bat

@echo off

:: # Check to make sure nrfutil is installed before moving on
WHERE >nul 2>nul nrfutil
IF %ERRORLEVEL% NEQ 0 (
ECHO "nrfutil was not found in PATH, please install using pip install"
goto :end
)

mkdir %KEY_DIR%

:: Generate private key - ref http://infocenter.nordicsemi.com/topic/com.nordic.infocenter.tools/dita/tools/nrfutil/nrfutil_keys_generate_display.html?cp=5_5_5
:: and http://infocenter.nordicsemi.com/topic/com.nordic.infocenter.sdk5.v15.0.0/lib_bootloader_dfu_keys.html?cp=4_0_0_3_5_1_3
echo Generate a private key in %KEY_DIR%\dfu_private.key
nrfutil keys generate %KEY_DIR%\dfu_private.key

echo Write the public key that corresponds to the generated private key
echo to the file public_key.c (in code format)
nrfutil keys display --key pk --format code %KEY_DIR%\dfu_private.key --out_file %KEY_DIR%\dfu_public_key.c

:end
pause