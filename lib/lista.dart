import 'package:flutter/material.dart';

import 'lista_tarefas.dart';


class Lista extends StatefulWidget {

  Lista({Key? key}) : super(key: key);

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {

  var controller = ListaTarefas();

  int selector = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          /*Positioned(
            right: -,
              child:
              Container(
                height:600,
                width: 600,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              )
          ), */
          Container(
            child: Image(image: AssetImage("image/preto.png"),) ,
          ),
          Row(
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
            height: 520,
            child: ListView.builder(
              itemCount: controller.tarefas.length,
              itemBuilder: (BuildContext contexto, int i){
                final tarefas = controller.tarefas;
                return Container(
                  width: 150,
                  height: 90,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    color: Color(0xFF93000A),
                    child: ListTile(
                      leading: IconButton(
                          icon:Icon(Icons.arrow_forward),
                        onPressed: (){
                          print("Estou imprimindo no console");
                        },
                          ),
                      title: Text(tarefas[i].descricao,
                      style: const TextStyle(
                        fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                );
              },
              padding: const EdgeInsets.all(10),

            ),
          ),
        ),
    ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            width: 250,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF93000A),
              child: Icon(Icons.add),
              onPressed: (){
                print("Estou imprimindo no console");
              },
            ),
          ),
        ],
      ),
    );
  }
}
