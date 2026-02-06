# 🛠 myScripts

Centralized PowerShell automation and system utility repository.

This repository contains the PowerShell scripts and supporting logs used
to manage, deploy, clean, monitor, and maintain my development machine
--- including Flask/Django applications, Node-based builds, and CLI
automation tasks.

------------------------------------------------------------------------

## 📂 Repository Purpose

This repo functions as:

-   🖥 Local development automation toolkit\
-   🔁 Flask/Django application lifecycle manager\
-   🧹 Node build / clean / minify workflow runner\
-   📜 Structured logging and task history archive\
-   🧰 General CLI utility collection

If I run something more than twice, it becomes a script.

------------------------------------------------------------------------

## ⚙️ Example Structure

    myScripts/
    │
    ├── flask/
    │   ├── start-flask.ps1
    │   ├── restart-flask.ps1
    │
    ├── django/
    │   ├── start-django.ps1
    │   ├── migrate.ps1
    │
    ├── node/
    │   ├── build.ps1
    │   ├── clean.ps1
    │   ├── minify.ps1
    │
    ├── maintenance/
    │   ├── cleanup-temp.ps1
    │   ├── system-check.ps1
    │
    ├── logs/
    │   ├── build.log
    │   ├── flask.log
    │   └── system.log
    │
    └── README.md

(Adjust structure to match actual folders.)

------------------------------------------------------------------------

## 🚀 Example Usage

Run Flask App:

``` powershell
.\flask\start-flask.ps1
```

Run Django Migrations:

``` powershell
.\django\migrate.ps1
```

Clean and Rebuild Node Project:

``` powershell
.\node\clean.ps1
.\node\build.ps1
```

Run Maintenance Tasks:

``` powershell
.\maintenance\cleanup-temp.ps1
```

------------------------------------------------------------------------

## 📝 Logging

Most scripts generate logs in the `/logs` directory, including:

-   Execution timestamps\
-   Exit codes\
-   Build results\
-   Error output\
-   System state snapshots (when applicable)

This keeps troubleshooting predictable and repeatable.

------------------------------------------------------------------------

## 🔐 Environment

-   OS: Windows\
-   Shell: PowerShell 5+ / PowerShell Core\
-   Backend Frameworks: Flask, Django\
-   Build Tools: Node / npm

------------------------------------------------------------------------

## 🧠 Design Philosophy

-   Automation over repetition\
-   Logs over guesswork\
-   Scripts over manual terminal sessions\
-   Structured CLI workflows\
-   Development environment treated like production-lite

------------------------------------------------------------------------

## 🔮 Planned Enhancements

-   Parameterized script inputs\
-   Central configuration file for paths and environments\
-   Unified launcher script\
-   Scheduled task integration\
-   Improved error formatting and output styling\
-   Automatic environment detection

------------------------------------------------------------------------

This is a personal systems automation repository tailored to my
development workflow.
