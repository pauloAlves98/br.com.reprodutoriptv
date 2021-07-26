
import 'package:flutter/material.dart';

const Color AZUL_LEVE = Color(0xFF041840);
const Color AZUL_ESCURO = Color(0xFF041830);
const Color AZUL_ALTERNATIVO =  Color.fromRGBO(0, 160, 227, 1);
const  LinearGradient GRADIENTE_CABECARIO = LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [ AZUL_LEVE, AZUL_ESCURO],
);

const LinearGradient GRADIENTE_BODY = LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:[AZUL_LEVE, AZUL_ESCURO],
);



class Constantes {
 static AssetImage USER_ASSET = AssetImage("assets/user.png");
}


