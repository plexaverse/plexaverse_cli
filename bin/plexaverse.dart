import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:plexaverse_cli/commands/init_command.dart';
import 'package:plexaverse_cli/commands/add_command.dart';
import 'package:plexaverse_cli/commands/list_command.dart';
import 'package:plexaverse_cli/commands/update_command.dart';
import 'package:plexaverse_cli/commands/update_command.dart';
import 'package:plexaverse_cli/core/version_manager.dart';

class PlexaverseCommandRunner extends CommandRunner<int> {
  PlexaverseCommandRunner()
      : super('plexaverse', 'Plexaverse CLI: Flutter UI components manager') {
    addCommand(InitCommand());
    addCommand(AddCommand());
    addCommand(ListCommand());
    addCommand(UpdateCommand());
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final result = await super.run(args);
      return result ?? 0;
    } on UsageException catch (e) {
      stderr.writeln(e);
      return 64; // usage error
    } catch (e) {
      stderr.writeln('Error: $e');
      return 1;
    }
  }
}

Future<void> main(List<String> args) async {
  if (args.contains('--version')) {
    final version = await VersionManager.getPackageVersion();
    stdout.write('Plexaverse CLI version $version');
    
    final latest = await VersionManager.getLatestVersion();
    if (latest != null && latest != version) {
      stdout.writeln(' (Latest: $latest)');
      stdout.writeln('Update available! Run "plexaverse update" to upgrade.');
    } else {
      stdout.writeln(' (Latest)');
    }
    exit(0);
  }
  final runner = PlexaverseCommandRunner();
  final exitCode = await runner.run(args);
  if (exitCode != 0) exit(exitCode);
}
