//@dart=2.9


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iptv/model/bin/Cliente.dart';
import 'package:yoyo_player/yoyo_player.dart';


import 'SGBDPage.dart';
import 'model/bin/Administrador.dart';
import 'model/bin/Lista.dart';

String SGBDPAGE = "/SGBDPAGE";
void main() {
  runApp(
    MaterialApp(
      title: 'IPTV',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (_) => MyApp(),
        SGBDPAGE: (_) => SGBDPage(),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool fullscreen = false;
  String PATH = "";
  List<dynamic> _lista= [];

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
        body: SizedBox.expand(
          child: ListView(
            children: <Widget>[
              Container(
                width: 500,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.transparent]),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(200)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                       GestureDetector(
                        onTap: () async {
                          print("Add cliente");
                          try{
                              //Navigator.pushNamed(context, SGBDPAGE);
                          Cliente c = new Cliente(null,"Jose","111111","login","senha");
                          for(int i=2;i<11;i++){

                            Administrador adm = new Administrador(null,"Jose",i.toString()+"90","login","senha");
                            adm.id = await adm.insert();
                          }
          
                        
                          // if(adm.id!=0){
                          //   c.adm = adm.id;
                          //   c.insert();
                          // }else
                          //   print("falhou");

                          }catch(ex){
                            print("Exception "+ex.toString());
                          }
                         
                        },
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Container(
                              width: 130,
                              height: 130,
                              child: PATH != null && PATH.isNotEmpty
                                  ? Icon(Icons.add)
                                  : Icon(Icons.add)),
                        )),
                      ),
                      GestureDetector(
                        onTap: () async {
                          print("Casa");
                          try{
                              Navigator.pushNamed(context, SGBDPAGE);
                          }catch(ex){
                            print("Exception o");
                          }
                         
                        },
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Container(
                              width: 130,
                              height: 130,
                              child: PATH != null && PATH.isNotEmpty
                                  ? Icon(Icons.home)
                                  : Icon(Icons.home)),
                        )),
                      ),
                      GestureDetector(
                        onTap: () async {
                          String caminho;
                          print("Clicou");
                          caminho = await FilePicker.getFilePath(type: FileType.any);
                            try{
                                if (caminho != null) {
                                 PATH = caminho;
                                Lista listac = new Lista.simples("Lista 1",caminho);
                                listac.idcliente = 1;
                                listac.datamodificacao = "17-07-2021";
                                _lista = await listac.carregaLista();
                                 int i = 0;
                                 print(_lista);
                                 for(i=0;i<_lista.length;i++){
                                   if(i<10){
                                    print("EXtinf: "+_lista[i][0]);
                                    print("Link: "+_lista[i][1]);
                                   }
                                  }
                                  // listac.id = await listac.insert();
                                  //print("ID Lista: "+ listac.id.toString());

                                  //categoria.

                                  //canais

                            } else
                              caminho = "NOT";
                            }catch(e){
                              print("Exceção " + e.toString());
                            }
                          setState(() {
                           PATH = caminho;
                          });
                        },
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Container(
                              width: 130,
                              height: 130,
                              child: PATH != null && PATH.isNotEmpty
                                  ? Icon(Icons.done)
                                  : Icon(Icons.error)),
                        )),
                      ),
                      Text("Caminho: " + PATH)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// class _MyAppState extends State<MyApp> {
//   bool fullscreen = false;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Material App',
//       home: Scaffold(
//         appBar: fullscreen == false
//             ? AppBar(
//                 backgroundColor: Colors.blue,
//                 title: Text("Titulo"),
      
//                 centerTitle: true,
//               )
//             : null,
//         body: Column(//colocar em um list view.
//           children: [
//             Padding(
//               padding: fullscreen == false?  EdgeInsets.all(8.0):EdgeInsets.all(0.0),
//               child: YoYoPlayer(
//                 aspectRatio: 16 / 9,
//                 url:"http://live.video.globo.com/h/1402196682759012345678915746027599876543210hM4EA1neMoQoIiUyVn1TNg/k/app/a/A/u/anyone/d/s/hls-globo-rj/hls-globo-rj_2359/playlist.m3u8",
//                 //"https://x.filmes.click/m0/d/791373-720p.mp4",
//                   //"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
//                     //"https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
//                 // "https://player.vimeo.com/external/440218055.m3u8?s=7ec886b4db9c3a52e0e7f5f917ba7287685ef67f&oauth2_token_id=1360367101",
//                 // "https://sfux-ext.sfux.info/hls/chapter/105/1588724110/1588724110.m3u8",
//                 videoStyle:VideoStyle(
//                           play : Icon(Icons.play_arrow),
//                           pause : Icon(Icons.pause),
//                           fullscreen : Icon((Icons.fullscreen)),
//                           forward : Icon(Icons.skip_next),
//                           backward : Icon(Icons.skip_previous),
//                  ),
//                 videoLoadingStyle: VideoLoadingStyle(
//                   loading: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text("Loading video"),
//                       ],
//                     ),
//                   ),
//                 ),
//                 onfullscreen: (t) {
//                   setState(() {
//                     fullscreen = t;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }