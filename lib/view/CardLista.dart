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
            cardListaItem("Canais", "140", "Categorias", "14"),
            cardListaItem("Modificação", "20-07-2021", "Situação", "Ativa"),
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

Widget cardListaItem(String t1,String st1, String t2, String st2){//t1 = title st1 = subtilte
  return 
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.date_range_outlined, size: 40),
                    title: Text(
                      t1,
                      style: GoogleFonts.oswald(color: Colors.white),
                    ),
                    subtitle: Text(st1,
                        style: GoogleFonts.roboto(color: AZUL_ALTERNATIVO)),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.verified_outlined, size: 40),
                    title: Text(t2,
                        style: GoogleFonts.oswald(color: Colors.white)),
                    subtitle: Text(st2,
                        style: GoogleFonts.roboto(color: AZUL_ALTERNATIVO)),
                  ),
                ),
              ],
            );

}
