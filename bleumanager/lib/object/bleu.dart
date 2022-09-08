import 'package:bleumanager/widget/mini_menu.dart';
import 'package:flutter/material.dart';

class Bleu {
  Bleu(this.matricule, this.lastname, this.firstname, this.supp, this.regio,
      this.tel, this.med, this.com);

  final int matricule;
  final String lastname;
  final String firstname;
  final bool supp;
  final String regio;
  final String tel;
  final String com;
  final String med;
}

class BleuDataSource {
  // Model which represents all [Bleu] objects
  // The class extends [DataTableSource] in order automatically be used as
  // source in a [PaginatedDataTable]
  late List<Bleu> _bleu;

  BleuDataSource() {
    // TODO fetch data from the server
    _bleu = <Bleu>[Bleu(45,"TRuc","machin",true,"Fronta","4568566","polente","rien")];
  }

  void sort<T>(Comparable<T> Function(Bleu b) getField, bool ascending) {
    _bleu.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
  }

  List<DataRow> getdata(BuildContext context)  {
    List<DataRow> listbleu = <DataRow>[];

    for (var bleu in _bleu) {
      DataRow truc = DataRow(
        onLongPress:() async { await showDialog(
            context: context, builder: (BuildContext context) => MiniMenu());},
        cells: [
          DataCell(Text('${bleu.matricule}')),
          DataCell(Text(bleu.firstname)),
          DataCell(Text(bleu.lastname)),
        ],
      );
      listbleu.add(truc);
    }
    return listbleu;
  }

}
