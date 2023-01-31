class Character {
 late int id;
 late String name;
 late String status;
 late String species;
 late String type;
 late String gender;
 late Origin origin;
 late Origin location;
 late String image;
 late List<String> episode;
 late String url;
 late String created;

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin =
    json['origin']=Origin.fromJson(json['origin']);
    location =
    json['location'] =   Origin.fromJson(json['location']);
    image = json['image'];
    episode = json['episode'].cast<String>();
    url = json['url'];
    created = json['created'];
  }
}

class Origin {
 late String name;
 late String url;

  Origin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
