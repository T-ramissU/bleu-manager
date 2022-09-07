import 'package:flutter/material.dart';

class Bleu {
  Bleu(
      this.matricule,
      this.lastname,
      this.firstname,
      );

  final int matricule;
  final String lastname;
  final String firstname;
}

class BleuDataSource extends DataTableSource {
  // Model which represents all [Bleu] objects
  // The class extends [DataTableSource] in order automatically be used as
  // source in a [PaginatedDataTable]
  late List<Bleu> _bleu;

  BleuDataSource() {
    // TODO fetch data from the server
    _bleu = <Bleu>[
      Bleu(1, "a", "m"
      ),
      Bleu(2, "x", "a"
      ),
      Bleu(3, "b", "a"
      ),
    ];
  }

  void sort<T>(Comparable<T> Function(Bleu b) getField, bool ascending) {
    _bleu.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _bleu.length) return null;
    final bleu = _bleu[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${bleu.matricule}')),
        DataCell(Text(bleu.firstname)),
        DataCell(Text(bleu.lastname)),
      ],
    );
  }

  @override
  int get rowCount => _bleu.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;  // checkbox feature is disabled
}