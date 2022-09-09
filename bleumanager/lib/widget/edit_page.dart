// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:bleumanager/object/bleu.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final Bleu _bleu;

  const EditPage(this._bleu, {super.key});

  @override
  State<EditPage> createState() => _EditPageState(_bleu);
}

class _EditPageState extends State<EditPage> {
  final Bleu bleu;
  final matriculeController = TextEditingController();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final numberController = TextEditingController();
  final locationController = TextEditingController();
  final medicalController = TextEditingController();

  _EditPageState(this.bleu);

  @override
  void initState() {
    super.initState();
    matriculeController.addListener(() => setState(() {}));
    fnameController.addListener(() => setState(() {}));
    lnameController.addListener(() => setState(() {}));
    numberController.addListener(() => setState(() {}));
    locationController.addListener(() => setState(() {}));
    medicalController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          buildMatricule(bleu),
          const SizedBox(height: 24),
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
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.redAccent,
              disabledForegroundColor: Colors.red.withOpacity(0.38),
            ),
            onPressed: () {},
            child: Text("Mettre à jour"),
          ),
        ],
      ),
    );
  }

  Widget buildMatricule(Bleu bleu) => TextField(
        controller: matriculeController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Matricule',
            hintText: "]-${bleu.matricule}",
            prefixIcon: Icon(Icons.numbers),
            suffixIcon: matriculeController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => matriculeController.clear(),
                  )),
        keyboardType: TextInputType.number,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildFName(Bleu bleu) => TextField(
        controller: fnameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Prénom',
            hintText: bleu.firstname,
            prefixIcon: Icon(Icons.person_outline_outlined),
            suffixIcon: fnameController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => fnameController.clear(),
                  )),
        keyboardType: TextInputType.name,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildLName(Bleu bleu) => TextField(
        controller: fnameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nom',
            hintText: bleu.lastname,
            prefixIcon: Icon(Icons.person_outline),
            suffixIcon: lnameController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => lnameController.clear(),
                  )),
        keyboardType: TextInputType.name,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildNumber(Bleu bleu) => TextField(
        controller: numberController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Numéro de téléphone',
            hintText: bleu.tel,
            prefixIcon: Icon(Icons.phone),
            suffixIcon: numberController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => numberController.clear(),
                  )),
        keyboardType: TextInputType.number,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildLocation(Bleu bleu) => TextField(
        controller: locationController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Régional',
            hintText: bleu.regio,
            prefixIcon: Icon(Icons.location_on),
            suffixIcon: locationController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => locationController.clear(),
                  )),
        keyboardType: TextInputType.text,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildMedical(Bleu bleu) => TextField(
        controller: medicalController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Problèmes médicaux',
            hintText: bleu.med,
            prefixIcon: Icon(Icons.medical_services),
            suffixIcon: medicalController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => medicalController.clear(),
                  )),
        keyboardType: TextInputType.text,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: 4,
      );
}
