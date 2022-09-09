import 'package:flutter/material.dart';
import 'package:bleumanager/widget/login_page.dart';
import 'package:bleumanager/widget/list_page.dart';

import 'util/credential.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool credExists = await Credential().load();
  runApp(App(credExists));
}

class App extends StatelessWidget {
  final bool credExists;
  const App(this.credExists, {super.key});

  @override
  Widget build(BuildContext context) {
    final String title = "Bleu Manager ${DateTime.now().year}";
    final ListPage listPage = ListPage(title: title);
    final Widget home = credExists ? listPage : LoginPage(title: title);

    return MaterialApp(
      title: 'Bleu Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/list': (context) => listPage,
      },
      home: home,
    );
  }
}
