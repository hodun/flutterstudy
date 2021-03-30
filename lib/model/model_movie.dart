class Movie {
  final String title;
  final String keyword;
  final String poster;
  final bool like;

//  Movie.fromMap(Map)

  Movie.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  @override
  String toString() => "Movie<$title:$keyword>";
  //Movie(this.title, this.keyword, this.poster, this.like);
}
