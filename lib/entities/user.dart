class AppUser{
  String name, email, recoveryEmail, gender;
  String phoneNumber;
  String? nick, cpf, desc;
  int? age;
  Set<String>? subscriptionsId;
  Set<String>? competitionsId;
  String? imgPath;

  AppUser({
    required this.name, required this.email, this.age,
    required this.gender, required this.recoveryEmail, 
    this.nick, this.cpf, this.imgPath, this.subscriptionsId,
    this.competitionsId, required this.phoneNumber, this.desc
  });

  Map<String, dynamic> toMap(){
    return {
      "name" : name, 
      "email" : email, 
      "recoveryEmail" : recoveryEmail,
      "gender" : gender, 
      "phone" : phoneNumber,
      "nick" : nick,
      "cpf" : cpf,
      "age" : age,
      "subscriptionsId" : subscriptionsId,
      "competitionsId" : competitionsId,
      "imgPath" : imgPath,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map){
    return AppUser(
      name: map['name'], 
      email: map['email'], 
      gender: map['gender'], 
      recoveryEmail: map['recoveryEmail'], 
      phoneNumber: map['phoneNumber'],
      nick: map['nick'],
      cpf: map['cpf'],
      desc: map['desc'],
      age: map['age'],
      subscriptionsId: List<String>.from(map['subscriptionsId'] ?? []).toSet(),
      competitionsId: List<String>.from(map['competitionsId'] ?? []).toSet(),
      imgPath: map['imgPath'],
    );
  }
} 