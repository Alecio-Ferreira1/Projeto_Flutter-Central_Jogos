import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String hint;
  final String? value;
  final Widget? prefixIcon, label;
  final bool useValue;

  const DropDownList({
    required this.items, required this.hint, this.onChanged, 
    this.prefixIcon, this.label, this.value, super.key,
    this.useValue = false,
  });

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  late final List<String> items;
  String? selectedItem;

  @override void initState() {
    items = List.from(widget.items);  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
      child: DropdownButtonFormField<String>(
        items: items.map((String item){
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(), 
        onChanged: 
        (String? selelection){
          if(selelection != null){
            setState(() {
              if(selelection == selectedItem){
                selectedItem = null;
              }

              else{
                selectedItem = selelection;
                items.remove(selelection);
                items.sort();
                items.insert(0, selelection);
              }
            });
          }

          widget.onChanged?.call(selectedItem);
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),          
          prefixIcon: widget.prefixIcon,
          label: widget.label,
        ),
        dropdownColor: const Color(0xFFEDEDED),
        isExpanded: true,
        hint: Text(widget.hint),
        value: widget.useValue ? widget.value : selectedItem,
      ),
    );
  }
}