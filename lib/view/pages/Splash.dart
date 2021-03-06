import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iptv/main.dart';
import 'package:iptv/model/bin/Cliente.dart';
import 'package:iptv/model/bin/Lista.dart';
import 'package:iptv/model/utils/Constantes.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iptv/model/utils/Corrente.dart';

import '../../repository/DTO/ClienteDTO.dart';
import '../../repository/DTO/ListaDTO.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> { // Modificar esse splash!
  ClienteDTO? clienteDTO = ClienteDTO.instance;
  
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    //TEMPORÁRIO, POR ENQUANTO .
    List <Cliente> clientes = await clienteDTO!.getAll();
    if(clientes.isEmpty){
      Corrente.clienteCorrente = Cliente.full("Developed by Paulo Alves", "github.com/pauloAlves98", "alvespaulo737@gmail.com", "123456", DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(), 1);
      await clienteDTO?.insert(Corrente.clienteCorrente);
    }
    return new Timer(new Duration(seconds: 3), navigationPage);
  }

  void navigationPage() async {

    List <Cliente> clientes = await clienteDTO!.getAll();  //temporario. 
    Corrente.clienteCorrente = clientes.last;
    Corrente.listasCorrente = await ListaDTO.instance!.getAllCliente(Corrente.clienteCorrente.id);
    print("CLIENTE LOAD EM SPLASH!");
    Navigator.pushReplacementNamed(context, HOMEPAGE);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AZUL_ESCURO,
        body: Center(
      child: SizedBox.expand(child:FlutterLogo(style: FlutterLogoStyle.markOnly,curve: Curves.bounceOut,)))
    );
  }
}