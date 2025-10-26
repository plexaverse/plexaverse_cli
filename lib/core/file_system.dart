import 'dart:io';

class FileSystem {
  static void ensureDir(Directory dir) {
    if (!dir.existsSync()) dir.createSync(recursive: true);
  }

  static void writeFile(File file, String contents, {bool overwrite = false}) {
    if (file.existsSync() && !overwrite) return;
    ensureDir(file.parent);
    file.writeAsStringSync(contents);
  }
}
