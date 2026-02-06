@echo off
REM ───────────────────────────────────────────────────────────────
REM Flask + BrowserSync Dev Environment Launcher (Windows .bat)
REM Requires: Anaconda, Flask, BrowserSync (npm install -g browser-sync)
REM ───────────────────────────────────────────────────────────────

REM Step 1: Activate the base Anaconda environment
call "%USERPROFILE%\AppData\Local\anaconda3\Scripts\activate.bat" base

REM Step 2: Change to your Flask app directory
cd /d "C:\path\to\your\project"

REM Step 3: Start Flask app in a new command window
REM Note: Replace `run_app.py` with your actual Flask entry point
start cmd /k "set FLASK_APP=run_app.py && set FLASK_ENV=development && flask run --host=0.0.0.0 --port=5000"

REM Step 4: Start BrowserSync for live reload on templates and static assets
REM Note: Adjust file globs if needed
browser-sync start --proxy "127.0.0.1:5000" ^
  --port 3000 ^
  --files "templates/**/*.html, static/css/**/*.css, static/js/**/*.js" ^
  --no-ui --no-notify --logLevel "debug"

pause
