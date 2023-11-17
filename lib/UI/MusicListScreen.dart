import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp_gi/controllers/MusicController.dart';
import 'DetaileSongScreen.dart';

class MusicListScreen extends StatelessWidget {
  MusicListScreen({super.key});
  MusicController musicController = Get.put(MusicController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicController>(builder: (__) {
      if (__.musicFiles.isNotEmpty) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: const Text("Music"),
          ),
          body: ListView.builder(
              itemCount: __.musicFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    __.initialIndex = index;
                    __.pauseResume = false;
                    __.playMusic(index);
                    __.update();
                  },
                  leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Center(
                      child: Icon(
                        Icons.music_note,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  title: Text(__.extractSongTitle(__.musicFiles[index])),
                  subtitle: const Text('Karan Khan'),
                );
              }),
          bottomSheet: __.showBottom == true
              ? Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15)
                  )
                ),
                height: Get.height * .15,
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: Get.width * .04
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                __.stopMusic();
                                __.showBottom = false;
                                __.update();
                              },
                              child: const Icon(Icons.close)),
                          SizedBox(
                            width: Get.width * .80,
                            child: ListTile(
                              onTap: () {
                                Get.to(
                                    DetaileSongScreen(
                                      index: __.initialIndex,
                                    ),
                                    transition: Transition.downToUp);
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.music_note,
                                      color: Colors.black,
                                    )),
                              ),
                              title: Text(
                                __.extractSongTitle(
                                    __.musicFiles[__.initialIndex]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                __.playPreviousSong();
                                __.update();
                              },
                              child: const Icon(Icons.skip_previous)),
                          InkWell(
                              onTap: () {
                                __.pauseResumeMusic();
                              },
                              child: Icon(
                                __.pauseResume == false
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.black,
                                size: 30,
                              )),
                          InkWell(
                              onTap: () {
                                __.playNextSong();
                                __.update();
                              },
                              child: const Icon(Icons.skip_next)),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              : const SizedBox.shrink(),
        );
      } else {
        return  Scaffold(
          body: Center(
            child: Text(
              'No Song In Your Music Folder...',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(.6)),
            ),
          ),
        );
      }
    });
  }
}
