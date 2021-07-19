//@dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  static HomePage _instance; //Singleton
  static int cIndex = 0;

  HomePage._internal();
  static HomePage getInstance() {
    if (_instance == null) _instance = HomePage._internal();
    return _instance;
  }

  //const HomePage({ Key? key }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   TextEditingController tituloController = new TextEditingController();
    _HomePageState(){
     tituloController.text = "IPTV canais";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF041840), Color(0xFF041830)],
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: TextField(
            style: GoogleFonts.indieFlower(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 30)),
            readOnly: true,
            controller: tituloController,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Align(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
            onPressed: () {
              //Para encolher a barra!
              setState(() {});
            }
        ),
        ],
      ),


      bottomNavigationBar: BottomNavigationBar(//mecher aqui e dpois fazer as paginas, começar por cadastro de conta.
        fixedColor:  Colors.white,
        selectedLabelStyle: GoogleFonts.encodeSans(),
        backgroundColor: Colors.black,
        currentIndex: HomePage.cIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Colors.black38,
            backgroundColor: Colors.black,
            icon: Icon(Icons.receipt,color: Color(0xFF232c47)),
            label: 'Lista',
            activeIcon:CircleAvatar(backgroundColor: Color(0xFF041840),child:Icon(Icons.receipt, color:Colors.white)),
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.tv, color: Color(0xFF232c47)),
              label: 'Canais',
              activeIcon:  CircleAvatar(backgroundColor: Color(0xFF041830),child:Icon(Icons.tv, color:Colors.white )),
              ),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(Icons.person, color: Color(0xFF232c47)),
              activeIcon: CircleAvatar(backgroundColor: Color(0xFF041840),child:Icon(Icons.person, color:Colors.white )),
              label: 'Conta',
          )
        ],
        onTap: (index) {
          _incrementTab(index);
        },
      ),



      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF041840), Color(0xFF041830)],
            ),
    
          ),
        ),
    );
  }

  void _incrementTab(indice) {
    setState(() {
      print("ANTIGO");
      HomePage.cIndex = indice;
      print("Atual " + "$indice");
    });
  }
}
