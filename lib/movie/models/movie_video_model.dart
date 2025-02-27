class MovieVideosModel {
    final int id;
    final List<Result> results;

    MovieVideosModel({
        required this.id,
        required this.results,
    });

    factory MovieVideosModel.fromJson(Map<String, dynamic> json) => MovieVideosModel(
        id: json["id"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );
}

class Result {
    final String name;
    final String key;
    final String site;
    final String type;
    final bool official;
    final String id;

    Result({
        required this.name,
        required this.key,
        required this.site,
        required this.type,
        required this.official,
        required this.id,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        key: json["key"],
        site: json["site"],
        type: json["type"],
        official: json["official"],
        id: json["id"],
    );
}
