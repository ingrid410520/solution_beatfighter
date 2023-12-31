enum ConfigOption {
  Vol_main,
  Vol_bgm,
  Vol_eff,
}

class ConfigManager {
  ConfigManager._make() {
    if (load()) {
      // 변수들 로드값으로 초기화

    } else {
      // mapConfigInfo 재정의
      // save 하기
      mapConfigInfo[ConfigOption.Vol_main] = vol_main.toString();
      mapConfigInfo[ConfigOption.Vol_bgm] = vol_bgm.toString();
      mapConfigInfo[ConfigOption.Vol_eff] = vol_eff.toString();
    }

  }

  static final ConfigManager _inst = ConfigManager._make();

  factory ConfigManager() => _inst;

  Map<ConfigOption, String> mapConfigInfo = {};
  double vol_main = 1.0;
  double vol_bgm = 1.0;
  double vol_eff = 1.0;

  void save() {}

  bool load() {
    return false;
  }

  set_EffectVolume() {}

  get_EffectVolume() {}
}
