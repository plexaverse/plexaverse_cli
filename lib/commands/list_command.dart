import 'package:args/command_runner.dart';
import 'package:plexaverse_cli/core/component_registry.dart';

class ListCommand extends Command<int> {
  @override
  String get name => 'list';

  @override
  String get description => 'List available Plexaverse components.';

  @override
  Future<int> run() async {
    final components = ComponentRegistry.list();
    for (final c in components) {
      print('${c.name} - ${c.description} [${c.category}]');
    }
    return 0;
  }
}
