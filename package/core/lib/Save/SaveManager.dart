import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum SaveType {
  Config,
  Script,
  Resource,
}

class SaveManager {
  SaveManager._make() {}
  static final _inst = SaveManager._make();

  factory SaveManager() => _inst;

  Future<String> get_PathDocument() async {
    Directory dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<void> save_fileFromMap({required SaveType type, required Map map}) async {
    String filePath = await get_PathDocument();

    switch (type) {
      case SaveType.Config:
        {
        filePath += "ConfigInfo.txt";
          File file = File(filePath);
          file.writeAsString(jsonEncode(map));
        }
        break;
      case SaveType.Script:
        {
          filePath += "ScriptInfo.txt";
          File file = File(filePath);
          file.writeAsString(jsonEncode(map));
        }
        break;
      case SaveType.Resource:
        {
          filePath += "ResourceInfo.txt";
          File file = File(filePath);
          file.writeAsString(jsonEncode(map));
        }
        break;
    }
  }

  load_file({required SaveType type}) {
    var contents;

    return contents;
  }
}
