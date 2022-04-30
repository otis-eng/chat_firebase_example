class Room {
  String? idRoot;
  String? idMember;
  String? typeRoom;

  Room({this.idRoot, this.idMember, this.typeRoom});

  Room.fromJson(Map<String, dynamic> json) {
    idRoot = json['idRoot'];
    idMember = json['idMember'];
    typeRoom = json['typeRoom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idRoot'] = this.idRoot;
    data['idMember'] = this.idMember;
    data['typeRoom'] = this.typeRoom;
    return data;
  }
}
