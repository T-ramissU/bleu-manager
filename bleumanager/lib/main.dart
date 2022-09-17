
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_version/new_version.dart';
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

    _checkVersion();

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
  void _checkVersion() async {
    final newVersion=NewVersion(
      androidId:"be.ac.umons.bleumanager",
      iOSId: "be.ac.umons.bleumanager",
    );
    // newVersion.showAlertIfNecessary(context: context);
    final status = await newVersion.getVersionStatus();
    if(status?.canUpdate==true){
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status!,
        allowDismissal: false,
        dialogTitle: "Mis à jour",
        dialogText: "Nouvelle mis a jour disponible. Passez de la version ${status.localVersion} à la version ${status.storeVersion}",
        dismissButtonText: " Plus tard ",
        dismissAction: (){
          SystemNavigator.pop();
        },
        updateButtonText: "Mettre à jour",
      );}}
}

