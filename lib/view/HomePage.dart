//@dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/model/utils/Constantes.dart';
import 'package:iptv/view/CanaisPage.dart';
import 'package:iptv/view/ListaPage.dart';

import 'ContaPage.dart';

class HomePage extends StatefulWidget {
  static int cIndex = 0;
  //const HomePage({ Key? key }) : super(key: key);
  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tituloController = new TextEditingController();
  _HomePageState() {
    tituloController.text = "IPTV canais V.1";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePage.cIndex != 0
          ? AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: GRADIENTE_CABECARIO,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: TextField(
                  style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 30)),
                  readOnly: true,
                  controller: tituloController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              // actions: [ // Botão de pesquisa!
              //   IconButton(
              //     icon: Align(
              //       alignment: Alignment.topCenter,
              //       child: Icon(
              //         Icons.search,
              //         color: Colors.white,
              //         size: 30,
              //       ),
              //     ),
              //     onPressed: () {
              //       //Para encolher a barra!
              //       setState(() {});
              //     }
              // ),
              // ],
            )
          : null,

      //BARRA DE OPÇÕES
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        selectedLabelStyle: GoogleFonts.encodeSans(),
        backgroundColor: Colors.black,
        currentIndex: HomePage.cIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Colors.black38,
            backgroundColor: Colors.black,
            icon: Icon(Icons.receipt, color: Color(0xFF232c47)),
            label: 'Lista',
            activeIcon: CircleAvatar(
                backgroundColor: Color(0xFF041840),
                child: Icon(Icons.receipt, color: Colors.white)),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.tv, color: Color(0xFF232c47)),
            label: 'Canais',
            activeIcon: CircleAvatar(
                backgroundColor: Color(0xFF041830),
                child: Icon(Icons.tv, color: Colors.white)),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.person, color: Color(0xFF232c47)),
            activeIcon: CircleAvatar(
                backgroundColor: Color(0xFF041840),
                child: Icon(Icons.person, color: Colors.white)),
            label: 'Conta',
          )
        ],
        onTap: (index) {
          _incrementTab(index);
        },
      ),

      // Parte de dentro!
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF041840),
              Color(0xFF041830)
            ], //ESSE GRADIENTE MUDA A ANGULAÇÃO.
          ),
        ),
        child: retornoPagina(HomePage.cIndex),
      ),
    );
  }

  /// Trabalha com o index do bottom app bar!
  void _incrementTab(indice) {
    setState(() {
      //print("ANTIGO");
      HomePage.cIndex = indice;
      print("PAGE ATUAL: " + "$indice");
    });
  }

  Widget retornoPagina(index) {
    if (index == 0) 
      return ListaPage();
    else if (index == 1) 
      return CanaisPage();
    return ContaPage();//2
  }
}
