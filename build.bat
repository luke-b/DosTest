@echo off

REM Set up the environment for Borland C++
SET PATH=c:\BORLANDC\BIN;%PATH%
SET INCLUDE=c:\BORLANDC\INCLUDE
SET LIB=c:\BORLANDC\LIB

REM Change to the source directory
cd \WOLFSRC

REM Compile the project
bcc @wolf3d.prj

REM Copy the compiled executable and required files to the output directory
xcopy \WOLFSRC\*.exe \WOLF3D /Y

REM End of batch file
echo Build process completed.
pause
exit