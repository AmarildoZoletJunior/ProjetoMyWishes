import 'dart:convert';
import 'dart:math';


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

  final _formKey = GlobalKey<FormState>();

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
                                "Seja criativo para o titulo e a descri????o. Talvez este desejo esteja perto de se realizar",
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
                          constraints: BoxConstraints(
                            maxHeight: 150,
                          ),
                          width: 290,
                          height: 80,
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            maxLines: null,
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
                              labelText: 'Descri????o',
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
                                if (_formKey.currentState!.validate()) {
                                  insert(tituloController.text,
                                      motivoController.text,
                                  );
                                   }
                                },
                              child: Text(
                                'Enviar',
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

  Future<void> insert(String titulo, String descricao) async{
    Random random = new Random();
    int randomNumber = random.nextInt(200);
   var novo = await fetch(randomNumber);
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
