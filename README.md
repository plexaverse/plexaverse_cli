# Plexaverse CLI

A powerful command-line tool for managing Flutter UI components. Easily add pre-built widgets like buttons, cards, and more to your Flutter projects.

## 🚀 Features

- **Easy Component Management**: Add Flutter UI components with a single command
- **Flutter Project Detection**: Automatically detects Flutter projects
- **Component Registry**: Pre-built components ready to use
- **Dependency Management**: Automatically handles package dependencies
- **Configuration**: Customizable component directories and settings

## 📦 Installation

### Option 1: Automatic Installation (Recommended)

### macOS / Linux
```bash
curl -sL https://raw.githubusercontent.com/plexaverse/plexaverse_cli/main/install.sh | bash
```

### Windows
Run the following command in PowerShell (Admin not required):
```powershell
powershell -ExecutionPolicy ByPass -c "irm https://raw.githubusercontent.com/plexaverse/plexaverse_cli/main/install.ps1 | iex"
```

# Or download and run manually
wget https://raw.githubusercontent.com/plexaverse/plexaverse_cli/main/install.sh
chmod +x install.sh
./install.sh
```

**Alternative: Keep Terminal Open**
```bash
# Download and run the installation script (keeps terminal open)
curl -fsSL https://raw.githubusercontent.com/plexaverse/plexaverse_cli/main/install-keep-terminal.sh | bash

# Or download and run manually
wget https://raw.githubusercontent.com/plexaverse/plexaverse_cli/main/install-keep-terminal.sh
chmod +x install-keep-terminal.sh
./install-keep-terminal.sh
```

### Option 2: Manual Installation from pub.dev

```bash
# Install the CLI globally
dart pub global activate plexaverse_cli

# Add to PATH (required for all users)
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Make PATH change permanent by adding to your shell config file:
# For zsh (macOS default): echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.zshrc
# For bash: echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.bashrc
# For fish: echo 'set -gx PATH $PATH $HOME/.pub-cache/bin' >> ~/.config/fish/config.fish

# Verify installation
plexaverse --help
```

### Option 3: Install from GitHub

```bash
# Install from GitHub
dart pub global activate --source git https://github.com/plexaverse/plexaverse_cli.git

# Add to PATH (required)
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Verify installation
plexaverse --help
```

### Option 4: Install from Local Path

```bash
# Install from local path
dart pub global activate --source path /path/to/plexaverse_cli

# Add to PATH (required)
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Verify installation
plexaverse --help
```

### Option 5: Direct Download (No PATH setup needed)

```bash
# Download executable from GitHub releases
# Add to PATH or run directly
./plexaverse --help
```

## 🛠️ Usage

### Initialize Plexaverse in your Flutter project

```bash
cd your_flutter_project
plexaverse init
```

This creates a `plexaverse.json` configuration file:

```json
{
  "version": "0.1.0",
  "directories": {
    "components": "lib/widgets",
    "examples": "lib/examples"
  },
  "theme": {
    "material3": true
  }
}
```

### List available components

```bash
plexaverse list
```

### Add a component to your project

```bash
plexaverse add button
plexaverse add card
```

### Update components

```bash
plexaverse update --all
```

## 📋 Available Components

| Component | Description | Category |
|-----------|-------------|----------|
| `button` | Material 3 friendly button wrapper with variants | interactive |
| `card` | Card with sensible padding defaults | display |

## 🔧 Commands

### `plexaverse init`
Initialize Plexaverse in the current Flutter project.

### `plexaverse add <component>`
Add a Plexaverse component to the current Flutter project.

**Options:**
- `--example, -e`: Include example usage where available
- `--overwrite`: Overwrite existing files if present

### `plexaverse list`
List all available Plexaverse components.

### `plexaverse update`
Update a component or all components to the latest version.

**Options:**
- `--all`: Update all installed components

## 🏗️ Project Structure

```
lib/
├── commands/          # CLI command implementations
├── core/             # Business logic and utilities
│   ├── component_registry.dart  # Component definitions
│   ├── file_system.dart         # File operations
│   ├── project_analyzer.dart    # Flutter project detection
│   └── pubspec_editor.dart      # Dependency management
└── models/           # Data structures
    └── component.dart # Component-related models
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [Dart](https://dart.dev/)
- Uses [args](https://pub.dev/packages/args) for command-line argument parsing
- Inspired by modern CLI tools and Flutter best practices

## 🔧 Troubleshooting

### CLI Command Not Found

If you get `command not found: plexaverse` after installation:

1. **Check if the executable exists:**
   ```bash
   ls -la $HOME/.pub-cache/bin/plexaverse
   ```

2. **Check your PATH:**
   ```bash
   echo $PATH | grep pub-cache
   ```

3. **Add to PATH temporarily:**
   ```bash
   export PATH="$PATH":"$HOME/.pub-cache/bin"
   ```

4. **Add to PATH permanently:**
   ```bash
   # For zsh (macOS default)
   echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.zshrc
   source ~/.zshrc
   
   # For bash
   echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.bashrc
   source ~/.bashrc
   
   # For fish shell
   echo 'set -gx PATH $PATH $HOME/.pub-cache/bin' >> ~/.config/fish/config.fish
   ```

5. **Verify installation:**
   ```bash
   which plexaverse
   plexaverse --help
   ```

### Alternative: Use Full Path

If PATH issues persist, you can always run the CLI using the full path:
```bash
$HOME/.pub-cache/bin/plexaverse --help
```

## 📞 Support

- 📧 Email: [contact@plexaverse.com]

---

Made with ❤️ for the Flutter community
