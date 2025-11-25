import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

class VersionManager {
  static String? _cachedVersion;

  static Future<String> getPackageVersion() async {
    if (_cachedVersion != null) return _cachedVersion!;

    try {
      final uri = await Isolate.resolvePackageUri(Uri.parse('package:plexaverse_cli/'));
      if (uri == null) {
        throw Exception('Could not resolve package URI');
      }
      
      final pubspecUri = uri.resolve('../pubspec.yaml');
      final file = File.fromUri(pubspecUri);
      if (!file.existsSync()) {
        throw Exception('pubspec.yaml not found at $pubspecUri');
      }
      
      final content = await file.readAsString();
      final yaml = loadYaml(content);
      _cachedVersion = yaml['version'] as String;
      return _cachedVersion!;
    } catch (e) {
      // Fallback or rethrow depending on needs. 
      // For now, returning a placeholder if we can't read it, 
      // but logging to stderr might be useful in debug.
      return '0.0.0-unknown'; 
    }
  }

  static Future<String?> getLatestVersion() async {
    try {
      final url = Uri.parse('https://pub.dev/api/packages/plexaverse_cli');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['latest']['version'] as String;
      }
    } catch (e) {
      // Fail silently or log if needed
    }
    return null;
  }
}
