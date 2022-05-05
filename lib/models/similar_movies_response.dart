// To parse this JSON data, do
//
//     final similarMoviesResponse = similarMoviesResponseFromMap(jsonString);

import 'dart:convert';

import 'models.dart';

class SimilarMoviesResponse {
    SimilarMoviesResponse({
    required    this.page,
    required    this.results,
    required    this.totalPages,
    required    this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory SimilarMoviesResponse.fromJson(String str) => SimilarMoviesResponse.fromMap(json.decode(str));


    factory SimilarMoviesResponse.fromMap(Map<String, dynamic> json) => SimilarMoviesResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

   
}

