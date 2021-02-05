class SurasListItemModel {
  final int userId;
  final int id;
  final String title;
  final String body;
  SurasListItemModel(this.userId, this.id, this.title, this.body);

  factory SurasListItemModel.fromJson(Map<String, dynamic> json) {
    return SurasListItemModel(
      json['userId'],
      json['id'],
      json['title'],
      json['body'],
    );
  }
}
