import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'dart:convert';

import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/search_response.dart';
import 'package:peliculas/search/search_delegate.dart';      


class MoviesProvider extends ChangeNotifier{

  String _apiKey = 'f90913ab18bbf28e1b1d0710575c3683';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

 Map<int, List<Cast>> moviesCast = {};

 Map<int, List<Movie>> moviesSimilar = {};

  int _popularPage = 0;

 final debouncer = Debouncer(
   duration: Duration(milliseconds: 500), 
   );
 final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
 Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;




  MoviesProvider(){
    getOnDisplayMovies();
    getPopularMovies();

    

  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async{

 final url =
      Uri.https(_baseUrl, endpoint, {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page'

      });

  // Await the http get response, then decode the json-formatted response.
  final response = await http.get(url);
  return response.body;
  }

  getOnDisplayMovies() async{
    
  final jsonData = await _getJsonData('3/movie/now_playing');
  final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
  onDisplayMovies = nowPlayingResponse.results;

  notifyListeners();

  }

  getPopularMovies() async{
    
  _popularPage++;
  final jsonData = await _getJsonData('3/movie/popular', _popularPage);
  final popularResponse = PopularResponse.fromJson(jsonData);

  popularMovies = [...popularMovies, ...popularResponse.results];

  notifyListeners();

  }

 Future<List<Movie>> getSimilarMovies(int movieId) async {

    if(moviesSimilar.containsKey(movieId)) return moviesSimilar[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/similar');
    final similarResponse = SimilarMoviesResponse.fromJson(jsonData);

    moviesSimilar[movieId] = similarResponse.results;

    return similarResponse.results; 

  }


  Future<List<Cast>> getMovieCast(int movieId) async {

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast; 

  }

 Future<List<Movie>> searchMovies( String query) async{

   final url =
      Uri.https(_baseUrl, '3/search/movie', {
        'api_key': _apiKey,
        'language': _language,
        'query' : query

      });

    final response = await http.get(url);
  final searchResponse = SearchResponse.fromJson(response.body) ;

  return searchResponse.results;
  }

  void getSuggestionsByQuery (String searchTerm){

    debouncer.value = '';
    debouncer.onValue = (value) async{
      
      final result =  await searchMovies(value);
      _suggestionStreamController.add(result);
    };

    final timer  = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
     });

     Future.delayed(Duration(milliseconds: 300)).then((_) => timer.cancel());
  }

}