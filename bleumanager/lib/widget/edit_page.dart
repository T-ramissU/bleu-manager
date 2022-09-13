import 'package:flutter/material.dart';

import 'package:bleumanager/object/bleu.dart';

/// Offer to the user the possibility to modify a bleu
class EditPage extends StatefulWidget {
  final Bleu _bleu;

  /// [_bleu] to modify in the page
  const EditPage(this._bleu, {super.key});

  @override
  State<EditPage> createState() => _EditPageState(_bleu);
}

class _EditPageState extends State<EditPage> {
  final Bleu bleu;

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final numberController = TextEditingController();
  final regioController = TextEditingController();
  final medicalController = TextEditingController();
  final locController = TextEditingController();
  final ageController = TextEditingController();
  final bdController = TextEditingController();
  final sexeController = TextEditingController();
  final respController = TextEditingController();
  final telrespController = TextEditingController();
  final ramController1 = TextEditingController();
  final ramController2 = TextEditingController();
  final ramController3 = TextEditingController();
  final ramController4 = TextEditingController();

  _EditPageState(this.bleu);

  @override
  void initState() {
    super.initState();
    // TODO MARK AS MODIFIED TO UPDATE THEM ON SAVE
    fnameController.addListener(() => setState(() {}));
    lnameController.addListener(() => setState(() {}));
    numberController.addListener(() => setState(() {}));
    regioController.addListener(() => setState(() {}));
    medicalController.addListener(() => setState(() {}));
    sexeController.addListener(() => setState(() {}));
    locController.addListener(() => setState(() {}));
    ageController.addListener(() => setState(() {}));
    bdController.addListener(() => setState(() {}));
    respController.addListener(() => setState(() {}));
    telrespController.addListener(() => setState(() {}));
    ramController1.addListener(() => setState(() {}));
    ramController2.addListener(() => setState(() {}));
    ramController3.addListener(() => setState(() {}));
    ramController4.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hides keyboard when the screen is pressed
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    buildFName(bleu),
                    const SizedBox(height: 24),
                    buildLName(bleu),
                    const SizedBox(height: 24),
                    buildNumber(bleu),
                    const SizedBox(height: 24),
                    buildLocation(bleu),
                    const SizedBox(height: 24),
                    buildMedical(bleu),
                    const SizedBox(height: 24),
                    buildCom(bleu),
                    const SizedBox(height: 24),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                        disabledForegroundColor: Colors.red.withOpacity(0.38),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        //TODO mettre à jour ce qui a été modifié
                      },
                      child: const Text("Mettre à jour"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFName(Bleu bleu) => TextField(
        controller: TextEditingController()..text = bleu.firstname,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Prénom',
          prefixIcon: Icon(Icons.person_outline_outlined),
        ),
        keyboardType: TextInputType.name,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildLName(Bleu bleu) => TextField(
        controller: TextEditingController()..text = bleu.lastname,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nom',
          prefixIcon: Icon(Icons.person_outline),
        ),
        // suggests emails when keyboard is opened if any saved
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
      );

  Widget buildNumber(Bleu bleu) => TextField(
        controller: TextEditingController()..text = bleu.tel,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Numéro de téléphone',
          prefixIcon: Icon(Icons.phone),
        ),
        keyboardType: TextInputType.number,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildLocation(Bleu bleu) => TextField(
        controller: TextEditingController()..text = bleu.regio,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Régional',
          prefixIcon: Icon(Icons.location_on),
        ),
        keyboardType: TextInputType.text,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildMedical(Bleu bleu) => TextField(
        controller: TextEditingController()..text = bleu.med,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Problèmes médicaux',
          prefixIcon: Icon(Icons.medical_services),
        ),
        keyboardType: TextInputType.multiline,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: 5,
      );

  Widget buildCom(Bleu bleu) => TextField(
        controller: TextEditingController()..text = bleu.com,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Commentaires',
          prefixIcon: Icon(Icons.comment),
        ),
        keyboardType: TextInputType.multiline,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: 3,
      );
}
