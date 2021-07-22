import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/model/utils/Cores.dart';

Widget builderCardLista(int index, BuildContext context,
    {List? fichasW, List? fichas}) {
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
              //Borda para o noome ficha.
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
                      flex: 2,
                      child: Text(
                        "Minha Lista Nº 1",
                        style: GoogleFonts.encodeSans(
                            color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),

            // linha lado a lado
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.tv, size: 40),
                    title: Text(
                      'Canais',
                      style: GoogleFonts.oswald(color: Colors.white),
                    ),
                    subtitle: Text('140',
                        style: GoogleFonts.roboto(color: Colors.blueGrey[200])),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.apps, size: 40),
                    title: Text('Categorias',
                        style: GoogleFonts.oswald(color: Colors.white)),
                    subtitle: Text('14',
                        style: GoogleFonts.roboto(color: Colors.blueGrey[200])),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.date_range_outlined, size: 40),
                    title: Text(
                      'Modificação',
                      style: GoogleFonts.oswald(color: Colors.white),
                    ),
                    subtitle: Text('20-07-2021',
                        style: GoogleFonts.roboto(color: Colors.blueGrey[200])),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.verified_outlined, size: 40),
                    title: Text('Situação',
                        style: GoogleFonts.oswald(color: Colors.white)),
                    subtitle: Text('Ativa',
                        style: GoogleFonts.roboto(color: Colors.blueGrey[200])),
                  ),
                ),
              ],
            ),

            //Parte de baixo
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
                      onPressed: () {},
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
