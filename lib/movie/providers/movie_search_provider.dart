import 'package:clickmovie_app/movie/models/movie_model.dart';
import 'package:clickmovie_app/movie/repostories/movie_repository.dart';
import 'package:flutter/material.dart';

class MovieSearchProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieSearchProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void search(BuildContext context, {required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.search(query: query);

    result.fold(
      (errormessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errormessage)),
        );

        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }
}
