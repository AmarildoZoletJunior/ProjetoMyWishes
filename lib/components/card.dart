import 'package:flutter/material.dart';
import 'package:lista_flutter/components/update.dart';
import 'package:lista_flutter/dbhelp/MongoModel.dart';
import 'package:lista_flutter/dbhelp/mongoconnect.dart';

class MongoData extends StatefulWidget {
  const MongoData({Key? key}) : super(key: key);

  @override
  State<MongoData> createState() => _MongoDataState();
}

class _MongoDataState extends State<MongoData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDatabase.pegarDados(),
        builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }else{
        if(snapshot.hasData){
          var totalData = snapshot.data.length;
          print("Total data: ${totalData.toString()}");
          return ListView.builder(
            itemCount: snapshot.data.length,
              itemBuilder: (context,index){
            return CardList(MongoDbModel.fromJson(snapshot.data[index]));
          });
        }else{
          return Center(child: Text("Não existe desejos cadastrados"),);
        }
      }
    });
  }
  Widget CardList(MongoDbModel data){
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
    ),
    color: Color(0xFF3C89D0),
    child: ListTile(
      contentPadding: EdgeInsets.all(10),
    // thumbnail:Image.network("${data.url}"),)
      leading: Image.network("${data.url}"),
      title: Text('${data.titulo}'),
      trailing:Column(
        children: [
          IconButton(
            icon:Icon(Icons.arrow_forward,size: 20,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return MongoUpdate();
              },settings: RouteSettings(arguments: data)))
                  .then((value) => setState(() {}));
            },
          ),
        ],
      ),

    ),
  );
  }
}
