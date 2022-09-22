import 'dart:convert';


import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lista_flutter/components/lista.dart';
import 'package:lista_flutter/dbhelp/MongoModel.dart';
import 'package:lista_flutter/dbhelp/mongoconnect.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class MongoInsert extends StatefulWidget {
  const MongoInsert({Key? key}) : super(key: key);

  @override
  State<MongoInsert> createState() => _MongoInsertState();
}



class _MongoInsertState extends State<MongoInsert> {
  var tituloController = new TextEditingController();
  var motivoController = new TextEditingController();
  var numberController = new TextEditingController();
  var pokemon;

  Future<String> fetch(int number) async{
    var ur;
    var url =  await Uri.https("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    await http.get(url).then( await(value){
      var decode = jsonDecode(value.body);
      pokemon = decode['pokemon'];
      var novo = pokemon[number]['img'];
      ur = novo;
    });
    return ur;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xFF3C89D0),
          body: Stack(
            children: [
              Container(
                child: Positioned(
                  top: 130,
                  left: -200,
                  width: 800.0,
                  height: 600.0,
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Text(
                        "Adicionar Desejo a lista",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                      Container(
                          margin: EdgeInsets.only(
                              left: 50, right: 50, top: 20, bottom: 20),
                          child: Text(
                              "Seja criativo para o titulo e a descrição. Talvez este desejo esteja perto de se realizar",
                              textAlign: TextAlign.center)),
                      Container(
                        width: 290,
                        height: 100,
                        child: TextFormField(
                          controller: tituloController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.favorite),
                            labelText: 'Titulo',
                            filled: true,
                            fillColor: Colors.blue.shade100,
                          ),
                        ),
                      ),
                      Container(
                        width: 290,
                        height: 80,
                        child: TextFormField(
                          controller: motivoController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            labelText: 'Descrição',
                            filled: true,
                            fillColor: Colors.blue.shade100,
                          ),
                        ),
                      ),
                      Container(
                        width: 290,
                        height: 80,
                        child: TextFormField(
                          controller: numberController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            labelText: 'Digite um numero(Mágica)',
                            filled: true,
                            fillColor: Colors.blue.shade100,
                          ),
                        ),
                      ),
                      Container(
                          width: 270,
                          height: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              insert(tituloController.text,motivoController.text,numberController.text);
                            },
                            child: Text(
                              'Enviar',
                              style: TextStyle(fontSize: 30),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF151E3D),
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> insert(String titulo, String descricao,String url) async{
    var myInt = int.parse(url);
    assert(myInt is int);
   var novo = await fetch(myInt);
  var id = M.ObjectId();
  final data = MongoDbModel(
      id: id, titulo: titulo, descricao: descricao, url: novo);
  var result = await MongoDatabase.insert(data);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Desejo inserido com sucesso",textAlign: TextAlign.center,)));
  limpar();
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Lista()));
  }

  void limpar(){
    tituloController.text = "";
    motivoController.text = "";
    numberController.text = "";
  }

}
