import 'package:central_jogos/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class TimePickerField extends StatefulWidget {
  final Widget? label;
  final String? startValue;
  final ValueChanged<TimeOfDay>? onchanged;
  final bool useStartValue;

  const TimePickerField({
    required this.label, this.startValue, super.key, this.onchanged,
    this.useStartValue = false,
  });

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  TimeOfDay? _selectedTime;

  void _showTimePicker() async{
    TimeOfDay now = TimeOfDay( 
      hour: TimeOfDay.now().hour,
      minute: TimeOfDay.now().minute
    );

    TimeOfDay? pickedTime = await showTimePicker(
      context: context, initialTime: now,
    );

    if(pickedTime != null){
      setState(() {
        _selectedTime = pickedTime;
      });

      widget.onchanged?.call(pickedTime);
    }
  }

  String updateValue(){
    if(widget.useStartValue && widget.startValue != null){
      return widget.startValue!;
    }

    if(_selectedTime != null && !widget.useStartValue){
      String concatZeroIfNecessary(int parameter){
        if(parameter < 10) return "0$parameter";
        return "$parameter";
      }

      String hour = concatZeroIfNecessary(_selectedTime!.hour);
      String minute = concatZeroIfNecessary(_selectedTime!.minute);

      return "$hour:$minute";
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      value: updateValue(),
      hint: "HH:mm",
      readOnly: true,
      label: widget.label,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0x77AAAAAA),
          ),
          child: const Icon(Icons.watch_later_outlined),
        ),
      ),
      onTap: _showTimePicker,
    );
  }
}