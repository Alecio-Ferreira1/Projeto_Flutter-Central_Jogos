import 'package:flutter/material.dart';

class TitleAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String? title;
  final void Function()? callbackfunc;
  final List<Widget>? actions;
  const TitleAppbar(this.title, {this.callbackfunc, this.actions, super.key});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      title: Text(title??'', style: const TextStyle(fontSize: 24)),
      titleSpacing: 0,
      leading: IconButton(
        onPressed: callbackfunc??(){
          if(Navigator.of(context).canPop()) Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),        
      backgroundColor: Colors.white,
      actions: actions,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}