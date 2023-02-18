// ignore_for_file: non_constant_identifier_names

class ChatModel {
  String? dateTime;
  String? SenderId;
  String? receiverId;
  String? text;
  ChatModel({
    this.dateTime,
    this.SenderId,
    this.receiverId,
    this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime,
      'SenderId': SenderId,
      'receiverId': receiverId,
      'text': text,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      dateTime: json['dateTime'] != null ? json['dateTime'] as String : null,
      SenderId: json['SenderId'] != null ? json['SenderId'] as String : null,
      receiverId:
          json['receiverId'] != null ? json['receiverId'] as String : null,
      text: json['text'] != null ? json['text'] as String : null,
    );
  }
}
