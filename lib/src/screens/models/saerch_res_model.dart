import 'dart:convert';

class SearchResModel {
  String? status;
  int? totalResults;
  List<Article>? articles;

  SearchResModel({this.status, this.totalResults, this.articles});

  SearchResModel copyWith({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) => SearchResModel(
    status: status ?? this.status,
    totalResults: totalResults ?? this.totalResults,
    articles: articles ?? this.articles,
  );

  factory SearchResModel.fromJson(String str) =>
      SearchResModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchResModel.fromMap(Map<String, dynamic> json) => SearchResModel(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: json["articles"] == null
        ? []
        : List<Article>.from(json["articles"]!.map((x) => Article.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "totalResults": totalResults,
    "articles": articles == null
        ? []
        : List<dynamic>.from(articles!.map((x) => x.toMap())),
  };
}

class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Article copyWith({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) => Article(
    source: source ?? this.source,
    author: author ?? this.author,
    title: title ?? this.title,
    description: description ?? this.description,
    url: url ?? this.url,
    urlToImage: urlToImage ?? this.urlToImage,
    publishedAt: publishedAt ?? this.publishedAt,
    content: content ?? this.content,
  );

  factory Article.fromJson(String str) => Article.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Article.fromMap(Map<String, dynamic> json) => Article(
    source: json["source"] == null ? null : Source.fromMap(json["source"]),
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"],
    publishedAt: json["publishedAt"] == null
        ? null
        : DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );

  Map<String, dynamic> toMap() => {
    "source": source?.toMap(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt?.toIso8601String(),
    "content": content,
  };
}

class Source {
  Id? id;
  Name? name;

  Source({this.id, this.name});

  Source copyWith({Id? id, Name? name}) =>
      Source(id: id ?? this.id, name: name ?? this.name);

  factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Source.fromMap(Map<String, dynamic> json) =>
      Source(id: idValues.map[json["id"]], name: nameValues.map[json["name"]]);

  Map<String, dynamic> toMap() => {
    "id": idValues.reverse[id],
    "name": nameValues.reverse[name],
  };
}

enum Id { TECHCRUNCH }

final idValues = EnumValues({"techcrunch": Id.TECHCRUNCH});

enum Name { TECH_CRUNCH }

final nameValues = EnumValues({"TechCrunch": Name.TECH_CRUNCH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
