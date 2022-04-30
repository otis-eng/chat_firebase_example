import 'package:flutter/material.dart';
import 'package:flutter_chat/screen/Chat/chatHeader.dart';

import '../../models/user.dart';
import 'chatBody.dart';

class Chat extends StatefulWidget {
  const Chat({ Key? key }) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

List<User> user = [
      User("1", "Karina😈",
          "https://res.cloudinary.com/phankieuphuicloud/image/upload/v1625397771/imgAvatar/i_3_yikndu.jpg"),
      User("2", "Rosé🥰",
          "https://res.cloudinary.com/phankieuphuicloud/image/upload/v1650925713/imgs_ia5sgt.jpg"),
      User("3", "Lộ Tư 😍",
          "https://res.cloudinary.com/phankieuphuicloud/image/upload/v1650900941/img_shdh1l.png"),
      User("4", "LPhu",
          "https://res.cloudinary.com/phankieuphuicloud/image/upload/v1648665347/tnhds28pz9wwksbwne7o.png"),
    ];
       
  @override
  Widget build(BuildContext context) {
    double witdh = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
        color:const Color.fromRGBO(41, 47, 63, 1),
        child:Column(
          children: [
            ChatHeader(user),
            ChatBody(user),
          ],
        )
    );
  }
}