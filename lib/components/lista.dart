import 'package:flutter/material.dart';
import 'package:lista_flutter/components/add.dart';

import 'card.dart';

class Lista extends StatefulWidget {
  Lista({Key? key}) : super(key: key);

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 150),
              decoration: new BoxDecoration(
                  color: Color(0xFF000000).withOpacity(0.2),
                  borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(40.0),
                    bottomRight: const Radius.circular(40.0),
                  )),
              width: 350,
              height: 400,
              child: MongoData(),
              //Lista recebendo dados
            ),
          ),
          Container(
            //Tinta escorrendo png
            child: Image(
              image: AssetImage("image/preto.png"),
            ),
          ),
          Row(
            //Logo
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                width: 300,
                child: Image(
                  image: AssetImage("image/logo.png"),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            width: 250,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF151E3D),
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MongoInsert()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
