import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/modules/chat_detail_page.dart';

import '../../models/user.dart';

class ChatBody extends StatefulWidget {
  List<User> user;
  ChatBody(this.user);
  
  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    bool isTrue = true;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String typeRoom = "";
    String nameMember = "";
    String avatarMember = "";
    List<User> user = widget.user;
    return Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 15),
          width: width,
          height: height * (2 / 3),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('room').where("idMember",arrayContainsAny: [user[0].idUser]).snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
    
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader();
                }
                if (snapshot.hasData) {
                  final data = snapshot.data!.docs;
    
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        typeRoom = data[index]["typeRoom"];
                        avatarMember = data[index]["avatarMember"];
                        return InkWell(
                            onTap: () {
                              if (data[index]["typeRoom"] == "private" ||
                                  data[index]["typeRoom"] == "customer") {
                                nameMember = data[index]["nameMember"];
                              }
                              if (data[index]["typeRoom"] == "group") {
                                nameMember = data[index]["nameGroup"];
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatDetailPage(
                                          idUser: user[0].idUser,
                                          nameMember: data[index]["nameMember"],
                                          typeRoom: typeRoom,
                                          avatarMember: data[index]
                                              ["avatarMember"],
                                          idRoom: data[index].id,
                                          idMember: data[index]["idMember"])));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 70,
                                    height: 60,
                                    child: Stack(
                                      children: <Widget>[
                                        typeRoom == "private" ||
                                                typeRoom == "customer"
                                            ? AvatarOff(
                                                data[index]["avatarMember"])
                                            : AvatarOff(
                                                "https://res.cloudinary.com/phankieuphuicloud/image/upload/v1650925713/imgs_ia5sgt.jpg"),
                                        Positioned(
                                          top: 38,
                                          left: 42,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF66BB6A),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Color(0xFFFFFFFF),
                                                    width: 3)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        typeRoom == "private" ||
                                                typeRoom == "customer"
                                            ? data[index]['nameMember']
                                            : data[index]['nameGroup'],
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width -
                                            135,
                                        child: Text(
                                          data[index]['fristMessage'] +
                                              " - " +
                                              data[index]['typeRoom'],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.7)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ));
                      });
                }
                return Center(child: Loader());
              })),
    );
  }

  Widget AvatarOnline(String img) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blueAccent, width: 3)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image:
                  DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
        ),
      ),
    );
  }

  Widget AvatarOff(String img) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
    );
  }

}
        // child: Expanded(
        //     child: ListView.builder(
        //         itemCount: conversationList.length,
        //         itemBuilder: (BuildContext context, int index) {
        //           return InkWell(
        //             child: Padding(
        //               padding: const EdgeInsets.only(bottom: 10),
        //               child: Row(
        //                 children: <Widget>[
        //                   Container(
        //                     width: 60,
        //                     height: 60,
        //                     child: Stack(
        //                       children: <Widget>[
        //                         conversationList[index]['hasStory']
        //                             ? Container(
        //                                 decoration: BoxDecoration(
        //                                     shape: BoxShape.circle,
        //                                     border: Border.all(
        //                                         color: Colors.blueAccent,
        //                                         width: 3)),
        //                                 child: Padding(
        //                                   padding: const EdgeInsets.all(3.0),
        //                                   child: Container(
        //                                     width: 75,
        //                                     height: 75,
        //                                     decoration: BoxDecoration(
        //                                         shape: BoxShape.circle,
        //                                         image: DecorationImage(
        //                                             image: NetworkImage(
        //                                                 conversationList[index]
        //                                                     ['imageUrl']),
        //                                             fit: BoxFit.cover)),
        //                                   ),
        //                                 ),
        //                               )
        //                             : Container(
        //                                 width: 70,
        //                                 height: 70,
        //                                 decoration: BoxDecoration(
        //                                     shape: BoxShape.circle,
        //                                     image: DecorationImage(
        //                                         image: NetworkImage(
        //                                             conversationList[index]
        //                                                 ['imageUrl']),
        //                                         fit: BoxFit.cover)),
        //                               ),
        //                         conversationList[index]['isOnline']
        //                             ? Positioned(
        //                                 top: 38,
        //                                 left: 42,
        //                                 child: Container(
        //                                   width: 20,
        //                                   height: 20,
        //                                   decoration: BoxDecoration(
        //                                       color: Color(0xFF66BB6A),
        //                                       shape: BoxShape.circle,
        //                                       border: Border.all(
        //                                           color: Color(0xFFFFFFFF),
        //                                           width: 3)),
        //                                 ),
        //                               )
        //                             : Container()
        //                       ],
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     width: 20,
        //                   ),
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: <Widget>[
        //                       Text(
        //                         conversationList[index]['name'],
        //                         style: TextStyle(
        //                             fontSize: 17, fontWeight: FontWeight.w500),
        //                       ),
        //                       SizedBox(
        //                         height: 5,
        //                       ),
        //                       SizedBox(
        //                         width: MediaQuery.of(context).size.width - 135,
        //                         child: Text(
        //                           conversationList[index]['message'] +
        //                               " - " +
        //                               conversationList[index]['time'],
        //                           style: TextStyle(
        //                               fontSize: 15,
        //                               color:
        //                                   Color(0xFF000000).withOpacity(0.7)),
        //                           overflow: TextOverflow.ellipsis,
        //                         ),
        //                       )
        //                     ],
        //                   )
        //                 ],
        //               ),
        //             ),
        //           );
        //         })));
  


// Widget bac(){
//   final Stream<QuerySnapshot> _roomStream = FirebaseFirestore.instance.collection('room').snapshots();
//   StreamBuilder<QuerySnapshot>(
//       stream: _roomStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }
//         Map<String, dynamic> data = snapshot.data! as Map<String, dynamic>;
//         return ListView.builder(
                
//                  itemCount: data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                    children:snapshot.data!.docs.map((DocumentSnapshot document){
                  
//                   return InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Row(
//                         children: <Widget>[
//                           Container(
//                             width: 60,
//                             height: 60,
//                             child: Stack(
//                               children: <Widget>[
//                                 data[index]['hasStory']
//                                     ? Container(
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             border: Border.all(
//                                                 color: Colors.blueAccent,
//                                                 width: 3)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(3.0),
//                                           child: Container(
//                                             width: 75,
//                                             height: 75,
//                                             decoration: BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 image: DecorationImage(
//                                                     image: NetworkImage(
//                                                         data[index]
//                                                             ['imageUrl']),
//                                                     fit: BoxFit.cover)),
//                                           ),
//                                         ),
//                                       )
//                                     : Container(
//                                         width: 70,
//                                         height: 70,
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             image: DecorationImage(
//                                                 image: NetworkImage(
//                                                     data[index]
//                                                         ['imageUrl']),
//                                                 fit: BoxFit.cover)),
//                                       ),
//                                 data[index]['isOnline']
//                                     ? Positioned(
//                                         top: 38,
//                                         left: 42,
//                                         child: Container(
//                                           width: 20,
//                                           height: 20,
//                                           decoration: BoxDecoration(
//                                               color: Color(0xFF66BB6A),
//                                               shape: BoxShape.circle,
//                                               border: Border.all(
//                                                   color: Color(0xFFFFFFFF),
//                                                   width: 3)),
//                                         ),
//                                       )
//                                     : Container()
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 data[index]['name'],
//                                 style: TextStyle(
//                                     fontSize: 17, fontWeight: FontWeight.w500),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width - 135,
//                                 child: Text(
//                                   data[index]['message'] +
//                                       " - " +
//                                       data[index]['time'],
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       color:
//                                           Color(0xFF000000).withOpacity(0.7)),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 });
//           }
               
      
//     );

