# Wolfenstein 3D Build with DOSBox-X and Borland C++ on GitHub Actions

This repository contains a setup to build the classic Wolfenstein 3D shareware source code using DOSBox-X and Borland C++ within a GitHub Actions pipeline. The built executable can then be run using js-dos, making it accessible through a web browser.

## Prerequisites

Before you start, ensure you have the following:

- The Wolfenstein 3D shareware source code.
- Borland C++ compiler files.

## Repository Structure

- `WOLFSRC/`: Directory containing the Wolfenstein 3D source code.
- `BORLANDC/`: Directory containing Borland C++ compiler files.
- `.github/workflows/build.yml`: GitHub Actions workflow file.
- `autoexec.bat`: Batch file to automate the build process in DOSBox-X.

## Setup Instructions

### Step 1: Clone the Repository

```bash
git clone https://github.com/your-username/wolf3d-dosbox-build.git
cd wolf3d-dosbox-build
```

### Step 2: Add Source Code and Compiler

Place the Wolfenstein 3D source code in the `WOLFSRC/` directory and the Borland C++ files in the `BORLANDC/` directory.

### Step 3: Configure GitHub Actions

The `.github/workflows/build.yml` file contains the GitHub Actions configuration. It sets up DOSBox-X, mounts the necessary directories, and runs the `autoexec.bat` file to build the project.

### Step 4: Review and Modify `autoexec.bat`

Ensure that the `autoexec.bat` file contains the correct commands to build the project using Borland C++. Here is the example content:

```bat
@echo on
setlocal

REM Mount the current directory as C:
mount c .

REM Change to the source directory
c:
cd \WOLFSRC

REM Set up the environment for Borland C++
SET PATH=c:\BORLANDC\BIN;%PATH%
SET INCLUDE=c:\BORLANDC\INCLUDE
SET LIB=c:\BORLANDC\LIB

REM Compile the project and log output
echo Compiling Wolf3D...
BC /b wolf3d.prj > c:\WOLF3D\build_log.txt 2>&1

REM Check if compilation was successful
if %errorlevel% neq 0 (
    echo Compilation failed. Check build_log.txt for details.
    type c:\WOLF3D\build_log.txt
    exit /b %errorlevel%
)

REM Copy the compiled executable and required files to the output directory
xcopy \WOLFSRC\OBJ\*.exe \WOLF3D /Y

REM End of batch file
echo Build process completed.
pause
exit
```

### Step 5: Push Changes to GitHub

```bash
git add .
git commit -m "Initial commit"
git push origin main
```

### Step 6: Trigger GitHub Actions

GitHub Actions will automatically trigger the workflow on push. You can check the progress and logs in the Actions tab of your repository.

## Output

After a successful build, the compiled executable will be available in the `WOLF3D` directory. You can use js-dos to run the executable in a web browser.

## Running with js-dos

To run the compiled executable using js-dos, follow these steps:

1. Host the compiled executable and required files on a web server.
2. Use the js-dos library to load and run the executable in a browser.

Here is an example of how to set up js-dos:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wolfenstein 3D</title>
    <script src="https://js-dos.com/6.22/js-dos.js"></script>
</head>
<body>
    <div id="jsdos" style="width: 640px; height: 480px;"></div>
    <script>
        Dos(document.getElementById("jsdos")).then(dos => {
            dos.run("./path-to-your-wolf3d-executable.zip");
        });
    </script>
</body>
</html>
```

Replace `./path-to-your-wolf3d-executable.zip` with the path to your zipped Wolfenstein 3D executable and required files.

## License

This project is licensed under the [GNU General Public License](LICENSE).

## Contributing

Feel free to open issues or pull requests if you find any bugs or have suggestions for improvements.

## Acknowledgements

- [DOSBox-X](https://dosbox-x.com/)
- [Borland C++](https://en.wikipedia.org/wiki/Borland_C%2B%2B)
- [Wolfenstein 3D](https://en.wikipedia.org/wiki/Wolfenstein_3D)
