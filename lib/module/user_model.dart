// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_init_to_null
class UserModel {
  String? name;
  String? phone;
  String? mail;
  String? password;
  String? uid;
  String? profileImage;
  String? coverImage;
  String? bio = null;
  UserModel({
    this.name,
    this.phone,
    this.mail,
    this.password,
    this.uid,
    this.profileImage,
    this.coverImage,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'mail': mail,
      'password': password,
      'uid': uid,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'bio': bio,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] != null ? json['name'] as String : null,
      phone: json['phone'] != null ? json['phone'] as String : null,
      mail: json['mail'] != null ? json['mail'] as String : null,
      password: json['password'] != null ? json['password'] as String : null,
      uid: json['uid'] != null ? json['uid'] as String : null,
      profileImage:
          json['profileImage'] != null ? json['profileImage'] as String : null,
      coverImage:
          json['coverImage'] != null ? json['coverImage'] as String : null,
      bio: json['bio'] != null ? json['bio'] as String : null,
    );
  }
}
