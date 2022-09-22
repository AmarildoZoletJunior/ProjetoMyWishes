import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel{
    MongoDbModel({
        required this.id,
        required this.titulo,
        required this.descricao,
        required this.url,
});

ObjectId id;
String titulo;
String descricao;
String url;

    factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        titulo: json["titulo"],
        descricao: json["descricao"],
        url: json["url"],
    );
    Map<String, dynamic> toJson() =>{
        "_id": id,
        "titulo": titulo,
        "descricao": descricao,
        "url": url,
    };
    }
