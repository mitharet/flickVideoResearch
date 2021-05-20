import 'package:flick_video/sample.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import 'data.dart';
import 'manager.dart';
import 'multti.dart';

class SampleUi extends StatefulWidget {
  SampleUi({Key key}) : super(key: key);

  @override
  _SampleUiState createState() => _SampleUiState();
}

class _SampleUiState extends State<SampleUi> {
  List items = mockData['items'];

  FlickMultiManager flickMultiManager;
  FlickManager flickManager;

  final ValueNotifier<String> _url = ValueNotifier<String>(
      ' https://staging.milov.id/videoProfile/62813112233/MjAyMTA1MTkwOTQ2MzFfNjI4MTMxMTIyMzNfbWlsb3ZfdHJpbV81OTgzLm1wNA==');

  @override
  void initState() {
    super.initState();
    flickMultiManager = FlickMultiManager();
    flickManager = FlickManager(
      autoPlay: true,
      videoPlayerController: videoPlayerController()..setLooping(true),
    );
  }

  VideoPlayerController videoPlayerController() {
    return VideoPlayerController.network(_url.value);
  }

  @override
  void dispose() {
    // flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample UI'),
      ),
      body: Container(
        color: Colors.yellow,
        child: Stack(
          children: [
            // Container(
            //   child: FlickVideoPlayer(flickManager: flickManager),
            // ),
            // ValueListenableBuilder(
            //   valueListenable: _url,
            //   builder: (_, v, __) {
            //     return SamplePlayer(
            //       url: v,
            //     );
            //   },
            // ),
            Container(
              child: ListView.builder(
                // separatorBuilder: (context, int) => Container(
                //   height: 100,
                //   color: Colors.green,
                // ),
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: 400,
                      margin: EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        // child: Image.network(items[index]['image'])
                        child: FlickMultiPlayer(
                          url: items[index]['trailer_url'],
                          flickMultiManager: flickMultiManager,
                          image: items[index]['image'],
                        ),
                      ));
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 165,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _url.value = items[index]['trailer_url'];
                        // setState(() {
                        //   this.url = items[index]['trailer_url'];
                        //   print(url);
                        // });
                      },
                      child: Container(
                          height: 20,
                          margin: EdgeInsets.all(2),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(items[index]['image']))),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
