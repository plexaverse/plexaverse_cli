# Plexaverse CLI

A powerful command-line tool for managing Flutter UI components. Easily add pre-built widgets like buttons, cards, and more to your Flutter projects.

## 🚀 Features

- **Easy Component Management**: Add Flutter UI components with a single command
- **Flutter Project Detection**: Automatically detects Flutter projects
- **Component Registry**: Pre-built components ready to use
- **Dependency Management**: Automatically handles package dependencies
- **Configuration**: Customizable component directories and settings

## 📦 Installation

### Option 1: Install from pub.dev (Recommended)

```bash
dart pub global activate plexaverse_cli
```

### Option 2: Install from GitHub

```bash
dart pub global activate --source git https://github.com/asangborkar/plexaverse_cli.git
```

### Option 3: Install from Local Path

```bash
dart pub global activate --source path /path/to/plexaverse_cli
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

## 📞 Support

- 📧 Email: [contact@plexaverse.com]

---

Made with ❤️ for the Flutter community
