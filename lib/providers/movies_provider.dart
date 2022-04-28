import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:peliculas/models/models.dart';      


class MoviesProvider extends ChangeNotifier{

  String _apiKey = 'f90913ab18bbf28e1b1d0710575c3683';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider(){

    print('Movies provider inicializado');

    getOnDisplayMovies();
  }


  getOnDisplayMovies() async{
     var url =
      Uri.https(_baseUrl, '3/movie/now_playing', {
        'api_key': _apiKey,
        'language': _language,
        'page': '1'

      });

  // Await the http get response, then decode the json-formatted response.
  final response = await http.get(url);

  final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

  onDisplayMovies = nowPlayingResponse.results;

  notifyListeners();

  }

  getPopularMovies() async{
     var url =
      Uri.https(_baseUrl, '3/movie/popular', {
        'api_key': _apiKey,
        'language': _language,
        'page': '1'

      });

  // Await the http get response, then decode the json-formatted response.
  final response = await http.get(url);

  final popularResponse = PopularResponse.fromJson(response.body);

  popularMovies = [...popularMovies, ...popularResponse.results];

  notifyListeners();

  }

}