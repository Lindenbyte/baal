@echo off

set SRC=./src
set DIR=./bin
set EXE=baal.exe

set VETS=-vet-style -vet-semicolon
set FLAGS=%VETS%

if "%1"=="clean" if exist "%DIR%" (
	rmdir /s /q "%DIR%"
	(goto NO_RUN)
)

if "%1"=="release" (
	set FLAGS=-o:speed %FLAGS%
) else (
	set FLAGS=-debug %FLAGS%
)

echo [Building]
	if not exist "%DIR%" (mkdir "%DIR%")
	@REM // TODO ADD SOKOL COMP HERE
	odin build %SRC% -out:%DIR%/%EXE% %FLAGS%

if not "%1"=="run" if not "%2"=="run" (goto NO_RUN)
	echo [Running]
	call "%DIR%/%EXE%"

:NO_RUN