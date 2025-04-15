import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:central_jogos/database/db_crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:central_jogos/widgets/confirm_message_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:central_jogos/colors/colors.dart';
import 'package:central_jogos/pages/explore.dart';
import 'package:central_jogos/widgets/bottom_navigation_bar.dart';
import 'package:central_jogos/widgets/custom_textfield.dart';
import 'package:central_jogos/widgets/main_button.dart';
import 'package:central_jogos/widgets/title_appbar.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{
  User? user = FirebaseAuth.instance.currentUser;
  String? email;
  String? _userName, _userDesc, _newUserName, _newdesc;
  int _page = 0;
  File? _image;
  bool _isPickingImage = false;

  @override
  void initState() {
    super.initState();
    _loadUserdata();
  }

  Future<void> _loadUserdata() async {
    if(user != null){
      if(mounted){
        setState(() {
          email = user?.email;
        });
      }

      DocumentSnapshot? userData = await DBCrud(
        collectionPath: 'users', 
        context: context
      ).read(email!.replaceAll('.', '_'));

      if(userData == null) return;

      Map<String, dynamic>? data = userData.data() as Map<String, dynamic>?;

      if(data == null) return;
  
      bool fileExists = await File(data['imgPath']??'').exists();

      if(mounted){
        setState(() {
          _userName = user?.displayName;

          if(userData.exists){
            _userDesc = data['desc'] ?? 'Adicione uma descrição aqui.';

            _image = data['imgPath'] != null &&  fileExists?
              File(data['imgPath']) : null;
          }   
        });
      }
    }
  }

  Future<void> _pickImage() async{
    if(_isPickingImage) return;
    _isPickingImage = true;

    try{
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if(image != null){
        setState(() {
          _image = File(image.path);
        });
      }
    }
    
    finally{
      _isPickingImage = false;
    }
  }

  Future<bool> singnOut() async {
    try{
      await FirebaseAuth.instance.signOut();
      return true;
    }

    catch(e){
      if(mounted){
        confirmMessageDialog(
          context, 
          "Ocorreu um erro ao deslogar: $e",
          okClose: true,
        );
      }

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppbar(
        "Perfil",
        actions: [
          IconButton(
            onPressed: () async{
              bool? res = await confirmMessageDialog(
                context, 
                "Deseja mesmo sair?"
              );

              if(res == true && context.mounted){
                bool sinedOut = await singnOut();

                if(sinedOut && context.mounted){
                  Navigator.popUntil(context, ModalRoute.withName("/explore"));
                  Navigator.pushReplacementNamed(context, "/login");
                }
              }
            },
            icon: const Icon(Icons.exit_to_app_sharp),
          ),
          const SizedBox(width: 20,),
        ],
        callbackfunc: () {
          if(_page == 0){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Explore())
            );
          }
          setState(() {
            _page = 0;
          });
        },
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image != null ? 
                      ClipOval(
                        child: Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ) : Image.asset(
                          "assets/icons/generic_avatar.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                    Visibility(
                      visible: _page == 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: IconButton(
                          onPressed: _pickImage, 
                          icon: Image.asset(
                            "assets/icons/placeholder.png",
                            width: 40,
                            height: 38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  _userName??'Usuário', 
                  style: TextStyle(
                    color: AppColors.black, 
                    fontSize: 24, 
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Visibility(
                  visible: _page == 1,
                  child:  CustomTextfield(
                    hint: "Mudar Nome de usuário", 
                    prefixIcon: Icon(Icons.person),
                    onchanged: (value) {
                      setState(() {
                        _newUserName = value;
                      });
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0, left: 25.0),
                      child: Text(
                        "Sua descrição: ", 
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    SingleChildScrollView(
                      child: CustomTextfield(
                        hint:'' , 
                        value: _userDesc,
                        maxLines: null,
                        disableBorder: _page == 0,
                        readOnly: _page == 0,
                        onchanged: (value) {
                          setState(() {
                            _newdesc = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: _page == 0,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                      maxWidth: 154,
                    ),
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          _page = 1;
                        });
                      }, 
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(color: AppColors.blue),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.edit, color: AppColors.blue,),
                          Text(
                            "Editar Perfil", 
                            style: TextStyle(color: AppColors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _page == 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    child: MainButton(
                      text: "Salvar alterações", 
                      backgColor: AppColors.blue,
                      rightArrow: false,
                      callBackFunc: () async{
                        bool? res = await confirmMessageDialog(
                          context, "Salvar alterações?"
                        );

                        if(res == true){
                          bool newDescIsBlank = _newdesc == null ||
                             _newdesc!.trim().isEmpty;

                          bool newUserNameIsBlank = _newUserName == null || 
                               _newUserName!.trim().isEmpty;
                    
                          if(context.mounted){
                            bool opSucess = await DBCrud(
                              collectionPath: 'users', 
                              context: context
                            ).update(email!.replaceAll('.', '_'), {
                              'name' : newUserNameIsBlank ? _userName : _newUserName,
                              'desc' : newDescIsBlank ? _userDesc : _newdesc,
                              'imgPath' : _image?.path,
                            });

                            if(opSucess){
                              if(!newUserNameIsBlank){
                                await user?.updateDisplayName(_newUserName);
                                await user?.reload();
                              }

                              setState(() {
                                if(!newUserNameIsBlank){
                                  _userName = _newUserName;
                                }

                                if(!newDescIsBlank){
                                  _userDesc = _newdesc;
                                }
                              });
                            }
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}