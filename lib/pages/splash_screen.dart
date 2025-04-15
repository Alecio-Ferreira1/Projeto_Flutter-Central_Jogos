import 'dart:async';

import 'package:central_jogos/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 2), (){
      if(mounted){
        if(FirebaseAuth.instance.currentUser == null){
          Navigator.pushReplacementNamed(context, "/login");
        }

        else{
          Navigator.pushReplacementNamed(context, "/explore");
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppTitle()
      ),
    );
  }
}
