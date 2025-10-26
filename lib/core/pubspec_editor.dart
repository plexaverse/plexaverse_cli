import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class PubspecEditor {
  static Future<void> addDependency({
    required String package,
    String? version,
    bool dev = false,
    bool useFlutter = true,
  }) async {
    final tool = useFlutter ? 'flutter' : 'dart';
    final args = ['pub', 'add', if (dev) '-d', if (version != null) '$package:$version' else package];

    final result = await Process.run(tool, args);
    if (result.exitCode != 0) {
      stderr.writeln('pub add failed, falling back to YAML edit: ${result.stderr}');
      _editPubspecYaml(package: package, version: version, dev: dev);
      // Resolve dependencies
      await Process.run(tool, ['pub', 'get']);
    }
  }

  static void _editPubspecYaml({required String package, String? version, bool dev = false}) {
    final file = File('pubspec.yaml');
    if (!file.existsSync()) throw Exception('pubspec.yaml not found');
    final content = file.readAsStringSync();
    final editor = YamlEditor(content);

    final section = dev ? 'dev_dependencies' : 'dependencies';
    YamlMap? root = loadYaml(content);
    final existing = root?[section] as YamlMap?;
    final constraint = version ?? 'any';

    if (existing == null) {
      editor.update([section], {package: constraint});
    } else {
      final map = Map.of(existing);
      map[package] = constraint;
      editor.update([section], map);
    }

    file.writeAsStringSync(editor.toString());
  }
}
