# Plexaverse CLI Installation Script for Windows

Write-Host "🚀 Installing Plexaverse CLI..." -ForegroundColor Cyan

# Install the CLI using dart pub
Write-Host "📦 Installing CLI from pub.dev..." -ForegroundColor Yellow
try {
    dart pub global activate plexaverse_cli
}
catch {
    Write-Error "❌ Failed to install plexaverse_cli. Please ensure Dart is installed and available in your PATH."
    exit 1
}

# Setup PATH
Write-Host "🔧 Setting up PATH..." -ForegroundColor Yellow

$pubCachePath = "$env:LOCALAPPDATA\Pub\Cache\bin"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -notlike "*$pubCachePath*") {
    Write-Host "📝 Adding $pubCachePath to User PATH..." -ForegroundColor Green
    $newPath = "$currentPath;$pubCachePath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    $env:Path = "$env:Path;$pubCachePath" # Update current session
    Write-Host "✅ PATH updated successfully." -ForegroundColor Green
}
else {
    Write-Host "✅ PATH already configured." -ForegroundColor Green
}

Write-Host ""
Write-Host "✅ Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "🔍 Verifying installation..." -ForegroundColor Cyan

if (Get-Command plexaverse -ErrorAction SilentlyContinue) {
    Write-Host "✅ Plexaverse CLI is now available!" -ForegroundColor Green
    plexaverse --help
}
else {
    Write-Host "⚠️  Plexaverse CLI installed but not found in current session." -ForegroundColor Yellow
    Write-Host "🔄 Please restart your terminal to use the 'plexaverse' command." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎉 Success! You can now use 'plexaverse' from anywhere." -ForegroundColor Cyan
