import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/model/utils/Constantes.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iptv/model/utils/Corrente.dart';


//Essa classe trabalha com Corrente.clienteCorrente!
class ContaPage extends StatefulWidget {

  
  ContaPage();

  /// Construtor interno e privado!
  //ContaPage._internal();
 

  @override
  _ContaPageState createState() => _ContaPageState();
}

class _ContaPageState extends State<ContaPage> {
  @override
  Widget build(BuildContext context) {
    return Corrente.clienteCorrente != null
        ? ListView(
            children: [
              ListTile(
                //colocar como input para ser tela d esalvar edição
                leading: Icon(Icons.person, size: 50),
                title: Text(
                  Corrente.clienteCorrente!.nome,
                  style:
                      GoogleFonts.encodeSans(color: Colors.white, fontSize: 20),
                ),
              ),
              Divider(
                height: 6,
                color: AZUL_ALTERNATIVO,
              ),
              cardItem("Código", Corrente.clienteCorrente!.codigo),
              cardItem("Login",  Corrente.clienteCorrente!.login,),
              cardItem("Situação",  Corrente.clienteCorrente!.status),
              //quantidade de lista vinculadas.
            ],
          )
        : Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Icon(
                      Icons.security_update_warning_sharp,
                      color: AZUL_ALTERNATIVO,
                      size: 50,
                    ),
                    Text("Usuário não autorizado",
                        style: GoogleFonts.oswald(
                            color: Colors.white, fontSize: 20)),
                  ],
                ))
              ],
            ),
          );
  }

  Widget cardItem(String title, String subtitle) {
        return Padding( 
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: AZUL_ESCURO,
        elevation: 10,
        child: ListTile(
          //colocar como input para ser tela d esalvar edição
          leading: Icon(Icons.label, size: 30),
          title: Text(
            title,
            style: GoogleFonts.encodeSans(color: Colors.white, fontSize: 15),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              subtitle,
              style:
                  GoogleFonts.encodeSans(color: AZUL_ALTERNATIVO, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
