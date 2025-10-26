 
import 'package:plexaverse_cli/models/component.dart';

const _buttonTemplate = r'''
import 'package:flutter/material.dart';

class PxButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  const PxButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: style,
      child: child,
    );
  }
}
''';

const _cardTemplate = r'''
import 'package:flutter/material.dart';

class PxCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const PxCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
''';

class ComponentRegistry {
  static final Map<String, ComponentDescriptor> _components = {
    'button': ComponentDescriptor(
      name: 'button',
      description: 'Material 3 friendly button wrapper with variants.',
      category: 'interactive',
      files: ['lib/widgets/px_button.dart'],
      dependencies: [],
      templates: {
        'lib/widgets/px_button.dart': _buttonTemplate,
      },
    ),
    'card': ComponentDescriptor(
      name: 'card',
      description: 'Card with sensible padding defaults.',
      category: 'display',
      files: ['lib/widgets/px_card.dart'],
      dependencies: [],
      templates: {
        'lib/widgets/px_card.dart': _cardTemplate,
      },
    ),
  };

  static List<ComponentDescriptor> list() => _components.values.toList();
  static ComponentDescriptor? get(String name) => _components[name];
}
