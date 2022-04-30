import 'package:flutter/material.dart';

import '../../models/group.models.dart';
import '../../models/user.dart';

class AddGroup extends StatefulWidget {
  List<User> user;
  String idUser;
  AddGroup(this.user, this.idUser);

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  List<Group> groups = <Group>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    var  user = widget.user;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("New Group")),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(color: Colors.red),
                  margin: EdgeInsets.only(top: 5),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: groups.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height: 50,
                              margin:
                                  EdgeInsets.only(left: 5, top: 15, bottom: 15),
                              decoration: BoxDecoration(color: Colors.blue),
                              child: Row(
                                children: [
                              Container(
                                width: 60,
                                height: 50,
                                child: Stack(
                                  children: <Widget>[
                                    Avatar(groups[index].avatarUser),
                                  ],
                                ),
                              ),
                                  SizedBox(width: 5),
                                  Text(groups[index].nameUser),
                                  Icon(Icons.clear_outlined)
                                ],
                              ));
                        }),
                  )),
              Expanded(
                      child: ListView.builder(
                        
                        itemCount:user.length,
                          itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: width,
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: width * (1/5),
                                height: 60,
                                child: Stack(
                                  children: <Widget>[
                                    Avatar(user[index].avatarUser),
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
                              Container(
                                width: width * (1/2),
                                child: Column(
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
                              ),
                              Container(
                                width: width * (1/6),
                                alignment: Alignment.centerRight,
                                child:IconButton(onPressed: (){
                                    bool isOnClick = false;
                                    setState(() {
                                        
                                        if(isOnClick != false){
                                          groups.remove(Group(idUser:user[index].idUser,nameUser:user[index].nameUser,avatarUser:user[index].avatarUser));
    
                                        }else{
                                            isOnClick != isOnClick;
                                        groups.add(Group(idUser:user[index].idUser,nameUser:user[index].nameUser,avatarUser:user[index].avatarUser));
                                        }
                                        
                                        
                                        // print(groups[2].avatarUser);
                                        user.remove(User(user[index].idUser,user[index].nameUser,user[index].avatarUser));
                                    });
                                }, icon: Icon(Icons.add)))                            
                            ],
                          ),
                        );
                      })),
                      
            ],
          )),
    );
  }

  Widget Avatar(String img) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
    );
  }
}
