import 'package:flutter/material.dart';

class ListActions extends StatelessWidget {
  final List<Widget> _children = List<Widget>.empty(growable: true);

  ListActions({Key? key, delete, edit}) : super(key: key) {
    if (null != delete) {
      _children.add(
        IconButton(onPressed: delete, icon: const Icon(Icons.delete))
      );
    }

    if (null != edit) {
      _children.add(
        IconButton(onPressed: edit, icon: const Icon(Icons.edit))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _children
    );
  }
}