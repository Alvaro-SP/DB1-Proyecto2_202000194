
@echo off
echo %~dp0
SET /P NOMBRE=WRITE COMMIT:
git add .
git commit -m "%NOMBRE%"
git push


