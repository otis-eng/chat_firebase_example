import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_chat/components/chat_detail_page_appbar.dart';
import 'package:flutter_chat/models/send_menu_items.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import '../data/chat.data.dart';


enum MessageType {
  Sender,
  Receiver,
}

class ChatDetailPage extends StatefulWidget {
  final String idUser;
  final String avatarMember;
  final String nameMember;
  final String idRoom;
  final List idMember;
  final String typeRoom;
  ChatDetailPage(
      {required this.idUser,
      required this.idRoom,
      required this.idMember,
      required this.avatarMember,
      required this.nameMember,
      required this.typeRoom});
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  File? _photo;
  File? document;
  final ImagePicker _picker = ImagePicker();
  List<SendMenuItems> menuItems = [
    SendMenuItems(text: "Photos", icons: Icons.image, color: Colors.amber),
    SendMenuItems(
        text: "Videos", icons: Icons.music_note, color: Colors.orange),
    SendMenuItems(text: "Camera", icons: Icons.person, color: Colors.purple),
    SendMenuItems(
        text: "Document", icons: Icons.insert_drive_file, color: Colors.blue),
    SendMenuItems(
        text: "Location", icons: Icons.location_on, color: Colors.green),
  ];
  Future sendImg(typeImg) async {
    ImagePicker imagePicker = ImagePicker();

    final pickedFile = await imagePicker.pickImage(source: typeImg);

    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      if (_photo != null) {
        setState(() {
          _photo = File(pickedFile.path);
        });
      }
    }

    Navigator.pop(context);
    await uploadImg();
  }

  Future uploadImg() async {
    String imgUrl = "";
    if (_photo == null) return;
    final fileName = Path.basename(_photo!.path);
    final destination = 'file/$fileName';
    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      UploadTask updaloadTask = ref.putFile(_photo!);
      TaskSnapshot snapshot = await updaloadTask;
      imgUrl = await snapshot.ref.getDownloadURL();
      message.sendChatMessage(
          idRoom: widget.idRoom,
          author: widget.idUser,
          content: imgUrl,
          typeMessage: "image");
    } catch (error) {
      print('error occured' + error.toString());
    }
  }

  Future selectFile() async {
    final response = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (response == null) return;
    final path = response.files.single.path!;
    setState(() => {document = File(path)});
    Navigator.pop(context);
    await uploadFile();
  }

  Future uploadFile() async {
    String fileURL;
    if (document == null) return;
    final fileName = Path.basename(document!.path);
    final destination = 'file/$fileName';
    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      UploadTask updaloadTask = ref.putFile(document!);
      TaskSnapshot snapshot = await updaloadTask;
      fileURL = await snapshot.ref.getDownloadURL();
      message.sendChatMessage(
          idRoom: widget.idRoom,
          author: widget.idUser,
          content: fileURL,
          nameFile: fileName,
          typeMessage: "file");
    } catch (error) {
      print('error occured' + error.toString());
    }
  }

  // Future readPFT(content) async{
  //   PDFDocument doc = await PDFDocument.fromURL(content);
  // }
  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Color(0xff737373),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      await sendImg(ImageSource.gallery);
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: menuItems[0].color?.shade300,
                              ),
                              height: 50,
                              width: 50,
                              child: Icon(
                                menuItems[0].icons,
                                size: 20,
                                color: menuItems[0].color?.shade400,
                              ),
                            ),
                            title: Text(menuItems[0].text.toString()))),
                  ),
                  InkWell(
                    onTap: () {
                      print("send video");
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: menuItems[1].color?.shade300,
                              ),
                              height: 50,
                              width: 50,
                              child: Icon(
                                menuItems[1].icons,
                                size: 20,
                                color: menuItems[1].color?.shade400,
                              ),
                            ),
                            title: Text(menuItems[1].text.toString()))),
                  ),
                  InkWell(
                    onTap: () async {
                      await sendImg(ImageSource.camera);
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: menuItems[2].color?.shade300,
                              ),
                              height: 50,
                              width: 50,
                              child: Icon(
                                menuItems[2].icons,
                                size: 20,
                                color: menuItems[2].color?.shade400,
                              ),
                            ),
                            title: Text(menuItems[2].text.toString()))),
                  ),
                  InkWell(
                    onTap: () async {
                      await selectFile();
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: menuItems[3].color?.shade300,
                              ),
                              height: 50,
                              width: 50,
                              child: Icon(
                                menuItems[3].icons,
                                size: 20,
                                color: menuItems[3].color?.shade400,
                              ),
                            ),
                            title: Text(menuItems[3].text.toString()))),
                  ),
                ],
              ),
            ),
          );
        });
  }

  TextEditingController messageController = TextEditingController();

  Chats message = new Chats();
  @override
  Widget build(BuildContext context) {
    String idUser = widget.idUser;
    String avatarMember = widget.avatarMember;
    String nameMember = widget.nameMember;
    String idRoom = widget.idRoom;
    List idMember = widget.idMember;
    String typeRoom = widget.typeRoom;
    final _usersStream = FirebaseFirestore.instance
        .collection('message')
        .where('idRoom', isEqualTo: widget.idRoom)
        .orderBy('timestamp', descending: false)
        .snapshots();

    return Scaffold(
      appBar: ChatDetailPageAppBar(
          nameMember: nameMember, avatarMember: avatarMember),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 100),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Loader();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader();
                }
                if (snapshot.hasData) {
                  final data = snapshot.data!.docs;

                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        // if (idRoom == data[index]["idRoom"]) {
                        return itemChat(
                            data[index]["author"],
                            data[index]["content"],
                            data[index]["timestamp"],
                            nameMember,
                            data[index]["typeMessage"],
                            data[index]["nameFile"] ?? '');
                        // }
                      });
                }
                return Loader();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showModal();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          hintText: "Enter message...",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(right: 30, bottom: 50),
              child: FloatingActionButton(
                onPressed: () {
                  if (messageController.value.text != "") {
                    message.sendChatMessage(
                        idRoom: widget.idRoom,
                        author: idUser,
                        content: messageController.value.text.toString(),
                        typeMessage: "text");
                    messageController.clear();
                  }
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                backgroundColor: Colors.pink,
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget itemChat(
      author, content, timestamp, nameMember, typeMessage, nameFile) {
    bool user = false;
    if (author == widget.idUser) {
      user = true;
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              user ? "You" : nameMember,
              style: TextStyle(
                  fontSize: 13, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),
          typeMessage == "text"
              ? Material(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    topLeft: user ? Radius.circular(50) : Radius.circular(0),
                    bottomRight: Radius.circular(50),
                    topRight: user ? Radius.circular(0) : Radius.circular(50),
                  ),
                  color: user ? Colors.blue : Colors.white,
                  elevation: 5,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Text(
                        content,
                        style: TextStyle(
                          color: user ? Colors.white : Colors.blue,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      )))
              : typeMessage == "image"
                  ? reivewImg(content, user)
                  : reviewFile(content, nameFile, user)
        ],
      ),
    );
  }

  Widget reivewImg(img, user) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            topLeft: user ? Radius.circular(50) : Radius.circular(0),
            bottomRight: Radius.circular(50),
            topRight: user ? Radius.circular(0) : Radius.circular(50),
          ),
        ),
        child: Image.network(
          img,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ));
  }

  Widget reviewFile(file, nameFile, user) {
    return GestureDetector(

          onTap: () async {
            // var url = Uri.encodeFull(file);
            // if (await canLaunch(url)) {
            //   print("namefile"+file);
            //   await launch(url);
            // } else {
            //   throw 'Could not launch $file';
            // }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                topLeft: user ? Radius.circular(50) : Radius.circular(0),
                bottomRight: Radius.circular(50),
                topRight: user ? Radius.circular(0) : Radius.circular(50),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.file_present_rounded),
                Text(nameFile, style: TextStyle())
              ],
            ),
          ),
        );
  }
}

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator.adaptive(
            backgroundColor: Color.fromARGB(255, 58, 243, 33)));
  }
}
