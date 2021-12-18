import 'package:bookend/model/library.dart';
import 'package:flutter/material.dart';

class LibraryInput extends StatefulWidget {
  final ValueSetter<Library> handleLibraryAction;
  final VoidCallback cancelLibraryAction;
  final String? name;
  const LibraryInput({
    Key? key,
    required this.handleLibraryAction,
    required this.cancelLibraryAction,
    this.name,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LibraryInputState();
}

class _LibraryInputState extends State<LibraryInput> {
  String? _name;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Text('overlay active'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'library name',
                  label: Text('Library name'),
                  icon: Icon(Icons.house_siding),
                ),
                onChanged: (String? value) => setState(() {
                  _name = value;
                }),
                initialValue: widget.name,
                validator: (String ?value) => value != null ? 'Required' : null,
              ),
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: _name != null ? () => widget.handleLibraryAction(Library(name: _name ?? '')) : null,
                    child: const Text('OK'),
                  ),
                  TextButton(
                    onPressed: widget.cancelLibraryAction,
                    child: const Text('Cancel'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
