import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:plexaverse_cli/core/component_registry.dart';
import 'package:plexaverse_cli/core/file_system.dart';
import 'package:plexaverse_cli/core/project_analyzer.dart';
import 'package:plexaverse_cli/core/pubspec_editor.dart';

class AddCommand extends Command<int> {
  @override
  String get name => 'add';

  @override
  String get description => 'Add a Plexaverse component to the current Flutter project.';

  AddCommand() {
    argParser
      ..addFlag('example', abbr: 'e', help: 'Include example usage where available.', defaultsTo: false)
      ..addFlag('overwrite', help: 'Overwrite existing files if present.', defaultsTo: false);
  }

  @override
  Future<int> run() async {
    final args = argResults!;
    final rest = args.rest;
    if (rest.isEmpty) usageException('Usage: plexaverse add <component> [--example] [--overwrite]');

    final name = rest.first;
    final descriptor = ComponentRegistry.get(name);
    if (descriptor == null) {
      stderr.writeln('Component "$name" not found. Try "plexaverse list".');
      return 1;
    }

    final analyzer = ProjectAnalyzer(Directory.current);
    if (!analyzer.isFlutterProject) {
      usageException('Not a Flutter project (missing flutter dependency in pubspec.yaml).');
    }

    // Write files
    for (final entry in descriptor.templates.entries) {
      final file = File(entry.key);
      FileSystem.writeFile(file, entry.value, overwrite: args['overwrite'] as bool);
      stdout.writeln('Wrote ${file.path}');
    }

    // Add dependencies
    for (final dep in descriptor.dependencies) {
      await PubspecEditor.addDependency(
        package: dep.name,
        version: dep.version,
        dev: dep.dev,
        useFlutter: true,
      );
      stdout.writeln('Ensured dependency ${dep.name}${dep.version != null ? " ${dep.version}" : ""}');
    }

    stdout.writeln('Component "$name" added.');
    return 0;
  }
}
