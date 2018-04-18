error, 防止错误点击

reg query HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run

:: /v value  /t type  /d data /f force?
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v baidujingyan /t REG_SZ /d c:\windows\system32\notepad.exe /f

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /v baidujingyan /f

:: export setting ------> .reg file
reg export HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run c:\1.reg

:: import file
reg import c:\1.reg


:: ===================  =====================


reg add HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\KeyBoard\ Layout\ /vScancode \ map /t REG_SZ /d 0000 00 00 00 00 00 00 00 00 0008 03 00 00 00 1D 00 3A 00 0010 3A 00 1D 00 00 00 00 00 0018 /f

:: ; how to do this
:: 点击Win+R键
:: 在输入框键入regedit，打开注册表
:: 进入HKEY_LOCAL_MACHINE -> System -> CurrentControlSet -> Control -> KeyBoard Layout。记住，一定是keyBoard Layout，而不是KeyBoard Layouts
:: 右键菜单，然后选择New -> Binary value
:: 重命名New Value #1 -> Scancode Map
:: 右键菜单Scancode Map -> Modify
:: 输入如下值，保存

:: 0000 00 00 00 00 00 00 00 00
:: 0008 03 00 00 00 1D 00 3A 00
:: 0010 3A 00 1D 00 00 00 00 00
:: 0018
