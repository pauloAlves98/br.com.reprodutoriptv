import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/model/utils/Cores.dart';

import 'CardLista.dart';

class ListaPage extends StatefulWidget {
  static ListaPage? _instance; //Singleton

  ListaPage._internal();
  static ListaPage? getInstance() {
    if (_instance == null) _instance = ListaPage._internal();
    return _instance;
  }

  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: GRADIENTE_BODY,
          ),
        child: Padding(
          padding:EdgeInsets.only(top: 2, left: 4,right: 4,bottom: 2),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: GRADIENTE_CABECARIO,
                  ),
                  child: FlexibleSpaceBar(
                    title: Text("Jose P. Silva", style: GoogleFonts.encodeSans(),),//dropdownbuttom e mostras as infon ao expandir
                    ),
                ),
                //bottom: Text("Teste"),
                backgroundColor: Colors.transparent,
                // expandedHeight: MediaQuery.of(context).size.height <= 400 ||
                //          MediaQuery.of(context).orientation == Orientation.landscape
                //      ? 80
                //      : 100,
                leading: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    backgroundImage: AssetImage(
                      'assets/user.png',
                    ),
                  ),
                ),
                actions: [Padding(
                   padding: const EdgeInsets.only(right: 16),
                   child: Tooltip(
                     message: "Nova Lista",
                     child: IconButton(
                     
                       icon: Icon(Icons.add_circle_outline_outlined), 
                       onPressed: () {  },
                     ),
                   ),
                )],
              ),
              SliverToBoxAdapter(
                child: builderCardLista(1, context), //FAZER ESTE CARD AADAPTADO A LISTA.
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
