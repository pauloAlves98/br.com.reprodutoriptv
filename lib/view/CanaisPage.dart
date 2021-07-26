import 'package:flutter/material.dart';
import 'package:iptv/model/utils/Constantes.dart';

class CanaisPage extends StatefulWidget {
  const CanaisPage({Key? key}) : super(key: key);

  @override
  _CanaisPageState createState() => _CanaisPageState();
}

class _CanaisPageState extends State<CanaisPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              bilderCardCanal(),
              bilderCardCanal(),
              bilderCardCanal(),
              bilderCardCanal(),
            ],
          ),
        ),
      ],
    );
  }

  Widget bilderCardCanal() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.fill,
            colorFilter: new ColorFilter.mode(
                Color.fromRGBO(0, 0, 0, 0.8), BlendMode.srcOver),
            image: Constantes.USER_ASSET,
          ),
        ),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  Color.fromRGBO(0, 0, 0, 0.8), BlendMode.srcOver),
              image: NetworkImage(
                  "https://poltronanerd.com.br/wp-content/uploads/2020/09/Supernatural-cartaz.jpg"),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              focusColor:Colors.black,
              title: Text(
                "Sobrenatural 3".length > 20
                    ? "Sobrenatural 3".substring(0, 20)
                    : "Sobrenatural 3", //separar por catgoria e listar na tela.
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "test",
                overflow: TextOverflow.ellipsis,
              ),
              leading: CircleAvatar(
                child: Tooltip(
                     message: "Executar",
                     child: IconButton(
                       
                       icon: Icon(Icons.play_arrow_outlined), 
                       onPressed: () {  },
                     ),
                   ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
