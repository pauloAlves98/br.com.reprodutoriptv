//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_manager/flutter_sqflite_manager.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';
import 'model/sqlite/SqlHelper.dart';

class SGBDPage extends StatefulWidget {
  @override
  _SGBDPageState createState() => _SGBDPageState();
}

class _SGBDPageState extends State<SGBDPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: SqlHelper().db,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SqfliteManager(
              database: snapshot.data,
              enable: true,
              child: MyApp.getInstance(),
          );
        } else {
          return Container(
              alignment: Alignment.center, child: CircularProgressIndicator());
        }
      },
    );
  }
}