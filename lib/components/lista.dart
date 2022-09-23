import 'package:flutter/material.dart';
import 'package:lista_flutter/components/add.dart';

import '../dados/lista_tarefas.dart';
import 'card.dart';



class Lista extends StatefulWidget {

  Lista({Key? key}) : super(key: key);

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {

  var controller = ListaTarefas();

  int selector = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            //Tinta escorrendo png
            child: Image(image: AssetImage("image/preto.png"),) ,
          ),
          Row(
            //Logo
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 300,
                 child: Image(image: AssetImage("image/logo.png"),),),
            ],
          ),
      Center(
          child: Container(
            margin: EdgeInsets.only(top: 130),
            decoration: new BoxDecoration(
                color: Color(0xFF000000).withOpacity(0.2),
                borderRadius: new BorderRadius.only(
                    topLeft:  const  Radius.circular(40.0),
                    topRight: const  Radius.circular(40.0),
                    bottomLeft: const  Radius.circular(40.0),
                    bottomRight: const  Radius.circular(40.0),)
            ),
            clipBehavior: Clip.hardEdge,
            width: 350,
            height: 450,
          child: MongoData(),
            //Lista recebendo dados
          ),
        ),
    ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15,top: 10),
            width: 250,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF151E3D),
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MongoInsert()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
