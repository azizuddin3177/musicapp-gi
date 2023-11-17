import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class MusicController extends GetxController {
  bool showBottom = false;
  bool pauseResume = false;
  int initialIndex = 0;
  AudioPlayer audioPlayer = AudioPlayer();
  RxList<String> musicFiles = <String>[].obs;
  RxList<String> favList = <String>[].obs;
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> musicLength = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    loadMusicFiles();
    setUpProgreessBAr();
  }

  Future<void> loadMusicFiles() async {
    Directory? musicDirectory = await _getMusicDirectory();
    if (musicDirectory != null) {
      List<FileSystemEntity> files = musicDirectory.listSync(recursive: true);
      List<String> musicPaths = [];
      for (var file in files) {
        if (file.path.endsWith('.mp3')) {
          musicPaths.add(file.path);
          update();
        }
      }
      musicFiles.assignAll(musicPaths);
    } else {
    }
  }

  Future<Directory?> _getMusicDirectory() async {
    try {
      if (Platform.isAndroid) {
        return Directory('/storage/emulated/0/Music');
      } else {
        print('Error');
        return null;
      }
    } catch (e) {
      print('Error accessing music directory: $e');
      return null;
    }
  }

  String extractSongTitle(String filePath) {
    List<String> pathSegments = filePath.split(Platform.pathSeparator);
    String fileName = pathSegments.last;
    int dotIndex = fileName.lastIndexOf('.');
    if (dotIndex != -1) {
      return fileName.substring(0, dotIndex);
    } else {
      return fileName;
    }
  }

  void setUpProgreessBAr() {
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        update();
        initialIndex;
        playNextSong();
      }
    });
    audioPlayer.onDurationChanged.listen((Duration d) {
      musicLength.value = d;
    });
    audioPlayer.onPositionChanged.listen((Duration p) {
      position.value = p;
    });
  }

  void playMusic(int index) {
    if (index >= 0 && index < musicFiles.length) {
      String path = musicFiles[index];
      audioPlayer.play(
        DeviceFileSource(path),
      );
      showBottom=true;
    }
  }

  void playNextSong() {
    if (initialIndex < musicFiles.length - 1) {
      initialIndex++;
    } else {
      initialIndex = 0;
    }
    playMusic(initialIndex);
  }

  void playPreviousSong() {
    if (initialIndex > 0) {
      initialIndex--;
    } else {
      initialIndex = musicFiles.length - 1;
    }
    playMusic(initialIndex);
  }

  void pauseResumeMusic(){
    if(pauseResume==false){
      audioPlayer.pause();
      pauseResume=true;
      update();
    }else{
      audioPlayer.resume();
      pauseResume=false;
      update();
    }
  }

  void stopMusic() {
    audioPlayer.stop();
  }

  onSeek(Duration duration){
    audioPlayer.seek(duration);
  }

}
