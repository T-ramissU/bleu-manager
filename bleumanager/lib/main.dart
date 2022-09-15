import 'package:flutter/material.dart';

import 'package:bleumanager/widget/login_page.dart';
import 'package:bleumanager/widget/list_page.dart';
import 'package:bleumanager/util/credential.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = "Bleu Manager ${DateTime.now().year}";
    final ListPage listPage = ListPage(title: title);
    final LoginPage loginPage = LoginPage(title: title);

    return FutureBuilder<bool>(
        future: Credential().load(),
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
        });
  }
}
