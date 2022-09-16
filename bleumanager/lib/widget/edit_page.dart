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

  late final fnameController ;
  final lnameController = TextEditingController();
  final numberController = TextEditingController();
  final regioController = TextEditingController();
  final medicalController = TextEditingController();
  final locController = TextEditingController();
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
    fnameController=TextEditingController(text: bleu.firstname);
    lnameController.addListener(() => setState(() {}));
    numberController.addListener(() => setState(() {}));
    regioController.addListener(() => setState(() {}));
    medicalController.addListener(() => setState(() {}));
    sexeController.addListener(() => setState(() {}));
    locController.addListener(() => setState(() {}));
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
        backgroundColor: Colors.blueAccent,
        body: Stack(
          children: [
            SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.08,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    buildFName(bleu),
                    const SizedBox(height: 24),
                    buildLName(bleu),
                    const SizedBox(height: 24),
                    buildSexe(bleu),
                    const SizedBox(height: 24),
                    buildNumber(bleu),
                    const SizedBox(height: 24),
                    buildLoc(bleu),
                    const SizedBox(height: 24),
                    buildRegio(bleu),
                    const SizedBox(height: 24),
                    buildResp(bleu),
                    const SizedBox(height: 24),
                    buildTelResp(bleu),
                    const SizedBox(height: 24),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                        disabledForegroundColor: Colors.red.withOpacity(0.38),
                      ),
                      onPressed: () {
                        update(bleu);
                        Navigator.pop(context);
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

  Widget buildFName(Bleu bleu) => TextFormField(
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
          prefixIcon: Icon(Icons.person_outline_outlined),
        ),
        keyboardType: TextInputType.name,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildLName(Bleu bleu) => TextFormField(
        initialValue: bleu.lastname,

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

  Widget buildNumber(Bleu bleu) => TextFormField(
        initialValue: bleu.tel,
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
          prefixIcon: Icon(Icons.phone),
        ),
        keyboardType: TextInputType.number,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildMedical(Bleu bleu) => TextFormField(
        initialValue: bleu.med,
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
          prefixIcon: Icon(Icons.medical_services),
        ),
        keyboardType: TextInputType.multiline,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: 5,
      );

  Widget buildSexe(Bleu bleu) => TextFormField(
        controller: TextEditingController()..text = bleu.sexe,
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
          prefixIcon: Icon(Icons.accessibility_sharp),
        ),
        keyboardType: TextInputType.text,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildLoc(Bleu bleu) => TextFormField(
        initialValue: bleu.loc,
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
          prefixIcon: Icon(Icons.house),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      );

  Widget buildRegio(Bleu bleu) => Container(
      padding: EdgeInsets.only(
        right: 95,
        left: 95,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white70,
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        value: bleu.regio,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        hint: const Text("Region"),
        onChanged: (String? value) {
          setState(() {
            bleu.regio = value!;
          });
        },
        items: bleuAllRegio.map<DropdownMenuItem<String>>((String regio) {
          return DropdownMenuItem<String>(
            value: regio,
            child: Text(regio),
          );
        }).toList(),
      )));

  Widget buildResp(Bleu bleu) => TextFormField(
        initialValue: bleu.resp,
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
          prefixIcon: Icon(Icons.person),
        ),
        keyboardType: TextInputType.text,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  Widget buildTelResp(Bleu bleu) => TextFormField(
        initialValue: bleu.telresp,
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
          prefixIcon: Icon(Icons.phone),
        ),
        keyboardType: TextInputType.number,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
      );

  void update(Bleu bleu) {
      bleu.firstname = "yssss";
   /* if (lnameController.value.text != bleu.lastname) {
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
    if (regioController.value.text != bleu.regio) {
      bleu.regio = regioController.value.text;
    }
    if (locController.value.text != bleu.loc) {
      bleu.loc = locController.value.text;
    }
    if (respController.value.text != bleu.resp) {
      bleu.resp = respController.value.text;
    }
    if (telrespController.value.text != bleu.telresp) {
      bleu.telresp = telrespController.value.text;
    }*/
  }
}
