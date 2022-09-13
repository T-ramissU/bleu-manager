import 'package:flutter/material.dart';
import 'package:bleumanager/object/bleu.dart';

/// Display all bleu and offer to the user the possibility to manage them
class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});

  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  /// Equal to the select column, null if no one is selected
  int? selectedColumn;

  /// If true the [sortColumnIndex] is sorted in ascending otherwise descending
  bool sortAscending = true;

  /// If true the deleted bleu are showed other the reamaining one
  bool showDeleted = false;

  /// If true, the fetching is not yet finished
  bool fetching = true;

  /// Contains the regios to display, null means all
  String? regioFilter;

  /// Contains the prenoms to display, null means all
  String? prenomFilter;

  /// Give an access to all bleu
  final BleuDataSource bleuDataSource = BleuDataSource();

  void sort<T>(
    Comparable<T> Function(Bleu b) getField,
    int columnIndex,
    bool ascending,
  ) {
    bleuDataSource.sort<T>(getField, ascending);
    setState(() {
      selectedColumn = columnIndex;
      sortAscending = ascending;
    });
  }

  @override
  void initState() {
    super.initState();
    // fetch from the server all bleu
    bleuDataSource.fetch().then((res) {
      setState(() {
        fetching = false;
        switch (res) {
          case 1: // unauthorized access TODO SHOW ERROR POPUP
            // redirect to LoginPage
            Navigator.pushReplacementNamed(context, "/login");
            break;
          case 3: // server error TODO SHOW ERROR POPUP
            break;
        }
      });
    });
  }

  List<DataRow> getRowsToDipslay(BuildContext context) {
    List<DataRow> allRows = bleuDataSource.getData(context, showDeleted);
    if (prenomFilter == null && regioFilter == null) return allRows;

    List<DataRow> filteredRows = allRows.where((bleu) {
      bool choosed = true;
      if (regioFilter != null) {
        Text regioColumn = bleu.cells[2].child as Text;
        choosed = regioColumn.data == regioFilter;
      }
      if (choosed && prenomFilter != null) {
        Text prenomColumn = bleu.cells[0].child as Text;
        choosed = prenomColumn.data!.contains(prenomFilter!);
      }
      return choosed;
    }).toList();

    return filteredRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack is used to superpose fetching animation and list view
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          fetching
              ? const CircularProgressIndicator(
                  color: Colors.redAccent,
                )
              : const Text(''),
          Scrollbar(
            child: ListView(
              primary: true, // To make the scrollview work on desktop
              restorationId: 'data_table_list_view',
              padding: const EdgeInsets.all(16),
              children: [
                DataTable(
                  showCheckboxColumn: false,
                  sortColumnIndex: selectedColumn,
                  sortAscending: sortAscending,
                  columns: [
                    DataColumn(
                      label: const Text("Nom"),
                      onSort: (columnIndex, ascending) => sort<String>(
                          (b) => b.lastname, columnIndex, ascending),
                    ),
                    DataColumn(
                      label: const Text("Prénom"),
                      onSort: (columnIndex, ascending) => sort<String>(
                          (b) => b.firstname, columnIndex, ascending),
                    ),
                    DataColumn(
                      label: const Text("Regio"),
                      onSort: (columnIndex, ascending) => sort<String>(
                              (b) => b.regio, columnIndex, ascending),
                    ),
                  ],
                  rows: getRowsToDipslay(context),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
             // allow to switch from list of remaining and deleted bleu
              onPressed: () => setState(() => showDeleted = !showDeleted),
              icon: showDeleted
                  ? const Icon(Icons.person)
                  : const Icon(Icons.person_remove),
          )
        ],
      ),
    );
  }
}
