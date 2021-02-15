import 'dart:io';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Tiro de gracia', votes: 1),
    Band(id: '2', name: 'Godwana', votes: 2),
    Band(id: '3', name: 'Chancho en piedra', votes: 3),
    Band(id: '4', name: 'Los tres', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    var listView = ListView;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Band Names",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _buildListTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: () {
          addNewBand();
        },
      ),
    );
  }

  Widget _buildListTile(Band bands) {
    return Dismissible(
      key: Key(bands.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        // TODO llamar el borrado en el server
        print('direction: $direction');
        print('id: ${bands.id}');
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete band ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(bands.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(bands.name),
        trailing: Text(
          '${bands.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(bands.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();
    if (Platform.isAndroid) {
      // Valida el sistema operativo
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              // cuadro de dialogo en Android
              title: Text('New band name:'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () {
                    addBandToList(textController.text);
                  },
                )
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('New band name:'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction:
                    true, // Dispara la accion del Enter cuando se ingresa un valor
                child: Text('Add'),
                onPressed: () {
                  addBandToList(textController.text);
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction:
                    true, // Dispara la accion del Enter cuando se ingresa un valor
                child: Text('Dismiss'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void addBandToList(String name) {
    print(name);

    if (name.length > 2) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
    }

    setState(() {});
    Navigator.pop(context);
  }
}
