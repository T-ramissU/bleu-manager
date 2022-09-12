import 'package:flutter/material.dart';
import 'package:bleumanager/object/bleu.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.title});

  final String title;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool sortAscending = true;
  bool showDeleted = false;
  bool fetching = true;
  int? sortColumnIndex;
  final BleuDataSource bleuDataSource = BleuDataSource();

  void sort<T>(
    Comparable<T> Function(Bleu b) getField,
    int columnIndex,
    bool ascending,
  ) {
    bleuDataSource.sort<T>(getField, ascending);
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  @override
  void initState() {
    super.initState();
    bleuDataSource.fetch().then((value) {
      setState(() {
        fetching = false;
      });
    });
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
                  sortColumnIndex: sortColumnIndex,
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
                      onSort: (columnIndex, ascending) =>
                          sort<String>((b) => b.regio, columnIndex, ascending),
                    ),
                  ],
                  rows: bleuDataSource.getData(context, showDeleted),
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
              onPressed: () => setState(() => showDeleted = !showDeleted),
              icon: showDeleted
                  ? const Icon(Icons.person)
                  : const Icon(Icons.person_remove))
        ],
      ),
    );
  }
}
