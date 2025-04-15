import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitPlaceHolder extends StatefulWidget{
  final double dimensions;
  final bool disableHorizontalRule, readOnly;
  final int maxLength;
  final String? startValue;
  final ValueChanged<String>? onChanged;

  const DigitPlaceHolder({
    this.dimensions = 55, super.key, this.readOnly = false,
    this.disableHorizontalRule = false, this.maxLength = 1,
    this.startValue, this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => DigitPlaceHolderState();
}

class DigitPlaceHolderState extends State<DigitPlaceHolder>{
  final FocusNode _focusNode = FocusNode();
  bool _isInFocus = false;
  bool _emptyField = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener((){
      setState(() {
        _isInFocus = _focusNode.hasFocus;
      });
    });

    _controller.text = widget.startValue??'';
  }

  @override void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.maxLength,
      buildCounter:
      (context, {required currentLength, required isFocused, required maxLength}) {
        return null;
      },
      focusNode: _focusNode,
      decoration: InputDecoration(
        prefixIcon: _isInFocus || !_emptyField || widget.disableHorizontalRule ? null 
          : const Center(child: Icon(Icons.horizontal_rule)),
        counter: null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        constraints: BoxConstraints(
          maxWidth: widget.dimensions,
          maxHeight: widget.dimensions,
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onChanged: (value) {
        setState(() {
          _emptyField = value.isEmpty;
        });

        widget.onChanged?.call(value);
      },
      readOnly: widget.readOnly,
      controller: _controller,
    );
  }
}