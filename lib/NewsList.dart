class NewsList {

  List<Post> posts;

  NewsList(this.posts);

  factory NewsList.fromJson(Map<String, dynamic> json) {
    final list = json['News'] as List;
    return NewsList(
        list.map((jsonPost) => Post.fromJson(jsonPost)).toList()
    );
  }

}

class Post {
  int id;
  String title;
  String content;
  String imageUrl;
  String date;

  Post(this.id, this.title, this.content, this.imageUrl, this.date);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json['id'],
      json['NewsTitle'],
      json['NewsContent'],
      json['NewsImage'],
      json['NewsDate'],
    );
  }

}