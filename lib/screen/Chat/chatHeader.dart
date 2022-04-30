import 'package:flutter/material.dart';
import 'package:flutter_chat/screen/Chat/newChat.dart';

import '../../models/user.dart';

class ChatHeader extends StatelessWidget {
  List<User> user;
  ChatHeader(this.user);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        margin: const EdgeInsets.only(top:10),
        padding: const EdgeInsets.all(20),
        width: width,
        height: height * (1/3),
        child: Column(
          children: [
            Container(
                height: 70,
                width: width,
                child: Row(children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.asset("assets/images/telegram.png",
                          height: 45, width: 45, fit: BoxFit.cover)),
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text("VTeach",
                          style: TextStyle(
                              fontSize: 27,
                              fontFamily: "Regular",
                              color: Colors.white)))
                ])),
            Container(
                width: width,
                height: 80,
                child: Row(
                  children: [
                    Container(
                        width: 275,
                        height: 40,
                        child: const TextField(
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                labelText: "Sreach...",
                                suffixIcon: Icon(Icons.find_replace,
                                    color: Color.fromRGBO(86, 94, 112, 1))))),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(3, 169, 241, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.add),
                        onPressed: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddRoomChat(user,user[0].idUser)))
                        },
                      ),
                    )
                  ],
                )),
            Container(
              child:Column(children: [
              Container(
                alignment:Alignment.topLeft,
                child: const Text("Message",style:TextStyle(fontSize:20,fontFamily: 'Regular',color: Colors.white)))
            ],))
          ],
          
        ));
  }
}
    





   



