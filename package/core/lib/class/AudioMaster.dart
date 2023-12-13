import 'package:audioplayers/audioplayers.dart';

class SoundMaster {
  factory SoundMaster() => _inst;
  static final SoundMaster _inst = SoundMaster._constructor();

  SoundMaster._constructor() {
    //addBgm("testBGM", AudioPathType.AssetSource, 'audio/hanma_baki.mp3');
    //addEffect("testSE", AudioPathType.AssetSource, 'audio/SE_Drum.mp3');
  }

  Map<String, AudioStock> mapBgm = Map();
  Map<String, AudioStock> mapEffect = Map();

  List<String> get_AudioKeys_BGM() => mapBgm.keys.toList();

  List<String> get_AudioKeys_Effect() => mapEffect.keys.toList();

  void addBgm(String AudioKey, AudioPathType Type, String Path) {
    String tempKey = AudioKey;
    int tempNumber = 1;

    do {
      if (mapBgm.containsKey(tempKey)) {
        tempNumber++;
        tempKey = AudioKey + "(" + tempNumber.toString() + ")";
      } else {
        mapBgm[tempKey] = AudioStock(audioPathType: Type, path: Path);
        switch (Type) {
          case AudioPathType.AssetSource:
            AudioPlayer().setSource(AssetSource(Path));
          case AudioPathType.DeviceFile:
            AudioPlayer().setSource(DeviceFileSource(Path));
          case AudioPathType.URL:
            AudioPlayer().setSource(UrlSource(Path));
        }
        break;
      }
    } while (true);
  }

  void addEffect(String AudioKey, AudioPathType Type, String Path) {
    String tempKey = AudioKey;
    int tempNumber = 0;

    do {
      if (mapEffect.containsKey(tempKey)) {
        tempNumber++;
        tempKey = AudioKey + "_" + tempNumber.toString();
      } else {
        mapEffect[tempKey] = AudioStock(audioPathType: Type, path: Path);
        switch (Type) {
          case AudioPathType.AssetSource:
            AudioPlayer().setSource(AssetSource(Path));
          case AudioPathType.DeviceFile:
            AudioPlayer().setSource(DeviceFileSource(Path));
          case AudioPathType.URL:
            AudioPlayer().setSource(UrlSource(Path));
        }
        break;
      }
    } while (true);
  }

  AudioPlayer Play_Bgm(String AudioKey) {
    AudioPlayer result = AudioPlayer();

    if (mapBgm.containsKey(AudioKey)) {
      var stock = mapBgm[AudioKey]!;
      AudioPathType type = stock.audioPathType;
      String path = stock.path;

      switch (type) {
        case AudioPathType.AssetSource:
          result
            ..setReleaseMode(ReleaseMode.stop)
            ..play(AssetSource(path));
        case AudioPathType.DeviceFile:
          result
            ..setReleaseMode(ReleaseMode.stop)
            ..play(DeviceFileSource(path));
        case AudioPathType.URL:
          result
            ..setReleaseMode(ReleaseMode.stop)
            ..play(UrlSource(path));
      }
    }
    return result;
  }

  void Play_Effect(String AudioKey) {
    if (mapEffect.containsKey(AudioKey)) {
      var stock = mapEffect[AudioKey]!;
      AudioPathType type = stock.audioPathType;
      String path = stock.path;

      switch (type) {
        case AudioPathType.AssetSource:
          AudioPlayer()
            ..setReleaseMode(ReleaseMode.stop)
            ..play(AssetSource(path));
        case AudioPathType.DeviceFile:
          AudioPlayer()
            ..setReleaseMode(ReleaseMode.stop)
            ..play(DeviceFileSource(path));
        case AudioPathType.URL:
          AudioPlayer()
            ..setReleaseMode(ReleaseMode.stop)
            ..play(UrlSource(path));
      }
    }
  }
}

enum AudioPathType {
  AssetSource,
  DeviceFile,
  URL,
}

class AudioStock{
  AudioStock({required this.audioPathType, required this.path});
  final AudioPathType audioPathType;
  final String path;
}