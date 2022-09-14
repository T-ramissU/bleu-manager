import 'dart:async';
import 'package:flutter/material.dart';

import 'package:bleumanager/object/bleu.dart';
import 'package:bleumanager/util/show_message.dart';
import 'package:bleumanager/util/credential.dart';

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

  /// Used to retrigger build and contains the result code of the fetch
  final StreamController<int> fetchController = StreamController();

  /// TextField controller for the prenom's filter
  final TextEditingController prenomController = TextEditingController();

  /// Give an access to all bleu
  final BleuDataSource bleuDataSource = BleuDataSource();

  /// Fetch all bleu from the server
  Future<void> fetch() async {
    int res = await bleuDataSource.fetch();
    fetchController.add(res); // trigger build
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  void dispose() {
    prenomController.dispose();
    super.dispose();
  }

  /// Sort table depending on the [columnIndex], using the value returned by [getField],
  /// in a [ascending] order or not. (Refresh the page)
  void sort<T>(Comparable<T> Function(Bleu b) getField, int columnIndex,
      bool ascending) {
    bleuDataSource.sort<T>(getField, ascending);
    setState(() {
      selectedColumn = columnIndex;
      sortAscending = ascending;
    });
  }

  /// Return rows to display depending on [showDeleted], [prenomFilter] and [regioFilter]
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

  Widget _buildTable(BuildContext context) {
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: () => fetch(),
        child: ListView(
          scrollDirection: Axis.vertical,
          // To fix "Vertical viewport was given unbounded height" error
          shrinkWrap: true,
          // To fix "Vertical viewport was given unbounded height" error
          primary: true,
          // To make the scrollview work on desktop
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
                  onSort: (columnIndex, ascending) =>
                      sort<String>((b) => b.lastname, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text("Prénom"),
                  onSort: (columnIndex, ascending) =>
                      sort<String>((b) => b.firstname, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text("Regio"),
                  onSort: (columnIndex, ascending) =>
                      sort<String>((b) => b.regio, columnIndex, ascending),
                ),
              ],
              rows: getRowsToDipslay(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilter(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.search),
        title: Row(
          children: [
            Flexible(
              child: TextField(
                controller: prenomController,
                decoration: const InputDecoration(
                  hintText: 'Rechercher ...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    prenomFilter = value.isEmpty ? null : value;
                  });
                },
              ),
            ),
            DropdownButton<String>(
              value: regioFilter,
              hint: const Text("Region"),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  regioFilter = value;
                });
              },
              items: bleuAllRegio.map<DropdownMenuItem<String>>((String regio) {
                return DropdownMenuItem<String>(
                  value: regio,
                  child: Text(regio),
                );
              }).toList(),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              prenomController.clear();
              prenomFilter = null;
              regioFilter = null;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          // will be re-trigger when fetchRes will contains a value
          stream: fetchController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == 0) {
              // successful fetch, return table
              return Column(
                children: [
                  _buildFilter(context),
                  _buildTable(context),
                ],
              );
            } else if (snapshot.hasData) {
              // error during fetch
              // wait until build is finished to show message
              WidgetsBinding.instance.addPostFrameCallback((_) {
                switch (snapshot.data) {
                  case 1: // unauthorized access
                    showMessage(context,
                        "Accès non autorisé. Vous avez été déconnecté.");
                    Credential().delete();
                    Navigator.pushReplacementNamed(
                        context, "/login"); // redirect to LoginPage
                    break;
                  case 3: // server error
                    showMessage(context,
                        "Une erreur est survenue lors de la communication avec le serveur.");
                    break;
                }
              });
              return const Text(""); // return invisible widget
            }
            // fetch not yet terminated, return progress indicator
            return const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          }),
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
