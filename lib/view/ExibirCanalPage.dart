import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/model/bin/Canal.dart';
import 'package:iptv/model/utils/Constantes.dart';
import 'package:iptv/model/utils/Corrente.dart';
import 'package:iptv/view/CanaisPage.dart';
import 'package:video_player/video_player.dart';
import 'package:yoyo_player/yoyo_player.dart';

import '../main.dart';
import 'ChewieListItem.dart';
import 'HomePage.dart';

// ignore: must_be_immutable
class ExibirCanalPage extends StatefulWidget {
  //static ExibirCanalPage? _instance; //Singleton

  ExibirCanalPage() {}
  // static ExibirCanalPage? getInstance({required Canal canal}) {
  //   if (_instance == null) {
  //     _instance = ExibirCanalPage._internal();
  //     _instance!.canal = canal;
  //     print("Nova Instancia!");
  //   }
  //   ;
  //   return _instance;
  // }

  @override
  _ExibirCanalPageState createState() => _ExibirCanalPageState();
}

class _ExibirCanalPageState extends State<ExibirCanalPage> {
  bool fullscreen = false;
  
  @override
  Widget build(BuildContext context) {
    print("Link:" + Corrente.canalCorrente!.linkVideo);
    return WillPopScope( //Captura evento do botão voltar do android!
      onWillPop: () async {Navigator.pop(context); return false;}, 
      child: Scaffold(
        appBar: fullscreen == false
            ? AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: GRADIENTE_CABECARIO,
                  ),
                  child: FlexibleSpaceBar(
                    title: Text(
                      Corrente.canalCorrente == null
                          ? "Canal Nulo"
                          : Corrente.canalCorrente!.nome,
                      style: GoogleFonts.encodeSans(),
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                // expandedHeight: MediaQuery.of(context).size.height <= 400 ||
                //          MediaQuery.of(context).orientation == Orientation.landscape
                //      ? 80
                //      : 100,
                leading: Center(
                    child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          print("Voltar");
                          //this.dispose();
                          Navigator.pop(context);
                         //this.dispose();
                        })),
                actions: [],
              )
            : null,
        body: Container(
          decoration: BoxDecoration(
            gradient: GRADIENTE_BODY,
          ),
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(//tem que definir o tamanho pora causa do aspect ratio!
                    height: MediaQuery.of(context).size.height - 100,
                    child: Align(
                      alignment:
                          !fullscreen ? Alignment.center : Alignment.topCenter,  //fullscreen não foi utilizado, valor fixo!
                      child: Padding(
                        padding: fullscreen == false
                            ? EdgeInsets.all(0.0)
                            : EdgeInsets.all(0.0),
                        child: ChewieListItem( //A magica do player
                          videoPlayerController: VideoPlayerController.network(
                            Corrente.canalCorrente!.linkVideo,
                          ),
                          looping: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


//YoYo não funcionou bem!
//  YoYoPlayer(
//                         aspectRatio: 16 / 9,
//                         url: Corrente.canalCorrente!.linkVideo,
//                         //"http://live.video.globo.com/h/1402196682759012345678915746027599876543210hM4EA1neMoQoIiUyVn1TNg/k/app/a/A/u/anyone/d/s/hls-globo-rj/hls-globo-rj_2359/playlist.m3u8",
//                         //"https://x.filmes.click/m0/d/791373-720p.mp4",
//                         //"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
//                         //"https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
//                         // "https://player.vimeo.com/external/440218055.m3u8?s=7ec886b4db9c3a52e0e7f5f917ba7287685ef67f&oauth2_token_id=1360367101",
//                         // "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
//                         videoStyle: VideoStyle(
//                           play: Icon(Icons.play_arrow),
//                           pause: Icon(Icons.pause),
//                           fullscreen: Icon((Icons.fullscreen)),
//                           forward: Icon(Icons.skip_next),
//                           backward: Icon(Icons.skip_previous),
//                         ),

//                         videoLoadingStyle: VideoLoadingStyle(
//                           loading: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 CircularProgressIndicator(),
//                                 Text(
//                                   "Loading video",
//                                   style: GoogleFonts.encodeSans(
//                                       color: Colors.white),
//                                 ),
//                                 Text(
//                                   "Caso demore mais de 5 s, Canal indisponível!",
//                                   style: GoogleFonts.encodeSans(
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 IconButton(
//                                     icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white,),
//                                     onPressed: () {
//                                       Navigator.of(context).pushNamedAndRemoveUntil(HOMEPAGE, (route) => false);

//                                     })
//                               ],
//                             ),
//                           ),
//                         ),
//                         onfullscreen: (t) {
//                           setState(() {
//                             fullscreen = t;
//                           });
//                         },
//                       ),