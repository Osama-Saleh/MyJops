
// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentModel {
  String? text;
  String? timeDate;
  CommentModel({
    this.text,
    this.timeDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'timeDate': timeDate,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      text: json['text'] != null ? json['text'] as String : null,
      timeDate: json['timeDate'] != null ? json['timeDate'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
