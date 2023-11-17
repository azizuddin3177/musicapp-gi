import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/MusicController.dart';

class DetaileSongScreen extends StatelessWidget {
  int index;
  DetaileSongScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicController>(builder: (__) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  __.stopMusic();
                  __.showBottom = false;
                  Get.back();
                  __.update();
                },
                child: const Icon(Icons.close),
              ),
              SizedBox(width: Get.width * .04,),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.keyboard_arrow_down_rounded,),
            ),
            title: Text(
              __.extractSongTitle(__.musicFiles[__.initialIndex]),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(.3),
                foregroundColor: Colors.grey,
                radius: 150,
                child: const Icon(
                  Icons.music_note,
                  size: 200,
                ),
              ),
              sizeBox(),
              sizeBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.equalizer,
                        color: Colors.white,
                      )),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.speed,
                        color: Colors.white,
                      )),
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      )),
                ],
              ),
              Obx(() => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .08),
                    child: ProgressBar(
                      onSeek: __.onSeek,
                      progressBarColor: Colors.black,
                      baseBarColor: Colors.white,
                      thumbColor: Colors.transparent,
                      progress: __.position.value,
                      total: __.musicLength.value,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.shuffle,
                        color: Colors.white,
                      )),
                  InkWell(
                      onTap: () {
                        __.playPreviousSong();
                        __.update();
                      },
                      child: const Icon(
                        Icons.skip_previous,
                        size: 30,
                        color: Colors.white,
                      )),
                  InkWell(
                      onTap: () {
                        __.pauseResumeMusic();
                      },
                      child: Icon(
                        __.pauseResume == false
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      )),
                  InkWell(
                      onTap: () {
                        __.playNextSong();
                        __.update();
                      },
                      child: const Icon(
                        Icons.skip_next,
                        size: 30,
                        color: Colors.white,
                      )),
                  InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.loop,
                        color: Colors.white,
                      )),
                ],
              ),
              sizeBox(),
            ],
          ),
        ),
      );
    });
  }
  sizeBox() {
    return SizedBox(
      height: Get.height * .05,
    );
  }
}
