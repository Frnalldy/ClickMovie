import 'package:clickmovie_app/movie/pages/movie_detail_page.dart';
import 'package:clickmovie_app/movie/providers/movie_search_provider.dart';
import 'package:clickmovie_app/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchPage extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search movies";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0.5,
    ));
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (query.isNotEmpty) {
        context.read<MovieSearchProvider>().search(context, query: query);
      }
    });

    return Consumer<MovieSearchProvider>(
      builder: (_, provider, __) {
        if (query.isEmpty) {
          return const Center(child: Text("Search movies"));
        }

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.movies.isEmpty) {
          return const Center(child: Text("Movies not Found"));
        }

        if (provider.movies.isNotEmpty) {
          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (_, index) {
              final movie = provider.movies[index];
              return Stack(
                children: [
                  Row(
                    children: [
                      ImageNetworkWidget(
                        imageSrc: movie.posterPath,
                        height: 120,
                        width: 80,
                        radius: 10,
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              movie.overview,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          close(context, null);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return MovieDetailPage(id: movie.id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10.0),
            itemCount: provider.movies.length,
          );
        }

        return const Center(child: Text("Another error on search movies"));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
