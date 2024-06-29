import 'package:duplikat_applikasi/movie/models/movie_model.dart';
import 'package:duplikat_applikasi/movie/repositories/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MovieGetTopRatedProvider with ChangeNotifier{
  final MovieRepository _movieRepository;

  MovieGetTopRatedProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get Movies => _movies;

  void getTopRated(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.getTopRated();

    result.fold(
      (messageError){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
      
      _isLoading = false;
      notifyListeners();

      return;

    },
    (respose) {
      _movies.clear();
      _movies.addAll(respose.results);

      _isLoading = false;
      notifyListeners();
      return;
    },
    );
  }

  void getTopRatedWithPagination(
    BuildContext context,{
      required PagingController pagingController,
    required int page,  
  }) async {
    final result = await _movieRepository.getTopRated();

    result.fold(
      (messageError){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        pagingController.error = messageError;
        
      return;
    },
    (response) {
      if (response.results.length < 20){
        pagingController.appendLastPage(response.results);
      } else {
        pagingController.appendPage(response.results, page + 1);
      }
      return;
    },
    );
  }
}