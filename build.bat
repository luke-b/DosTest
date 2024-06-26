@echo on
setlocal

REM Set up the environment for Borland C++
SET PATH=c:\BORLANDC\BIN;%PATH%
SET INCLUDE=c:\BORLANDC\INCLUDE
SET LIB=c:\BORLANDC\LIB

REM Change to the source directory
cd \WOLFSRC

REM Compile the project and log output
echo Compiling Wolf3D...
bcc @wolf3d.prj > c:\WOLF3D\build_log.txt 2>&1

REM Check if compilation was successful
if %errorlevel% neq 0 (
    echo Compilation failed. Check build_log.txt for details.
    type c:\WOLF3D\build_log.txt
    exit /b %errorlevel%
)

REM Copy the compiled executable and required files to the output directory
xcopy \WOLFSRC\*.exe \WOLF3D /Y

REM End of batch file
echo Build process completed.
pause
exit
