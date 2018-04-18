@echo off
:: This batch file will create a web page, then use
:: Visual Basic Scripting and the Windows Scripting Host
:: to launch Internet Explorer to show that page.
:: Values entered in the web page will be read via
:: scripting, then will be saved as %TEMP%\USERIN.BAT
:: After the USERIN.BAT is CALLed from the main batch
:: (and assuming there is enough room in the environment)
:: environmental variables USERNAME and PASSWORD will be set.
:: It is your responsibility to delete the USERIN.BAT
:: after you CALL it. Because this batch file needs to
:: find itself, you must be sure to call it from your
:: main batch file with a full path and file name.
:: Written and tested under Win95. NT/2000/XP users will
:: have to do some modifications before it will work.
:: For example, %0 changes to %f0
:: Public Domain. Use freely. No guarantees! It may not work!
:: http://www.ericphelps.com

cls
echo Please enter your user name and password in the entry box...
:: See if I can find myself
If not exist %0 goto ERROR
:: Make the web page
type %0 | find "    " | find /v "     " | find /v "Not Me!" > %TEMP%\UserIn.htm
:: Make the VBS code
type %0 | find "     " | find /v "      " | find /v "Not Me!" > %TEMP%\UserIn.vbs
:: Run the vbs code
start /w wscript.exe %TEMP%\UserIn.vbs
:: At this point a batch file "%TEMP%\UserIn.bat" exists and you should
:: call it! If you don't call the batch file here and instead opt to
:: call it from another batch file, be sure NOT to delete it in the
:: "Clean up" code section below!
call %TEMP%\UserIn.bat
echo Your user name is %USERNAME%
echo Your password is %PASSWORD%
:: Clean up
del %TEMP%\UserIn.vbs
del %TEMP%\UserIn.htm
del %TEMP%\UserIn.bat
goto DONE

:ERROR
cls
echo %0 is not the full path and file name
echo for the batch file. You MUST call this
echo batch file with a full path and file name.
goto DONE

:HTML
:: All HTML code MUST be indented exactly four spaces.
:: NOTHING else in this batch file may be indented four spaces.
    <html><body><form>User Name:
    <br><input type=text name=username tabindex=1>
    <br>Password:
    <br><input type=password name=password>
    <br><input type=button
    language=vbscript name=submit
    value=OK onclick='submit.value="Done"'>
    </form></body></html>

:VBS
:: All VBS code MUST be indented exactly five spaces.
:: NOTHING else in this batch file may be indented five spaces.
     Set fs = CreateObject("Scripting.FileSystemObject")
     strFile = fs.GetAbsolutePathName(fs.BuildPath(fs.GetSpecialFolder(2), "UserIn.htm"))
     Set web = CreateObject("InternetExplorer.Application")
     web.Offline = True
     web.AddressBar = False
     web.Height = 200
     web.Width = 250
     web.MenuBar = False
     web.StatusBar = False
     web.Silent = True
     web.ToolBar = False
     web.Navigate strFile
     Do While web.Busy
     Loop
     On Error Resume Next
     Set doc = Nothing
     Do Until Not doc Is Nothing
     Set doc = web.Document
     Loop
     doc.Forms(0).elements("username").focus
     web.Visible = True
     Err.Clear
     Do Until doc.Forms(0).elements("submit").Value <> "OK"
     Wscript.Sleep 100
     If Err.Number <> 0 Then Exit Do
     Loop
     strFile = fs.GetAbsolutePathName(fs.BuildPath(fs.GetSpecialFolder(2), "UserIn.bat"))
     Set ts = fs.OpenTextFile(strFile, 2, True)
     ts.WriteLine "SET USERNAME=" & doc.Forms(0).elements("username").Value
     ts.WriteLine "SET PASSWORD=" & doc.Forms(0).elements("password").Value
     ts.Close
     web.Quit

:DONE

Enter a string or /regular expression/
pause
