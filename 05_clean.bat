call env_variable.bat

rmdir /Q /S %BOOTLOADER_DIR%
rmdir /Q /S %HEX_DIR%
rmdir /Q /S %KEY_DIR%
rmdir /Q /S %ZIP_DIR%

pause