import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget{
  final FocusNode _focusNode;
  final Color? textColor;
  final bool notVisibleIfEmpty;

  const Searchbar(this._focusNode, {
    this.textColor, this.notVisibleIfEmpty = false, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "| Buscar...",
        hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
      ),
      style: TextStyle(
        fontSize: 20,
        color: textColor??Colors.white,
        decoration: TextDecoration.none,
      ),
      focusNode: _focusNode,
    );
  }
}