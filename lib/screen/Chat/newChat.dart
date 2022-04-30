import 'package:flutter/material.dart';
import 'package:flutter_chat/modules/chat_detail_page.dart';
import 'package:flutter_chat/screen/Chat/newGroup.dart';

import '../../data/room.data.dart';
import '../../models/user.dart';

class AddRoomChat extends StatefulWidget {
  List<User> users;
  String idUser;
  AddRoomChat(this.users, this.idUser);
  @override
  State<AddRoomChat> createState() => _AddRoomChatState();
}

class _AddRoomChatState extends State<AddRoomChat> {
  @override
  Widget build(BuildContext context) {
    Rooms room = new Rooms();
    bool isUser = false;
    final user = widget.users;
    final idUsers = widget.idUser;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add New Chat"),
          actions: <Widget>[
            IconButton(
              icon:const Icon(
                Icons.group_add_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                print("new group");
                Navigator.push(context,MaterialPageRoute(builder: (context)=>AddGroup(user,idUsers)));
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: user.length,
            itemBuilder: (BuildContext context, int index) {
              if (widget.users[index].idUser == widget.idUser) {
                isUser = true;
              }
              return GestureDetector(
                onTap: () async {
                  List idMember;
                  idMember = [idUsers, user[index].idUser];
                  final idRoom = await room.addRoom(
                      idMember: user[index].idUser,
                      idRoot: idUsers,
                      avatarMember: user[index].avatarUser,
                      nameMember: user[index].nameUser);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatDetailPage(
                              idUser: widget.idUser,
                              idRoom: idRoom,
                              idMember: idMember,
                              avatarMember: user[index].avatarUser,
                              nameMember: user[index].nameUser,
                              typeRoom: "privatie")));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            AvatarOff(user[index].avatarUser),
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
                                        color: Color(0xFFFFFFFF), width: 3)),
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
                            user[index].nameUser,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  Widget AvatarOff(String img) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
    );
  }
}
