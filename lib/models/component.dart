class ComponentDependency {
  final String name;
  final String? version; // e.g. ^1.2.3
  final bool dev;
  const ComponentDependency(this.name, {this.version, this.dev = false});
}

class ComponentDescriptor {
  final String name;
  final String description;
  final String category;
  final List<String> files; // logical file paths within lib/
  final List<ComponentDependency> dependencies;
  final Map<String, String> templates; // filePath -> template content

  const ComponentDescriptor({
    required this.name,
    required this.description,
    required this.category,
    required this.files,
    required this.dependencies,
    required this.templates,
  });
}
