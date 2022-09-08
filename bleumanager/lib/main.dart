import 'package:flutter/material.dart';
import 'package:bleumanager/widget/login_page.dart';
import 'package:bleumanager/widget/list_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = "Bleu Manager ${DateTime.now().year}";

    return MaterialApp(
      title: 'Bleu Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: title),
      // TODO: si la personne est déjà connecté affiché la ListPage
      // TODO: ou peut etre faire ça dans LoginPage ?
    );
  }
}
