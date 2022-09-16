import 'package:flutter/material.dart';

import 'package:bleumanager/widget/login_page.dart';
import 'package:bleumanager/widget/list_page.dart';
import 'package:bleumanager/util/credential.dart';

void main() async {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final String title = "Bleu Manager ${DateTime.now().year}";
  late final ListPage listPage;
  late final LoginPage loginPage;
  late Future<bool> credentialLoaded;

  @override
  void initState() {
    super.initState();
    credentialLoaded = Credential().load();
    listPage = ListPage(title: title);
    loginPage = LoginPage(title: title);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: credentialLoaded,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Widget home = snapshot.data! ? listPage : loginPage;
          // Credential loaded
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
        // Credential not yet loaded
        else {
          return const Center(
            child: Image(
              image: AssetImage('assets/polytech.png'),
            ),
          );
        }
      },
    );
  }
}
