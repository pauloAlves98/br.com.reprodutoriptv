//@dart=2.9
import 'package:flutter/material.dart';
import 'package:iptv/view/CadastroListaPage.dart';
import 'package:iptv/view/CanaisPage.dart';
import 'package:iptv/view/HomePage.dart';
import 'package:iptv/view/ListaPage.dart';
import 'package:iptv/view/Splash.dart';
import 'SGBDPage.dart';
import 'view/ExibirCanalPage.dart';

const String SGBDPAGE = "/SGBDPAGE";
const String HOMEPAGE = "/HOMEPAGE";
const String CADASTROLISTAPAGE = "/CADASTROLISTAPAGE";
const String SPLASHPAGE = "/SPLASH";
const String CANALPAGE = "/CANALPAGE";
const String EXIBIRCANALPAGE = "/ EXIBIRCANALPAGE";
const String LISTAPAGE = "/LISTAPAGE";

Map<String, WidgetBuilder> routes = {
  "/": (_) => Splash(),
  SGBDPAGE: (_) => SGBDPage(),
  HOMEPAGE: (_) => HomePage(),
  CADASTROLISTAPAGE: (_) => CadastroListaPage(),
  SPLASHPAGE: (_) => Splash(),
  CANALPAGE: (_) => CanaisPage(),
  EXIBIRCANALPAGE: (_) => ExibirCanalPage(),
  LISTAPAGE: (_) => ListaPage(),
};
void main() {
  runApp(
    MaterialApp(
      title: 'IPTV CANAIS V.1',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
    ),
  );
}

// ----------------- Apenas para vizualização do BD em um gerenciador --------------------!

// class MyApp extends StatefulWidget {

//   static MyApp _instance;//Singleton
//   MyApp._internal();
//   static MyApp getInstance(){
//      if(_instance==null)
//         _instance =  MyApp._internal();
//       return _instance;
//   }
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool fullscreen = false;
//   String PATH = "";
//   List<dynamic> _lista= [];

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
//         body: SizedBox.expand(
//           child: ListView(
//             children: <Widget>[
//               Container(
//                 width: 500,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [Colors.transparent, Colors.transparent]),
//                   borderRadius:
//                       BorderRadius.only(bottomLeft: Radius.circular(200)),
//                 ),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Column(
//                     children: <Widget>[
//                        GestureDetector(
//                         onTap: () async {
//                           print("Add cliente");
//                           try{
//                               //Navigator.pushNamed(context, SGBDPAGE);
//                           Cliente c = new Cliente(null,"Jose","111113","login","senha");
//                           Administrador adm = new Administrador(null,"Jose ADM","9990","login","senha");
                         
//                           adm.id = await adm.insert();
//                           if(adm.id!=0){
//                              c.adm = adm.id;
//                              c.insert();
//                           }else
//                             print("falhou");

//                           }catch(ex){
//                             print("Exception "+ex.toString());
//                           }
                         
//                         },
//                         child: Center(
//                             child: Padding(
//                           padding: EdgeInsets.only(top: 40),
//                           child: Container(
//                               width: 130,
//                               height: 130,
//                               child: PATH != null && PATH.isNotEmpty
//                                   ? Icon(Icons.add)
//                                   : Icon(Icons.add)),
//                         )),
//                       ),
//                       GestureDetector(
//                         onTap: () async {
//                           print("Casa");
//                           try{
//                               Navigator.pushNamed(context, SGBDPAGE);
//                           }catch(ex){
//                             print("Exception o");
//                           }
                         
//                         },
//                         child: Center(
//                             child: Padding(
//                           padding: EdgeInsets.only(top: 40),
//                           child: Container(
//                               width: 130,
//                               height: 130,
//                               child: PATH != null && PATH.isNotEmpty
//                                   ? Icon(Icons.home)
//                                   : Icon(Icons.home)),
//                         )),
//                       ),
//                       GestureDetector(
//                         onTap: () async {
//                           String caminho;
//                           print("Clicou");
//                           caminho = await FilePicker.getFilePath(type: FileType.any);
//                             try{
//                                 if (caminho != null) {
//                                  PATH = caminho;
//                                 Lista listac = new Lista.simples("Lista 1",caminho);
//                                 listac.idcliente = 1;
//                                 listac.datamodificacao = "17-07-2021";
//                                 _lista = await Lista.carregaLista(PATH);
//                                  int i = 0;
//                                  print(_lista);
//                                  for(i=0;i<_lista.length;i++){
//                                    if(i<10){
//                                     print("EXtinf: "+_lista[i][0]);
//                                     print("Link: "+_lista[i][1]);
//                                    }
//                                   }
//                                   listac.id = await listac.insert();
//                                  // print("ID Lista: "+ listac.id.toString());

//                                   //categoria.
//                                   List<Categoria> categorias = await Categoria.carregaCategoria(_lista,listac.id);
//                                   print("TAmaho "+categorias.length.toString());
//                                   List<dynamic> iall  = await Categoria.insertAll(categorias);//lista de id
//                                   print("I All ");
//                                   print(iall.length);
//                                   print("ACAABOUUUUUUUUU");

                                  
//                                   //canais - probelma eh aqui
//                                   List<Canal> canais = await Canal.carregaCanais(_lista,listac.id);
//                                   print("Canais: ");
//                                   print(canais.length);
//                                   for(Canal element in canais){
//                                     print(element.linkVideo);
//                                          element.idlista = listac.id;
//                                          await element.insert();
//                                   }
//                                   print("Acabou tudo: ");

//                             } else
//                               caminho = "NOT";
//                             }catch(e){
//                               print("Exceção " + e.toString());
//                             }
//                           setState(() {
//                            PATH = caminho;
//                           });
//                         },
//                         child: Center(
//                             child: Padding(
//                           padding: EdgeInsets.only(top: 40),
//                           child: Container(
//                               width: 130,
//                               height: 130,
//                               child: PATH != null && PATH.isNotEmpty
//                                   ? Icon(Icons.done)
//                                   : Icon(Icons.error)),
//                         )),
//                       ),
//                       Text("Caminho: " + PATH)
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
