import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/model/bin/Lista.dart';
import 'package:iptv/model/utils/Constantes.dart';
import 'package:iptv/model/utils/Corrente.dart';

import '../main.dart';
import 'CardLista.dart';


class ListaPage extends StatelessWidget{
  static ListaPage? _instance;//Singleton
  static List<Widget> widgets = [];
  
  ListaPage._internal();
  static ListaPage? getInstance() {
    widgets = [];
    if (_instance == null) {_instance = ListaPage._internal(); print("Nova Instancia!");};
    return _instance;
  }

  @override
  Widget build(BuildContext context) {
    print("Recarregou oooooooooooooo");
    return Scaffold(
     body: Container(
        decoration: BoxDecoration(
          gradient: GRADIENTE_BODY,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 2, left: 4, right: 4, bottom: 2),
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
                    title: Text(
                      Corrente.clienteCorrente==null?"Sem nome":Corrente.clienteCorrente.nome.toString(),
                      style: GoogleFonts.encodeSans(),
                    ), //dropdownbuttom e mostras as infon ao expandir
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
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Tooltip(
                      message: "Nova Lista",
                      child: IconButton(
                        icon: Icon(Icons.add_circle_outline_outlined),
                        onPressed: () {
                          Navigator.pushNamed(context, CADASTROLISTAPAGE);
                        },
                      ),
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child:   ListaPage.widgets.length<=0? FutureBuilder(
                    future: _builderItems(Corrente.listasCorrente,context),
                    //initialData :"Aguardando os dados...",

                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //concluido
                        // suc = true;
                        if(ListaPage.widgets.isEmpty)
                          return Padding(
                            padding: const EdgeInsets.only(top: 50,left: 4,right: 4),
                            child: Align(
                              
                              child: Text("Nenhuma lista encontrada",style: GoogleFonts.oswald(
                                        color: AZUL_ALTERNATIVO, fontSize: 23,
                                        )),
                            ),
                          );
                        return snapshot.data as Widget;
                      } else if (snapshot.error != null) {
                        print("ERROOO");
                        print(snapshot.error);
                        bool isCanal =
                            snapshot.error!.toString().contains("canal");
                        return Container(
                          //decoration: box(),
                          child: Center(
                            child: Text(
                                isCanal
                                    ? "Não foi possivel inserir os Canais!"
                                    : "Erro ao carregar listas!!!",
                                style: GoogleFonts.roboto(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold)),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }):Column(
                      children: ListaPage.widgets,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> _builderItems(List<Lista> listas, context) async {
    for (int i = 0; i < listas.length; i++) {
      Lista l = listas[i];
      ListaPage.widgets.add(await builderCardLista(context, l));
    }
    return Column(
      children: ListaPage.widgets,
    );
  }

  
}


