import 'package:flutter/material.dart';
import 'dart:async';

class ClickableText extends StatefulWidget{
  final String? content; 
  final Color activeColor, color;
  final void Function()? callbackfunc;
  final double fontSize;

  const ClickableText({
    required this.activeColor, required this.content,
    required this.color, this.callbackfunc, this.fontSize = 16, super.key
  });

  @override
  State<StatefulWidget> createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText>{
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(mounted){
          setState(() {
            _isActive = true;
          });

          Timer(const Duration(milliseconds: 300), (){
            if(mounted){
              setState(() {
                _isActive = false;
              });
            }
          });

          widget.callbackfunc?.call();
        }
      },
      child: Text(
        widget.content??'', 
        style: TextStyle(
          fontSize: widget.fontSize,
          color: _isActive ? widget.activeColor : widget.color
        ),
      ),
    );
  }
}