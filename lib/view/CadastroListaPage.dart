import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iptv/model/bin/Lista.dart';
import 'package:iptv/model/utils/Constantes.dart';
import 'package:iptv/model/utils/Corrente.dart';

import '../main.dart';
import 'ListaPage.dart';

class CadastroListaPage extends StatefulWidget {
  @override
  _CadastroListaPageState createState() => _CadastroListaPageState();
}

class _CadastroListaPageState extends State<CadastroListaPage> {
  TextEditingController nomeField = new TextEditingController();
  TextEditingController caminhoField = new TextEditingController();
  bool autovalidar = false;
  bool flagErro = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: GRADIENTE_CABECARIO,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
            "Inserir Lista",
            style: GoogleFonts.indieFlower(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 30),
            ),
          ),
        ),
        leading:IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: (){
             //Navigator.pop(context);
              Navigator.popAndPushNamed(context, HOMEPAGE);
          },
        ),
        actions: [],
      ),

      //corpo
      body: Container(
        decoration: BoxDecoration(
          gradient: GRADIENTE_CABECARIO,
        ),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: AZUL_ESCURO,
              elevation: 20,
              child: Column(
                children: [
                  inputform("Nome da lista", nomeField, (String? value) {
                    return value == null || value.isEmpty
                        ? "Insira um nome"
                        : null;
                  }, Icon(Icons.list, color: AZUL_ALTERNATIVO), () {}, false),
                  Divider(
                    height: 6,
                    color: AZUL_ALTERNATIVO,
                  ),
                  inputform(
                      "Clique no icone e selecione uma lista",
                      caminhoField,
                      (String? value) {
                        return value == null || value.isEmpty
                            ? "Clique no icone e insira uma lista!"
                            : null;
                      },
                      Icon(Icons.upload_file, color: AZUL_ALTERNATIVO),
                      () async {
                        caminhoField.text = await FilePicker.getFilePath(
                          type: FileType.any,
                         
                        );
                      },
                      true),
                  Divider(
                    height: 6,
                    color: AZUL_ALTERNATIVO,
                  ),
                  //botão
                  ButtonTheme(
                    focusColor: Colors.black,
                    child: Center(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              child: Text('Inserir',
                                  style: TextStyle(color: AZUL_ALTERNATIVO)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print("Validou");
                                  showAlertDialogLista(context, nomeField.text,
                                      caminhoField.text, 1);
                                } else
                                  print("Não Validou");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  showAlertDialogLista(BuildContext context, nome, caminho, idcliente) {
    //ajeitar esse dialog e sincronizar lista e organizar canais e tela splash.
    // configura o  AlertDialog
    //bool suc = false;
    AlertDialog alerta = AlertDialog(
      backgroundColor: AZUL_ESCURO,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      title: Center(
          child: Text("Cadastrando Lista",
              style: GoogleFonts.oswald(color: Colors.white))),
      content: FutureBuilder(
          future: Lista.popularLista(nome, caminho, idcliente),
          //initialData :"Aguardando os dados...",

          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //concluido
              // suc = true;

              Timer(new Duration(seconds: 1), () async {
                ListaPage.widgets = [];
                Corrente.listasCorrente =
                    await Lista.getAllCliente(Corrente.clienteCorrente.id);
                // limparCampos();
                Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, HOMEPAGE);
                //  Navigator.pushReplacementNamed(context, HOMEPAGE);
                // Navigator.of(context).pop();
              });
              return Container(
                decoration: Constantes.box,
                child: Center(
                  child: Text(
                    "Inserido com sucesso!",
                    style: GoogleFonts.roboto(
                        color: AZUL_ALTERNATIVO, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else if (snapshot.error != null) {
              print("ERROOO");
              print(snapshot.error);
              bool isCanal = snapshot.error!.toString().contains("canal");
               Timer(new Duration(seconds: 1), () async {
                ListaPage.widgets = [];
                Corrente.listasCorrente =
                    await Lista.getAllCliente(Corrente.clienteCorrente.id);
                // limparCampos();
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, HOMEPAGE);
                //  Navigator.pushReplacementNamed(context, HOMEPAGE);
                // Navigator.of(context).pop();
              });
              return Container(
                decoration: Constantes.box,
                child: Center(
                  child: Text(
                      isCanal
                          ? "Não foi possivel inserir os Canais!"
                          : "Não foi possivel Inserir as Categorias!",
                      style: GoogleFonts.roboto(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold)),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      actions: [
        // Container(
        //   height: 70,
        //   width: 300,
        //   child: Center(
        //     child: FlatButton(
        //       child: Text("OK"),
        //       onPressed: () {
        //         print("Ola");
        //         if (suc) {
        //           //success

        //         } else
        //           Navigator.of(context).pop();
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: Container(
                decoration: Constantes.box,
                height: 300,
                child: FittedBox(child: alerta)));
      },
    );
  }


  Widget inputform(String hint, TextEditingController controller, fvalidator,
      Icon icon, iconpressed, relyony) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: TextFormField(
          readOnly: relyony,
          controller: controller,
          style:
              GoogleFonts.oswald(textStyle: TextStyle(color: AZUL_ALTERNATIVO)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: fvalidator,
          decoration: InputDecoration(
            hintStyle:
                GoogleFonts.oswald(textStyle: TextStyle(color: Colors.white)),
            border: InputBorder.none,
            icon: IconButton(
              icon: icon,
              onPressed: iconpressed,
            ),
            hintText: hint, //lt2,
          ),
        ),
      ),
    );
  }
}
