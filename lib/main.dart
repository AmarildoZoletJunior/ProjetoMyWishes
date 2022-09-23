import 'package:flutter/material.dart';
import 'package:lista_flutter/components/add.dart';
import 'package:lista_flutter/dbhelp/mongoconnect.dart';

import 'Cores/color_schemes.dart';
import 'components/card.dart';
import 'components/lista.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          scaffoldBackgroundColor: const Color(0xFF4ADEDE),
        ),
        title: "components Flutter",
        home: Scaffold(
          body: Lista(),
        ));
  }
}
