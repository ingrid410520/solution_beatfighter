import 'package:package_beatfighter/Save/SaveManager.dart';
import 'package:package_beatfighter/Script/ScriptStock.dart';

class ScriptManager {
  ScriptManager._construct() {
    create_ScriptStock(scriptName: "Base");
    select_ScriptStock("Base");
  }

  static final ScriptManager _inst = ScriptManager._construct();

  factory ScriptManager() => _inst;

  Map<String, ScriptStock> mapScriptContainer = Map<String, ScriptStock>();
  String? selectedScriptName;

  String create_ScriptStock({required String scriptName, int scriptLength = 5000}) {
    String tempKey = scriptName;
    int tempNumber = 1;

    do {
      if (check_ScriptStock(tempKey)) {
        tempKey = scriptName + "(" + tempNumber.toString() + ")";
        tempNumber++;
      } else {
        mapScriptContainer[tempKey] = ScriptStock(scriptName: tempKey, length: scriptLength);
        break;
      }
    } while (true);

    return tempKey;
  }

  ScriptStock? get_ScriptStock(String scriptName) => mapScriptContainer[scriptName];

  bool check_ScriptStock(String scriptName) => mapScriptContainer.containsKey(scriptName);

  List<String> get_ScriptKeys() => mapScriptContainer.keys.toList();

  bool change_ScriptName(String name, String newName) {
    if (mapScriptContainer.containsKey(name)) {
      var value = get_ScriptStock(name)!;
      create_ScriptStock(scriptName: newName, scriptLength: value.get_ScriptLength());
      var newValue = get_ScriptStock(newName)!;
      newValue.mapNote.addAll(value.mapNote);
      mapScriptContainer.remove(name);
      return true;
    }
    return false;
  }

  bool remove_Script(String scriptName) {
    if (mapScriptContainer.containsKey(scriptName)) {
      mapScriptContainer.remove(scriptName);
      return true;
    }
    return false;
  }

  bool select_ScriptStock(String scriptName) {
    if (mapScriptContainer.containsKey(scriptName)) {
      selectedScriptName = scriptName;
      return true;
    }
    return false;
  }

  ScriptStock? get_SelectScript() {
    if (selectedScriptName == null) return null;

    return mapScriptContainer[selectedScriptName];
  }

  bool clear_SelectScript() {
    if (selectedScriptName == null) return false;
    selectedScriptName = null;
    return true;
  }

  void save() {
    SaveManager().save_fileFromMap(type: SaveType.Script, map: mapScriptContainer);
  }

  Future<void> load() async {
    mapScriptContainer = (await SaveManager().load_ScriptInfo())!;
  }
}
