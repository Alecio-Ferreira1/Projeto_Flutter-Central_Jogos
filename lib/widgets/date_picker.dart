import 'package:central_jogos/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final Widget? label;
  final String? startValue;
  final ValueChanged<DateTime>? onChanged;
  final bool useStartValue;

  const DatePickerField({ 
    required this.label, this.startValue, super.key,
    this.onChanged, this.useStartValue = false,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
  }

  void _showDatePicker() async{
    DateTime now = DateTime(
      DateTime.now().year, 
      DateTime.now().month,
      DateTime.now().day
    );

    DateTime? pickedDate = await showDatePicker(
      context: context, initialDate: now, firstDate: now, 
      lastDate: DateTime(now.year + 20), fieldLabelText: "Insira a data",
    );

    if(pickedDate != null){
      setState(() {
        _selectedDate = pickedDate;
      });

      widget.onChanged?.call(pickedDate);
    } 
  }

  String updateValue(){
    if(widget.useStartValue && widget.startValue != null){
      return widget.startValue!;
    } 

    if(_selectedDate != null && !widget.useStartValue) {
      return "${_selectedDate!.day}/${_selectedDate!.month}"
           "/${_selectedDate!.year}"; 
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      value: updateValue(),
      hint: "dd/mm/aaaa",
      readOnly: true,
      label: widget.label,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0x77AAAAAA),
          ),
          child: const Icon(Icons.calendar_month_outlined),
        ),
      ),
      onTap: _showDatePicker,
    );
  }
}