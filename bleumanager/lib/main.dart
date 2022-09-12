import 'package:flutter/material.dart';

import 'package:bleumanager/widget/login_page.dart';
import 'package:bleumanager/widget/list_page.dart';
import 'package:bleumanager/util/credential.dart';

void main() async {
  // required to load credential
  WidgetsFlutterBinding.ensureInitialized();
  // credential are loadead before running the app in order to determine
  // which home page to display
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
    final LoginPage loginPage = LoginPage(title: title);
    final Widget home = credExists ? listPage : loginPage;

    return MaterialApp(
      title: 'Bleu Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/list': (context) => listPage,
        '/login': (context) => loginPage,
      },
      home: home,
    );
  }
}
