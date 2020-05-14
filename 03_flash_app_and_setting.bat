call env_variable.bat

nrfutil settings generate --family NRF52 --application %APP_HEX% --application-version 1 --bootloader-version 1 --bl-settings-version 1 %SETTING_HEX%
mergehex.exe -m %APP_HEX% %SETTING_HEX% -o %APP_SETTING_HEX%
nrfjprog.exe --program %APP_SETTING_HEX% --sectorerase -r

pause