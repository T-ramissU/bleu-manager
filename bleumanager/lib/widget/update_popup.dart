import 'dart:io' show Platform;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:bleumanager/util/server_connector.dart';

Future<void> checkUpdate(BuildContext context) async {
  Tuple3? versionInfo = await ServerConnector.versionInfo();

  PackageInfo localInfo = await PackageInfo.fromPlatform();
  String localVersion = localInfo.version;

  if (versionInfo != null && localVersion != versionInfo.item1) {
    String link = "'Erreur : plateforme non supportée'";
    if (Platform.isAndroid) {
      link = versionInfo.item2;
    } else if (Platform.isIOS) {
      link = versionInfo.item3;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => _UpdatePopup(link),
    );
  }
}

class _UpdatePopup extends StatelessWidget {
  final String link;

  const _UpdatePopup(this.link);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Mise à jour disponnible'),
      //Text("Une nouvelle version de l'application est disponnible.\nVeuillez la télécharger ici :\n$link.\nMerci d'ensuite l'installer."),
      content: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              style: TextStyle(color: Colors.black),
              text:
                    "Une nouvelle version de l'application est disponnible.\nVeuillez la télécharger ici :\n",),
            TextSpan(
              text: "$link\n",
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()..onTap = () => launch(link),
            ),
            const TextSpan(
              style: TextStyle(color: Colors.black),
              text:
              "Et ensuite l'installer.",),
          ],
        ),
      ),
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
  }
}
