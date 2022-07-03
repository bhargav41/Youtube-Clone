class DatasetModel {
  int id;
  String title;
  String videoUrl;
  String thumbnail;

  DatasetModel(this.id, this.title, this.videoUrl, this.thumbnail);

  factory DatasetModel.fromJson(Map<String, dynamic> json) {
    return DatasetModel(
        json['id'], json['title'], json['videoUrl'], json['coverPicture']);
  }
}
