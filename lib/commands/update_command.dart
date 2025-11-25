import 'dart:convert';
import 'dart:io';
import 'package:args/command_runner.dart';

class UpdateCommand extends Command<int> {
  @override
  String get name => 'update';

  @override
  String get description => 'Update a component or all components to the latest version.';

  UpdateCommand() {
    argParser
      ..addFlag('all', help: 'Update all installed components.', defaultsTo: false);
  }

  @override
  Future<int> run() async {
    print('🔄 Updating Plexaverse CLI...');
    
    // 1. Update the CLI package
    final result = await Process.run('dart', ['pub', 'global', 'activate', 'plexaverse_cli']);
    if (result.exitCode != 0) {
      stderr.writeln('❌ Failed to update CLI:');
      stderr.writeln(result.stderr);
      return result.exitCode;
    }
    print(result.stdout);
    print('✅ CLI updated successfully.');

    // 2. Update plexaverse.json if it exists
    final configFile = File('plexaverse.json');
    if (configFile.existsSync()) {
      try {
        final content = configFile.readAsStringSync();
        final config = jsonDecode(content) as Map<String, dynamic>;
        
        // We can't easily know the *new* version of the CLI running in this process
        // (since we are running the old code). 
        // But we can try to parse the output of the activate command or just assume
        // the user will run init/update again if needed.
        // However, the user asked to "update the json created by init".
        // Let's try to fetch the version we just installed.
        
        // A simple way is to just run the *new* CLI to get its version.
        final versionResult = await Process.run('plexaverse', ['--version']);
        if (versionResult.exitCode == 0) {
           // Output format: "Plexaverse CLI version X.Y.Z"
           final versionOutput = versionResult.stdout.toString().trim();
           final versionMatch = RegExp(r'version\s+([\d\.]+)').firstMatch(versionOutput);
           if (versionMatch != null) {
             final newVersion = versionMatch.group(1);
             config['version'] = newVersion;
             configFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(config));
             print('✅ Updated plexaverse.json to version $newVersion');
           }
        }
      } catch (e) {
        stderr.writeln('⚠️  Failed to update plexaverse.json: $e');
      }
    }

    return 0;
  }
}
