// import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_chat/models/chat_message.dart';
// import 'package:flutter_chat/modules/chat_detail_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../models/message.model.dart';

// Widget ChatBubble(int index,DocumentSnapshot? document){
//   // int index;
//   // DocumentSnapshot? documentSnapshot;
//   // ChatBubble({required this.index,required this.documentSnapshot});
//   Message message = Message.fromDocument(document!);
//   return Container(
//       padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
//       child: Align(
//         alignment:Alignment.topRight,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color:Colors.grey.shade200),
          
//           padding: EdgeInsets.all(16),
//           child: Text(widget.documentSnapshot.toString()+"abc"),
//         ),
//       ),
//     );
// }

// // class _ChatBubbleState extends State<ChatBubble> {
// //   @override
// //   Widget build(BuildContext context) {
    
// //     return Container(
// //       padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
// //       child: Align(
// //         alignment:Alignment.topRight,
// //         child: Container(
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(30),
// //             color:Colors.grey.shade200),
          
// //           padding: EdgeInsets.all(16),
// //           child: Text(widget.documentSnapshot.toString()+"abc"),
// //         ),
// //       ),
// //     );
// //   }
// // }

// //  (widget.chatMessage.type == MessageType.Receiver?Alignment.topLeft:
// //  (widget.chatMessage.type  == MessageType.Receiver?Colors.white: