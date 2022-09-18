import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:bleumanager/util/server_connector.dart';
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
    // Check version after build finished
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVersion();
    });

    return FutureBuilder<bool>(
      future: credentialLoaded,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Widget home = snapshot.data! ? listPage : loginPage;
          // Credential loaded
          return MaterialApp(
            title: 'Bleu Manager',
            theme: ThemeData(
                primarySwatch: Colors.red,
              scaffoldBackgroundColor: Colors.black12

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

  Future<void> _checkVersion() async {
    Tuple3? versionInfo = await ServerConnector.versionInfo();

    PackageInfo localInfo = await PackageInfo.fromPlatform();
    String localVersion = localInfo.version;

    if(versionInfo != null && localVersion != versionInfo.item1){
      String link = "";
      if (Platform.isAndroid) {
        link = versionInfo.item2;
      } else if (Platform.isIOS) {
        link = versionInfo.item3;
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Mise à jour disponnible'),
            content: Text("Une mise à jour est disponnible, vous pouvez la télécharger ici : $link. Puis veuillez l'installer."),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Plus tard'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }
}

