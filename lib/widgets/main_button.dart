import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Color backgColor;
  final bool leftArrow, rightArrow, buttonCanBeSmaller;
  final void Function()? callBackFunc;
  final double fontSize, height;

  const MainButton({
    required this.text, required this.backgColor, this.callBackFunc,
    this.leftArrow = false, this.rightArrow = true, 
    this.fontSize = 16, this.buttonCanBeSmaller = false, 
    this.height = 58, super.key
  });

  Widget _buildArrow(bool visible, Icon icon){
    return SizedBox(
      height: 40,
      width: 40,
      child: Visibility(
        visible: visible,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF3D56F0),
          ),
          child: icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: height,
        maxHeight: height,
        minWidth: buttonCanBeSmaller ? 0 : 291
      ),
      child: ElevatedButton(
       onPressed: (){
        callBackFunc?.call(); 
       },               
        style: ElevatedButton.styleFrom(
          backgroundColor: WidgetStateColor.resolveWith(
            (states) {
              return backgColor;
            },
          ),
          foregroundColor: const Color(0XFFFFFFFF),
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonCanBeSmaller ? Container() : 
              _buildArrow(leftArrow, const Icon(Icons.arrow_back, color: Color(0xFFFFFFFF))),
            Text((text.toUpperCase()), style: TextStyle(fontSize: fontSize),),
            buttonCanBeSmaller ? Container() : 
              _buildArrow(rightArrow, const Icon(Icons.arrow_forward, color: Color(0xFFFFFFFF))),
          ],
        ),
      ),
    );
  }
}