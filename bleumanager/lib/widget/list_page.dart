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

  /// TextField controller for the prenom's filter
  late final TextEditingController prenomController;

  /// Give an access to all bleu
  late final BleuDataSource bleuDataSource;

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
    prenomController = TextEditingController();
    bleuDataSource = BleuDataSource();
    // fetch from the server all bleu and then refresh
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

  @override
  void dispose() {
    prenomController.dispose();
    super.dispose();
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

  Widget _buildProgressIndictor(BuildContext context) {
    if (fetching) {
      return const CircularProgressIndicator(color: Colors.redAccent);
    }
    return const Text(''); // No progress indicator, the widget is invisible
  }

  Widget _buildTable(BuildContext context) {
    return SingleChildScrollView(
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
                    hintText: 'Rechercher un prénom', border: InputBorder.none),
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
      // Stack is used to superpose fetching animation and list view
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          _buildProgressIndictor(context),
          Column(
            children: [
              _buildFilter(context),
              _buildTable(context),
            ],
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
