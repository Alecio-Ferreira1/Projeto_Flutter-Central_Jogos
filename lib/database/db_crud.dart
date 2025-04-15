import 'package:central_jogos/widgets/confirm_message_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DBCrud {
  static final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final String collectionPath;
  final BuildContext context;

  DBCrud({required this.collectionPath, required this.context});

  Future<bool> create(String id, Map<String, dynamic> data) async {
    try{
      await _firebase.collection(collectionPath).doc(id).set(data); 
      return true;     
    }

    on FirebaseException catch(e){
      showExceptions(e.code);
      return false;
    }
  }

  Future<DocumentSnapshot?> read(String id) async {
    try{
      return await _firebase.collection(collectionPath).doc(id).get();
    }

    on FirebaseException catch(e){
      showExceptions(e.code);
      return null;
    }
  }

  Future<bool> update(String id, Map<String, dynamic> data) async {
    try{
      await _firebase.collection(collectionPath).doc(id).update(data);
      return true;
    }

    on FirebaseException catch(e){
      showExceptions(e.code);
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try{
      await _firebase.collection(collectionPath).doc(id).delete();
      return true;
    }


    on FirebaseException catch(e){
      showExceptions(e.code);
      return false;
    }
  }

  Future<void> showExceptions(String code) async {
    late String errorMessage;

    switch(code){
      case 'permission-denied': 
        errorMessage = "Permissão negada!";
      case 'already-exists':
        errorMessage = "Essa documento já existe.";
      case 'unauthenticated':
        errorMessage = "Usuário não autenticado!";
      case 'unavailable':
        errorMessage = "Serviço indisponível";
      default: 
        errorMessage = "Erro desconhecido. Tente novamente mais tarde.";
    }

    await confirmMessageDialog(
      context, errorMessage, okClose: true,
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>?> getCollection() async {
    try{
      return await _firebase.collection(collectionPath).get();
    }

    on FirebaseException catch(e){
      showExceptions(e.code);
      return null;
    }
  }  

  String getId(){
    return _firebase.collection(collectionPath).doc().id;
  }
}