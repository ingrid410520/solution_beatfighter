enum ConfigOption{
  Vol_main,
  Vol_bgm,
  Vol_eff,

}

class ConfigManager{
  ConfigManager._make(){
    mapConfigInfo[ConfigOption.Vol_main] = "1";
    mapConfigInfo[ConfigOption.Vol_bgm] = "1";
    mapConfigInfo[ConfigOption.Vol_eff] = "1";

  }
  static final ConfigManager _inst = ConfigManager._make();
  factory ConfigManager() => _inst;

  Map<ConfigOption, String> mapConfigInfo = {};


  set_EffectVolume(){}
  get_EffectVolume(){}
}