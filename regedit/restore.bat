@echo off
echo 'need administer privilege run'

:: keypath, keyvalue 都有空格, 需要引号
set KEYPATH=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout
set KEYVALUE=Scancode Map
reg delete "%KEYPATH%"  /v  "%KEYVALUE%"
pause

:: [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
:: "Scancode Map"=hex:00,00,00,00,00,00,00,00,03,00,00,00,1d,00,3a,00,3a,00,1d,00,00,00,00,00
