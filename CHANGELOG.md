# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-09-21

### Added
- Initial release of Plexaverse CLI
- `init` command to initialize Plexaverse in Flutter projects
- `add` command to add components to projects
- `list` command to show available components
- `update` command (stub implementation)
- Component registry with button and card components
- Flutter project detection
- Automatic dependency management
- Configuration file support (plexaverse.json)

### Components
- **Button**: Material 3 friendly button wrapper with variants
- **Card**: Card with sensible padding defaults

### Technical Features
- Dart-based CLI using args package
- Cross-platform support
- Error handling and validation
- File system operations with overwrite protection
