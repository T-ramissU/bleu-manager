import 'package:flutter/material.dart';
import 'package:bleumanager/util/credential.dart';
import 'package:bleumanager/util/server_connector.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.only(right: 35, left: 35, bottom: 15),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/polytech.png'),
                alignment: AlignmentDirectional.topEnd)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.redAccent),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: matriculeController,
              decoration: InputDecoration(
                hintText: 'Matricule',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.blueAccent),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: tokenController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'Se connecter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.redAccent,
                child: IconButton(
                    onPressed: () {
                      Credential().save(matriculeController.value.text,
                          tokenController.value.text);
                      ServerConnector.checkAdmin(Credential()).then((ok) {
                        if (ok) {
                          Navigator.pushReplacementNamed(
                            context,
                            "/list",
                          );
                        } else {
                          Credential().delete();
                          setState(() {
                            errorMessage = "Identifiant invalide";
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.arrow_forward_rounded)),
              )
            ])
          ],
        ),
      ),
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
