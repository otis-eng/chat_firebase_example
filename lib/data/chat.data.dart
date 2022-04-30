import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class Chats {
CollectionReference message = FirebaseFirestore.instance.collection('message');
CollectionReference room = FirebaseFirestore.instance.collection('room');
  // DatabaseReference ref = FirebaseDatabase.instance.ref("message");
  // var messages = FirebaseFirestore.instance
  //     .collection("message")
  //     .withConverter<Message>(
  //         fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
  //         toFirestore: (message, _) => message.toJson());

          
  getChatWithRoom(String idRoom) {
    final Stream<QuerySnapshot> _roomStream =
        FirebaseFirestore.instance.collection('room').snapshots();
      CollectionReference room = FirebaseFirestore.instance.collection('room');
      
  }

  sendChatMessage(
      {required String idRoom,
      required String author,
      required String content,
      String? nameFile,
      String? typeMessage}) {
    // ignore: prefer_conditional_assignment
    if (typeMessage == null) {
      typeMessage = "text";
    }
    DateTime timeNow = DateTime.now();
    var fortmatTimestamp =new DateFormat('HH:mm:ss dd-MM-yyyy');
    var formatDate = fortmatTimestamp.format(timeNow);
    // print(formatDate);
    // print(idRoom);
    return message
        .add( 
{            "idRoom": idRoom,
            "author": author,
            "typeMessage": typeMessage,
            "content": content,
            "timestamp":formatDate,
            "nameFile":nameFile
            })
        .then((value) => {
          room.doc(idRoom).update({
            "fristMessage":content
          })
        });
  }

  evictionMessage() {}
}
