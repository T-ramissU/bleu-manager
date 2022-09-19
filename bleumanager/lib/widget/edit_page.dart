import 'package:bleumanager/object/bleu.dart';
import 'package:flutter/material.dart';

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

  /// Contains the regios to display, null means all
  String? selectedRegio;

  late final TextEditingController fnameController;

  late final TextEditingController lnameController;

  late final TextEditingController numberController;

  late final TextEditingController medicalController;
  late final TextEditingController locController;

  late final TextEditingController bdController;

  late final TextEditingController sexeController;

  late final TextEditingController respController;

  late final TextEditingController telrespController;

  late final TextEditingController ramController1;

  late final TextEditingController ramController2;

  late final TextEditingController ramController3;

  late final TextEditingController ramController4;

  late String regioController;

  _EditPageState(this.bleu);

  @override
  void initState() {
    //String? initValue= bleu.regio;
    super.initState();
    fnameController = TextEditingController(text: bleu.firstname);
    lnameController = TextEditingController(text: bleu.lastname);
    numberController = TextEditingController(text: bleu.tel);
    medicalController = TextEditingController(text: bleu.med);
    sexeController = TextEditingController(text: bleu.sexe);
    locController = TextEditingController(text: bleu.loc);
    bdController = TextEditingController(text: bleu.bd);
    respController = TextEditingController(text: bleu.resp);
    telrespController = TextEditingController(text: bleu.telresp);
    ramController1 = TextEditingController(text: bleu.ram1);
    ramController2 = TextEditingController(text: bleu.ram2);
    ramController3 = TextEditingController(text: bleu.ram3);
    ramController4 = TextEditingController(text: bleu.ram4);
    regioController = bleu.regio;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hides keyboard when the screen is pressed
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.red,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            padding: const EdgeInsets.all(35),
            child: Column(
              children: [
                buildFName(),
                const SizedBox(height: 24),
                buildLName(),
                const SizedBox(height: 24),
                buildSexe(),
                const SizedBox(height: 24),
                buildNumber(),
                const SizedBox(height: 24),
                buildLoc(),
                const SizedBox(height: 24),
                buildRegio(),
                const SizedBox(height: 24),
                buildResp(),
                const SizedBox(height: 24),
                buildTelResp(),
                const SizedBox(height: 60),
                SizedBox(
                    height: 50,
                    width: 200,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        disabledForegroundColor: Colors.red.withOpacity(0.38),
                      ),
                      onPressed: () {
                        update(bleu);
                        Navigator.pop(context);
                      },
                      child: const Text("Mettre à jour"),
                    )),
              ],
            ),
          ),
        ),
        appBar: AppBar(),
      ),
    );
  }

  Widget buildFName() => TextFormField(
        controller: fnameController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white70,
              )),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          filled: true,
          fillColor: Colors.white70,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
          labelText: 'Prénom',
          prefixIcon: const Icon(Icons.person_outline_outlined),
        ),
        keyboardType: TextInputType.name,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildLName() => TextFormField(
        controller: lnameController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white70,
              )),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          filled: true,
          fillColor: Colors.white70,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
          labelText: 'Nom',
          prefixIcon: const Icon(Icons.person_outline),
        ),
        // suggests emails when keyboard is opened if any saved
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
      );

  Widget buildNumber() => TextFormField(
        controller: numberController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white70,
              )),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          filled: true,
          fillColor: Colors.white70,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
          labelText: 'Tel',
          prefixIcon: const Icon(Icons.phone),
        ),
        keyboardType: TextInputType.number,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildMedical() => TextFormField(
        controller: medicalController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white70,
              )),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          filled: true,
          fillColor: Colors.white70,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
          labelText: 'Floquettes',
          prefixIcon: const Icon(Icons.medical_services),
        ),
        keyboardType: TextInputType.multiline,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: 5,
      );

  Widget buildSexe() => TextFormField(
        controller: sexeController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white70,
              )),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          filled: true,
          fillColor: Colors.white70,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
          labelText: 'Genre',
          prefixIcon: const Icon(Icons.accessibility_sharp),
        ),
        keyboardType: TextInputType.text,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildLoc() => TextFormField(
        controller: locController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white70,
              )),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          filled: true,
          fillColor: Colors.white70,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
          labelText: 'Adresse',
          prefixIcon: const Icon(Icons.house),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      );

  Widget buildRegio() => Container(
      padding: const EdgeInsets.only(
        right: 95,
        left: 95,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white70,
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        value: regioController,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            regioController = value!;
          });
        },
        items: bleuAllRegio.map<DropdownMenuItem<String>>((String regio) {
          return DropdownMenuItem<String>(
            value: regio,
            child: Text(regio),
          );
        }).toList(),
      )));

  Widget buildResp() => TextFormField(
        controller: respController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white70,
              )),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          filled: true,
          fillColor: Colors.white70,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
          labelText: 'Responsable Légal',
          prefixIcon: const Icon(Icons.person),
        ),
        keyboardType: TextInputType.text,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildTelResp() => TextFormField(
        controller: telrespController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white70,
              )),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          filled: true,
          fillColor: Colors.white70,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
          labelText: 'Tel du responsable légale',
          prefixIcon: const Icon(Icons.phone),
        ),
        keyboardType: TextInputType.number,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  void update(Bleu bleu) {
    if (fnameController.value.text != bleu.firstname) {
      bleu.firstname = fnameController.value.text;
    }
    if (lnameController.value.text != bleu.lastname) {
      bleu.lastname = lnameController.value.text;
    }
    if (numberController.value.text != bleu.tel) {
      bleu.tel = numberController.value.text;
    }
    if (medicalController.value.text != bleu.med) {
      bleu.med = medicalController.value.text;
    }
    if (sexeController.value.text != bleu.sexe) {
      bleu.sexe = sexeController.value.text;
    }
    if (regioController != bleu.regio) {
      bleu.regio = regioController;
    }
    if (locController.value.text != bleu.loc) {
      bleu.loc = locController.value.text;
    }
    if (respController.value.text != bleu.resp) {
      bleu.resp = respController.value.text;
    }
    if (telrespController.value.text != bleu.telresp) {
      bleu.telresp = telrespController.value.text;
    }
  }
}
