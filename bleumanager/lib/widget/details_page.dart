import 'package:bleumanager/widget/list_page.dart';
import 'package:flutter/material.dart';

import '../object/bleu.dart';

class DetailPage extends StatefulWidget {
  final Bleu _bleu;

  /// [_bleu] to modify in the page
  const DetailPage(this._bleu, {super.key});

  @override
  State<DetailPage> createState() => _DetailPageState(_bleu);
}

class _DetailPageState extends State<DetailPage> {
  final Bleu bleu;
  late final ramController1;
  late final ramController2;

  late final ramController3;

  late final ramController4;

  late final medController;

  late final comController;

  _DetailPageState(this.bleu);

  @override
  void initState() {
    super.initState();
    ramController1 = TextEditingController(text: bleu.ram1);
    ramController2 = TextEditingController(text: bleu.ram2);
    ramController3 = TextEditingController(text: bleu.ram3);
    ramController4 = TextEditingController(text: bleu.ram4);
    medController = TextEditingController(text: bleu.med);
    comController = TextEditingController(text: bleu.com);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              update(bleu);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      const ListPage(title: "Bleu Manager 2022")));
            },
          ),
          title: Center(
            child: Text(
              "${bleu.lastname} ${bleu.firstname}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: details(bleu));
  }

  Widget details(Bleu bleu) => Center(
      child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Container(
                padding: const EdgeInsets.only(
                  top: 0.05,
                  right: 5,
                  left: 5,
                  bottom: 20,
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      buildgenre(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildbd(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildnum(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildadresse(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildresplegal(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildnumresp(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildMedical(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildcom(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildram1(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildram2(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildram3(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                      buildram4(bleu),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ))));

  Widget buildbd(Bleu bleu) => Container(
          child: Column(children: [
        Row(children: const [
          Icon(Icons.date_range),
          SizedBox(
            width: 10,
          ),
          Text(
            "Date de naissance : ",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ]),
        SizedBox(
          height: 6,
        ),
        Text(
          bleu.bd,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w200, fontSize: 24),
        ),
      ]));

  Widget buildgenre(Bleu bleu) => Container(
        child: Column(
          children: [
            Row(children: const [
              Icon(Icons.safety_divider_outlined),
              SizedBox(
                width: 5,
              ),
              Text(
                "Gender : ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              ),
            ]),
            SizedBox(
              height: 6,
            ),
            Text(
              bleu.sexe,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: 24),
            ),
          ],
        ),
      );

  Widget buildadresse(Bleu bleu) => Container(
          child: Column(
        children: [
          Row(children: const [
            Icon(Icons.house),
            SizedBox(
              width: 10,
            ),
            Text(
              "Adresse : ",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
          ]),
          SizedBox(
            height: 6,
          ),
          Text(
            bleu.loc,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 24),
          ),
        ],
      ));

  Widget buildresplegal(Bleu bleu) => Container(
          child: Column(
        children: [
          Row(children: const [
            Icon(Icons.accessibility_sharp),
            SizedBox(
              width: 10,
            ),
            Text(
              "Responsable légale : ",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
          ]),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            bleu.resp,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 24),
          ),
        ],
      ));

  Widget buildnumresp(Bleu bleu) => Container(
          child: Column(
        children: [
          Row(children: const [
            Icon(Icons.phone),
            SizedBox(
              width: 10,
            ),
            Text(
              "Tel du responsable légale : ",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
          ]),
          SizedBox(
            height: 6,
          ),
          Text(
            bleu.telresp,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 24),
          ),
        ],
      ));

  Widget buildnum(Bleu bleu) => Column(
        children: [
          Row(children: const [
            Icon(Icons.phone),
            Text(
              "Numéro de téléphone : ",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
          ]),
          SizedBox(
            height: 6,
          ),
          Text(
            bleu.tel,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 24),
          ),
        ],
      );

  Widget buildMedical(Bleu bleu) => TextFormField(
        controller: medController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white70,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.black, width: 2.0)),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white70,
          labelText: 'Floquettes',
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.medical_services),
        ),
        keyboardType: TextInputType.multiline,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: 5,
      );

  Widget buildcom(Bleu bleu) => TextFormField(
        initialValue: bleu.com,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white70,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.black, width: 2.0)),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white70,
          labelText: 'Commentaires',
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.comment),
        ),
        keyboardType: TextInputType.multiline,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: 5,
      );

  Widget buildram1(Bleu bleu) => TextFormField(
        initialValue: bleu.ram1,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white70,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.black, width: 2.0)),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white70,
          labelText: 'Ramassage 1',
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.euro),
        ),
        keyboardType: TextInputType.multiline,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: 5,
      );

  Widget buildram2(Bleu bleu) => TextFormField(
        initialValue: bleu.ram2,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white70,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white70,
          labelText: 'Ramassage 2',
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.euro),
        ),
        keyboardType: TextInputType.multiline,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: 5,
      );

  Widget buildram3(Bleu bleu) => TextFormField(
        initialValue: bleu.ram3,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white70,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.black, width: 2.0)),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white70,
          labelText: 'Ramassage 3',
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.euro),
        ),
        keyboardType: TextInputType.multiline,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: 5,
      );

  Widget buildram4(Bleu bleu) => TextFormField(
        initialValue: bleu.ram4,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white70,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.black, width: 2.0)),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white70,
          labelText: 'Ramassage 4',
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(Icons.euro),
        ),
        keyboardType: TextInputType.multiline,
        // suggests emails when keyboard is opened if any saved
        textInputAction: TextInputAction.done,
        maxLines: null,
        minLines: 5,
      );

  void update(Bleu bleu) {
    if (ramController1.value.text != bleu.ram1) {
      bleu.ram1 = ramController1.value.text;
    } else if (ramController2.value.text != bleu.ram2) {
      bleu.ram2 = ramController2.value.text;
    } else if (ramController3.value.text != bleu.ram3) {
      bleu.ram3 = ramController3.value.text;
    } else if (medController.value.text != bleu.med) {
      bleu.med = medController.value.text;
    } else if (ramController4.value.text != bleu.ram4) {
      bleu.ram4 = ramController4.value.text;
    } else if (comController.value.text != bleu.com) {
      bleu.com = comController.value.text;
    }
  }
}
