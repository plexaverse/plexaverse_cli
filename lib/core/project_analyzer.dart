import 'dart:io';
import 'package:yaml/yaml.dart';

class ProjectAnalyzer {
  final Directory root;
  ProjectAnalyzer(this.root);

  File get pubspec => File('${root.path}/pubspec.yaml');

  bool get hasPubspec => pubspec.existsSync();

  bool get isFlutterProject {
    if (!hasPubspec) return false;
    final yaml = loadYaml(pubspec.readAsStringSync());
    final deps = (yaml?['dependencies'] ?? {}) as Map?;
    return deps != null && deps.containsKey('flutter');
  }

  Directory resolveTargetDir({String fallback = 'lib/widgets'}) {
    // Future: read plexaverse.json for overrides
    return Directory('${root.path}/$fallback');
  }
}
