call env_variable.bat

@echo off
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "fullstamp=%YY%%MM%%DD%-%HH%%Min%%Sec%"
set "datestamp=%YY%%MM%%DD%"
echo fullstamp: "%fullstamp%"

echo "## Looking to make sure %ZIP_DIR% exists"
if not exist %ZIP_DIR% mkdir %ZIP_DIR%

nrfutil pkg generate --application %APP_HEX% --application-version 1 --application-version-string "1.0.0" --hw-version 52 --sd-req %SOFTDEVICE_CODE% --sd-id %SOFTDEVICE_CODE% --softdevice %SOFTDEVICE_HEX% --key-file %KEY_DIR%\dfu_private.key %ZIP_DIR%\dfu_%datestamp%.zip
pause