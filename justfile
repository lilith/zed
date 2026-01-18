# Zed development justfile
# Run these commands from PowerShell on Windows

# Default recipe - show available commands
default:
    @just --list

# Build Zed for Windows (release)
win-build:
    cargo build --release

# Build Zed for Windows (debug)
win-build-debug:
    cargo build

# Check that code compiles (faster than full build)
win-check:
    cargo check --package fs --package worktree --package settings_content

# Kill running Zed, install new build, and restart
win-install: win-build
    powershell -Command "Stop-Process -Name 'Zed' -Force -ErrorAction SilentlyContinue; Start-Sleep -Seconds 1"
    powershell -Command "Copy-Item -Force 'target\\release\\zed.exe' '$env:LOCALAPPDATA\\Programs\\Zed\\Zed.exe'"
    powershell -Command "Start-Process '$env:LOCALAPPDATA\\Programs\\Zed\\Zed.exe'"

# Kill running Zed, install debug build, and restart
win-install-debug: win-build-debug
    powershell -Command "Stop-Process -Name 'Zed' -Force -ErrorAction SilentlyContinue; Start-Sleep -Seconds 1"
    powershell -Command "Copy-Item -Force 'target\\debug\\zed.exe' '$env:LOCALAPPDATA\\Programs\\Zed\\Zed.exe'"
    powershell -Command "Start-Process '$env:LOCALAPPDATA\\Programs\\Zed\\Zed.exe'"

# Just kill and restart Zed (no rebuild)
win-restart:
    powershell -Command "Stop-Process -Name 'Zed' -Force -ErrorAction SilentlyContinue; Start-Sleep -Seconds 1"
    powershell -Command "Start-Process '$env:LOCALAPPDATA\\Programs\\Zed\\Zed.exe'"

# Kill Zed
win-kill:
    powershell -Command "Stop-Process -Name 'Zed' -Force -ErrorAction SilentlyContinue"

# Run Zed from target directory (doesn't replace installed version)
win-run:
    cargo run --release

# Run Zed debug build from target directory
win-run-debug:
    cargo run

# Clean build artifacts
win-clean:
    cargo clean

# Run clippy
lint:
    ./script/clippy
