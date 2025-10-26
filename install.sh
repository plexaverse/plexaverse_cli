#!/bin/bash

# Plexaverse CLI Installation Script
# This script installs Plexaverse CLI and sets up the PATH automatically

set -e

echo "🚀 Installing Plexaverse CLI..."

# Detect shell
SHELL_NAME=$(basename "$SHELL")
echo "Detected shell: $SHELL_NAME"

# Install the CLI
echo "📦 Installing CLI from pub.dev..."
dart pub global activate plexaverse_cli

# Add to PATH
echo "🔧 Setting up PATH..."

case $SHELL_NAME in
    "zsh")
        SHELL_CONFIG="$HOME/.zshrc"
        PATH_LINE='export PATH="$PATH":"$HOME/.pub-cache/bin"'
        ;;
    "bash")
        SHELL_CONFIG="$HOME/.bashrc"
        PATH_LINE='export PATH="$PATH":"$HOME/.pub-cache/bin"'
        ;;
    "fish")
        SHELL_CONFIG="$HOME/.config/fish/config.fish"
        PATH_LINE='set -gx PATH $PATH $HOME/.pub-cache/bin'
        ;;
    *)
        echo "⚠️  Unsupported shell: $SHELL_NAME"
        echo "Please manually add the following to your shell config:"
        echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"'
        exit 1
        ;;
esac

# Check if PATH is already configured
if grep -q "pub-cache/bin" "$SHELL_CONFIG" 2>/dev/null; then
    echo "✅ PATH already configured in $SHELL_CONFIG"
else
    echo "📝 Adding PATH configuration to $SHELL_CONFIG"
    echo "" >> "$SHELL_CONFIG"
    echo "# Plexaverse CLI" >> "$SHELL_CONFIG"
    echo "$PATH_LINE" >> "$SHELL_CONFIG"
fi

# Add to current session
export PATH="$PATH":"$HOME/.pub-cache/bin"

echo "✅ Installation complete!"
echo ""
echo "🔍 Verifying installation..."
if command -v plexaverse >/dev/null 2>&1; then
    echo "✅ Plexaverse CLI is now available!"
    plexaverse --help
else
    echo "❌ Installation failed. Please check the error messages above."
    exit 1
fi

echo ""
echo "🎉 Success! You can now use 'plexaverse' from anywhere."
echo "💡 If you open a new terminal, the CLI will be available automatically."
echo "🔄 If not, run: source $SHELL_CONFIG"
