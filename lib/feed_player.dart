import 'package:flick_video/sample.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'data.dart';
import 'manager.dart';
import 'multti.dart';


class FeedPlayer extends StatefulWidget {
  FeedPlayer({Key key}) : super(key: key);

  @override
  _FeedPlayerState createState() => _FeedPlayerState();
}

class _FeedPlayerState extends State<FeedPlayer> {
  List items = mockData['items'];

   FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    flickMultiManager = FlickMultiManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FeedPlayer'),
        actions: [
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SamplePlayer()));
              })
        ],
      ),

      body: VisibilityDetector(
        key: ObjectKey(flickMultiManager),
        onVisibilityChanged: (visibility) {
          if (visibility.visibleFraction == 0 && this.mounted) {
            flickMultiManager.pause();
          }
        },
        child: Container(
          color: Colors.yellow,

          child: ListView.builder(
            // separatorBuilder: (context, int) => Container(
            //   height: 100,
            //   color: Colors.green,
            // ),
            // scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                  height: 400,
                  margin: EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FlickMultiPlayer(
                      url: items[index]['trailer_url'],
                      flickMultiManager: flickMultiManager,
                      image: items[index]['image'],
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
