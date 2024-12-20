class NotiModel {
  final String from;
  final String to;
  final String dateTime;
  final String? postId;
  final NotiCategory category;

  NotiModel({
    required this.from,
    required this.to,
    required this.dateTime,
    required this.postId,
    required this.category,
  });

  factory NotiModel.fromJson(Map<String, dynamic> json) {
    return NotiModel(
      from: json['from'],
      to: json['to'],
      dateTime: json['date_time'],
      postId: json['post_id'],
      category: NotiCategory.values.firstWhere((e) {
        return e.id == json['category'];
      }),
    );
  }

  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
        'date_time': dateTime,
        'post_id': postId,
        'category': category.id,
      };
}

enum NotiCategory {
  like('like', desc: 'liked your post'),
  comment('comment', desc: 'commented on your post'),
  request('request', desc: 'requested to be friends with you');

  const NotiCategory(this.id, {required this.desc});
  final String desc;
  final String id;
}
