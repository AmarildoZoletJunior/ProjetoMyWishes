import 'dart:convert';
import 'dart:math';


import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lista_flutter/components/lista.dart';
import 'package:lista_flutter/dbhelp/MongoModel.dart';
import 'package:lista_flutter/dbhelp/mongoconnect.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class MongoUpdate extends StatefulWidget {
  const MongoUpdate({Key? key}) : super(key: key);

  @override
  State<MongoUpdate> createState() => MongoUpdate_();
}



class MongoUpdate_ extends State<MongoUpdate> {
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MongoDbModel data = ModalRoute.of(context)!.settings.arguments as MongoDbModel;
    if(data != null){
      tituloController.text = data.titulo;
      motivoController.text = data.descricao;
      numberController.text = data.url;
    }

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
                  child: Form(
                    key: _formKey,
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
                            validator: (value){
                              if(value.toString().length < 3){
                                return 'Este campo necessita de pelo menos 3 caracteres';
                              }
                            },
                            controller: tituloController,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 11,
                              ),
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
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            validator: (value){
                              if(value.toString().length < 3){
                                return 'Este campo necessita de pelo menos 3 caracteres';
                              }
                            },
                            controller: motivoController,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontSize: 11,
                              ),
                              prefixIcon: Icon(Icons.description),
                              labelText: 'Descrição',
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
                              update(data.id, tituloController.text, motivoController.text, numberController.text);
                              print("asdasd");
                            },
                            child: Text(
                              'Alterar',
                              style: TextStyle(fontSize: 30),
                            ),
                            style: ElevatedButton.styleFrom(
                              // backgroundColor: Color(0xFF151E3D),
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> update(
      var id, String titulo, String motivo,String url) async{
    final updateData = MongoDbModel(id: id, titulo: titulo, descricao: motivo, url: url);
  }

}
