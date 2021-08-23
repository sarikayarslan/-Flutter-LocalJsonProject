

class Item {
  int id;
  int parentId;
  String picture;
  String name;

  Item({this.id, this.parentId, this.name, this.picture});

  Item.fromJson(Map<String, dynamic> json){
    id = json["id"];
    parentId = json["parentId"];
    picture = json["picture"];
    name = json["name"];
  }
}