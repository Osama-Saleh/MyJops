
// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  String? name;
  String? imageProfile;
  String? uid;
  String? text;
  String? imagepost;
  String? dateTime;
  PostModel({
    this.name,
    this.imageProfile,
    this.uid,
    this.text,
    this.imagepost,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageProfile': imageProfile,
      'uid': uid,
      'text': text,
      'imagepost': imagepost,
      'dateTime': dateTime,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      name: json['name'] != null ? json['name'] as String : null,
      imageProfile:
          json['imageProfile'] != null ? json['imageProfile'] as String : null,
      uid: json['uid'] != null ? json['uid'] as String : null,
      text: json['text'] != null ? json['text'] as String : null,
      imagepost: json['imagepost'] != null ? json['imagepost'] as String : null,
      dateTime: json['dateTime'] != null ? json['dateTime'] as String : null,
    );
  }
}
