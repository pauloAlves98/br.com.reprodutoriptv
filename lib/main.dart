//@dart=2.9
import 'package:flutter/material.dart';
import 'package:yoyo_player/yoyo_player.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool fullscreen = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: fullscreen == false
            ? AppBar(
                backgroundColor: Colors.blue,
                title: Text("Titulo"),
      
                centerTitle: true,
              )
            : null,
        body: Column(//colocar em um list view.
          children: [
            Padding(
              padding: fullscreen == false?  EdgeInsets.all(8.0):EdgeInsets.all(0.0),
              child: YoYoPlayer(
                aspectRatio: 16 / 9,
                url:"http://live.video.globo.com/h/1402196682759012345678915746027599876543210hM4EA1neMoQoIiUyVn1TNg/k/app/a/A/u/anyone/d/s/hls-globo-rj/hls-globo-rj_2359/playlist.m3u8",
                //"https://x.filmes.click/m0/d/791373-720p.mp4",
                  //"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                    //"https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
                // "https://player.vimeo.com/external/440218055.m3u8?s=7ec886b4db9c3a52e0e7f5f917ba7287685ef67f&oauth2_token_id=1360367101",
                // "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
                videoStyle:VideoStyle(
                          play : Icon(Icons.play_arrow),
                          pause : Icon(Icons.pause),
                          fullscreen : Icon((Icons.fullscreen)),
                          forward : Icon(Icons.skip_next),
                          backward : Icon(Icons.skip_previous),
                 ),
                videoLoadingStyle: VideoLoadingStyle(
                  loading: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Loading video"),
                      ],
                    ),
                  ),
                ),
                onfullscreen: (t) {
                  setState(() {
                    fullscreen = t;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}