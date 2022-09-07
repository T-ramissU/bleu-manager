import 'package:flutter/material.dart';
import 'package:bleumanager/object/bleu.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});

  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: TableView(),
      ),
    );
  }
}

class TableView extends StatefulWidget {
  const TableView({Key? key}) : super(key: key);

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  // Sortable table that contains data of [_BleuDataSource]
  // Contain three column Matricule, First Name, Last Name
  // which respectively represent the attributes of a [Bleu] object
  int _rowIndex = 0;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  final BleuDataSource _bleuDataSource =  BleuDataSource();

  void _sort<T>(
      Comparable<T> Function(Bleu b) getField,
      int columnIndex,
      bool ascending,
      ) {
    _bleuDataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        primary: true, // To make the scrollview work on desktop
        restorationId: 'data_table_list_view',
        padding: const EdgeInsets.all(16),
        children: [
          PaginatedDataTable(
            showCheckboxColumn: false,
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value!;
              });
            },
            initialFirstRowIndex: _rowIndex,
            onPageChanged: (rowIndex) {
              setState(() {
                _rowIndex = rowIndex;
              });
            },
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: [
              DataColumn(
                label: const Text("Matricule"),
                numeric: true,
                onSort: (columnIndex, ascending) =>
                    _sort<num>((b) => b.matricule, columnIndex, ascending),
              ),
              DataColumn(
                label: const Text("First Name"),
                onSort: (columnIndex, ascending) =>
                    _sort<String>((b) => b.firstname, columnIndex, ascending),
              ),
              DataColumn(
                label: const Text("Last Name"),
                onSort: (columnIndex, ascending) =>
                    _sort<String>((b) => b.lastname, columnIndex, ascending),
              ),
            ],
            source: _bleuDataSource,
          ),
        ],
      ),
    );
  }
}
