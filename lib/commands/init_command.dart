import 'dart:convert';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:plexaverse_cli/core/project_analyzer.dart';

class InitCommand extends Command<int> {
  @override
  String get name => 'init';

  @override
  String get description => 'Initialize Plexaverse in the current Flutter project.';

  @override
  Future<int> run() async {
    final analyzer = ProjectAnalyzer(Directory.current);
    if (!analyzer.isFlutterProject) {
      usageException('Not a Flutter project (missing flutter dependency in pubspec.yaml).');
    }
    final config = {
      'version': '0.1.0',
      'directories': {'components': 'lib/widgets', 'examples': 'lib/examples'},
      'theme': {'material3': true}
    };
    final file = File('plexaverse.json');
    file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(config));
    stdout.writeln('Initialized plexaverse.json');
    return 0;
  }
}
