import 'dart:ffi';

import 'package:bookend/model/book.dart';
import 'package:bookend/model/library.dart';
import 'package:bookend/overlay/library_input.dart';
import 'package:bookend/widget/list_actions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Bookend'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Library> _libraries = List<Library>.from([
    Library(name: 'test'),
    Library(name: 'other', books: List<Book>.from([
      Book(title: 'Book1', authorName: 'Test Author'),
      Book(title: 'Book2', authorName: 'Test Author'),
      Book(title: 'Book3', authorName: 'Test Author 2'),
    ]))
  ]);
  String _lastAction = 'none';
  bool _showLibraryInput = false;
  Widget _libraryInput = LibraryInput(
    handleLibraryAction: (Library library) => {},
    cancelLibraryAction: () => {},
  );

  addLibraryAction(Library library) => setState(() {
    _libraries.add(library);
    _showLibraryInput = false;
  });

  editLibraryAction(Library library, String name) => setState(() {
    library.name = name;
    _showLibraryInput = false;
  });

  cancelLibraryAction() => setState(() {_showLibraryInput = false;});

  buildAddLibraryHandle() => () => {
    setState(() {
      _libraryInput = LibraryInput(
        handleLibraryAction: addLibraryAction,
        cancelLibraryAction: cancelLibraryAction,
      );
      _showLibraryInput = true;
    })
  };

  buildEditLibraryHandle(Library library) => () => {
    setState(() {
      _libraryInput = LibraryInput(
        handleLibraryAction: (Library newValue) => editLibraryAction(library, newValue.name),
        cancelLibraryAction: cancelLibraryAction,
        name: library.name,
      );
      _showLibraryInput = true;
    })
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        leading: PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'test',
              child: Text('test text'),
            )
          ]
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Column(
              children: [
                const Center(child: Text('List of Libraries')),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _libraries.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text(_libraries[index].name),
                    trailing: ListActions(
                      delete: () => setState(() { _libraries.removeAt(index); _lastAction = 'delete'; }),
                      edit: buildEditLibraryHandle(_libraries[index]),
                    ),
                  ),
                ),
                Text(_lastAction),
              ],
            ),
          ),
          if (_showLibraryInput) _libraryInput,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: buildAddLibraryHandle(),
        child: const Icon(Icons.add),
      )
    );
  }
}
