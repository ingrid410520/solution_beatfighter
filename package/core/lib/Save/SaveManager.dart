import 'dart:convert';
import 'dart:io';
import 'package:package_beatfighter/Script/ScriptStock.dart';
import 'package:path_provider/path_provider.dart';

String strFilename_ConfigInfo = "ConfigInfo.txt";
String strFilename_ScriptInfo = "ScriptInfo.txt";
String strFilename_ResourceInfo = "ResourceInfo.txt";

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

  Future<bool> check_file({required SaveType type}) async {
    String filePath = await get_PathDocument();

    switch (type) {
      case SaveType.Config:
        {
          filePath += "/$strFilename_ConfigInfo";
          File file = File(filePath);

          if (await file.exists()) {
            return true;
          }
        }
        break;
      case SaveType.Script:
        {
          filePath += "/$strFilename_ScriptInfo";
          File file = File(filePath);

          if (await file.exists()) {
            return true;
          }
        }
        break;
      case SaveType.Resource:
        {
          filePath += "/$strFilename_ResourceInfo";
          File file = File(filePath);

          if (await file.exists()) {
            return true;
          }
        }
        break;
    }
    return false;
  }

  Future<void> save_fileFromMap({required SaveType type, required Map map}) async {
    String filePath = await get_PathDocument();

    switch (type) {
      case SaveType.Config:
        {
          filePath += "/$strFilename_ConfigInfo";
          File file = File(filePath);
          file.writeAsString(jsonEncode(map));
        }
        break;
      case SaveType.Script:
        {
          Map data = {};
          map.forEach((key, value) {
            data[key] = value.toJson();
          });
          Map sortedMap = Map.fromEntries(data.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

          filePath += "/$strFilename_ScriptInfo";
          File file = File(filePath);
          file.writeAsString(jsonEncode(sortedMap.toString()));
          print("path : $filePath");
        }
        break;
      case SaveType.Resource:
        {
          filePath += "/$strFilename_ResourceInfo";
          File file = File(filePath);
          file.writeAsString(jsonEncode(map));
        }
        break;
    }
  }

  load_file({required SaveType type}) async {
    String filePath = await get_PathDocument();
    var contents = null;

    switch (type) {
      case SaveType.Config:
        {
          filePath += "/$strFilename_ConfigInfo";
          if (await check_file(type: type)) {
            File file = File(filePath);
            contents = file.readAsString();
          }
        }
        break;
      case SaveType.Script:
        {
          filePath += "/$strFilename_ScriptInfo";
          if (await check_file(type: type)) {
            File file = File(filePath);
            contents = file.readAsString();
          }
        }
        break;
      case SaveType.Resource:
        {
          filePath += "/$strFilename_ResourceInfo";
        }
        break;
    }

    if (contents != null) {
      return contents;
    } else {
      return null;
    }
  }

  Future<Map<String, ScriptStock>?> load_ScriptInfo() async {
    var result = null;
    String filePath = await get_PathDocument();
    filePath += "/$strFilename_ScriptInfo";
    File file = File(filePath);

    print("path : $filePath");

    if (await file.exists()) {
      var load = file.readAsString();
      print("load Debug\n $load");
      result = json.decode(load as String);
    }
    return result;
  }
}
