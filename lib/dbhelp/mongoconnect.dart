
import 'dart:developer';

import 'package:lista_flutter/dbhelp/MongoModel.dart';
import 'package:lista_flutter/dbhelp/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async{
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    print("Funcionando");
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }
  static Future<void> update(MongoDbModel data) async{
    var resultado = await userCollection.findOne({"_id": data.id});
    resultado['titulo'] = data.titulo;
    resultado['descricao'] = data.descricao;
    resultado['url'] = data.url;
    await userCollection.save(resultado);
  }

  static Future<String> insert(MongoDbModel data) async{
    try{
      var result = await userCollection.insertOne(data.toJson());
      if(result.isSuccess){
        return "Dado coletado";
      }else{
        return "Não foi possivel inserir o dado";
      }

    } catch(e){
      print(e.toString());
      return e.toString();
    }
  }

  static Future<List<Map<String,dynamic>>> pegarDados() async{
    final arrayDados = await userCollection.find().toList();
    return arrayDados;
  }
}