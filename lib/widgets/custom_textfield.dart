import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatefulWidget{
  final String? hint, value;
  final Widget? prefixIcon, suffixIcon, label;
  final bool isPassword, readOnly, numericKeyBoard;
  final bool disableBorder;
  final void Function()? onTap;
  final ValueChanged<String>? onchanged;
  final int? maxLines, maxLenght;

  const CustomTextfield({
    required this.hint, this.value, this.prefixIcon, 
    this.suffixIcon, this.isPassword = false, 
    this.readOnly = false, this.label, this.onTap, 
    this.numericKeyBoard = false, this.maxLines = 1,
    this.disableBorder = false, super.key,
    this.onchanged, this.maxLenght
  });
  
  @override
  State<StatefulWidget> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield>{
  bool _hideIcon = false, _showPassword = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  _CustomTextfieldState();
  
  @override
  void initState() {
    super.initState();
    _controller.text = widget.value??'';

    _focusNode.addListener((){
      setState(() {
        _hideIcon = !_hideIcon;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomTextfield oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(widget.value != oldWidget.value){
      _controller.text = widget.value??'';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
      child: TextField(
        focusNode: _focusNode,
        decoration: InputDecoration(
          label: widget.label,
          hintText: widget.hint,
          border: widget.disableBorder ? InputBorder.none : const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          prefixIcon: _hideIcon ? null : widget.prefixIcon, 
          suffixIcon: widget.isPassword ? IconButton(
            onPressed: (){
              setState(() {
                _showPassword = !_showPassword;
              });
            }, 
            icon: _showPassword ? const Icon(Icons.visibility) : 
                  const Icon(Icons.visibility_off),
          ) : widget.suffixIcon,
        ),
        obscureText: !_showPassword && widget.isPassword,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        controller: _controller,
        inputFormatters: widget.numericKeyBoard ?
                         [FilteringTextInputFormatter.digitsOnly] : null,
        keyboardType: widget.numericKeyBoard ? 
                      TextInputType.number : TextInputType.text,  
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        onChanged: widget.onchanged,
        maxLength: widget.maxLenght,
      ),
    );
  }  
}