import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_chat/models/room.models.dart';

class Rooms {

  CollectionReference room = FirebaseFirestore.instance.collection("room");
  // DatabaseReference ref = FirebaseDatabase.instance.ref("room");
  // var rooms = FirebaseFirestore.instance.collection("room").withConverter<Room>(
  //     fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
  //     toFirestore: (room, _) => room.toJson());

  // getRoom(String idUser) async {
  //   List<QueryDocumentSnapshot<Room>> room = await rooms
  //       .orderBy("idMember")
  //       .startAt([idUser])
  //       .get()
  //       .then((snapshot) => snapshot.docs);
  //   return room;
  // }

  addRoom(
      {required String idRoot,required String idMember, String? typeRoom,String? nameGroup,String? nameMember,String? avatarMember}) async {
    var idRoom;
    // ignore: prefer_conditional_assignment
    if (typeRoom == null) {
      typeRoom = "private";
      
    }
    if(typeRoom == "private"){
      nameGroup = "";
    }
    // ignore: prefer_conditional_assignment
    if(avatarMember == null) {
      avatarMember = "https://res.cloudinary.com/phankieuphuicloud/image/upload/v1650900941/img_shdh1l.png";
    }
    List memner = [idRoot,idMember];
    await FirebaseFirestore.instance.collection("room").where("idMember",isEqualTo:memner ).get().then((QuerySnapshot querySnapshot){
        querySnapshot.docs.forEach((doc) {
          idRoom = doc.id;      
        });
    }).catchError((Object error) {print("id"+error.toString());});
   if(idRoom != null){
     return  idRoom;
   }
    await room.add({
      "idMember":memner,
      "typeRoom":typeRoom,
      "fristMessage":"",
      "nameGroup":nameGroup,
      "nameMember":nameMember,
      "avatarMember":avatarMember


    }).then((value) =>{
      idRoom = value.id
    });
   return idRoom;
  }

  getNameAndAvatarWithId(String idMember) {}
  deleteRoom() {}
}
