import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/model/bin/Canal.dart';
import 'package:iptv/model/bin/Lista.dart';
import 'package:iptv/model/utils/Constantes.dart';
import 'package:iptv/model/utils/Corrente.dart';

import '../main.dart';
import 'ListaPage.dart';

Future<Widget> builderCardLista(BuildContext context, Lista lista) async {
  int countcanais = await Canal.getCountCanaisPorLista(
      lista.id); //quantidade de canais associados a lista.
  int countcat = await Canal.getCountCategoriasPorLista(lista.id);

  //print("CANAIS: " + countcanais.toString());
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: AZUL_ESCURO,
        elevation: 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
            
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: AZUL_ESCURO,
              ),
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Text(
                        lista.id.toString(),
                        style: GoogleFonts.encodeSans(
                            color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        lista.nome,
                        style: GoogleFonts.encodeSans(
                            color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
            // linha lado a lado
            cardListaItem("Canais", countcanais.toString(), "Categorias",
                countcat.toString()),
            cardListaItem("Modificação", lista.datamodificacao.toString(),
                "Situação", lista.status.toString()),
            //Parte de baixo - buttom
            ButtonTheme(
              focusColor: Colors.black,
              child: ButtonBar(
                children: <Widget>[
                  Container(
                    //botao
                    margin: EdgeInsets.all(10),
                    height: 40.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Color.fromRGBO(0, 160, 227, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: Text('Excluir',
                          style: TextStyle(color: AZUL_ALTERNATIVO)),
                      onPressed: () async {
                        print("Deleted");
                        await Lista.deleteCascade(
                            lista.id); //colocar dentro de um future alert.

                        ListaPage.widgets = [];
                        Corrente.listasCorrente = await Lista.getAllCliente(
                            Corrente.clienteCorrente.id);
                        Navigator.pushReplacementNamed(context, HOMEPAGE); //atualiza a pagina! falta listar canais por categoria e executar player.
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget cardListaItem(String t1, String st1, String t2, String st2) {
  //t1 = title st1 = subtilte
  print("Card Lista item");
  return Row(
    children: [
      Expanded(
        child: ListTile(
          leading: Icon(Icons.verified_outlined, size: 40),
          title: Text(
            t1,
            style: GoogleFonts.oswald(color: Colors.white),
          ),
          subtitle:
              Text(st1, style: GoogleFonts.roboto(color: AZUL_ALTERNATIVO)),
        ),
      ),
      Expanded(
        child: ListTile(
          leading: Icon(Icons.verified_outlined, size: 40),
          title: Text(t2, style: GoogleFonts.oswald(color: Colors.white)),
          subtitle:
              Text(st2, style: GoogleFonts.roboto(color: AZUL_ALTERNATIVO)),
        ),
      ),
    ],
  );
}
