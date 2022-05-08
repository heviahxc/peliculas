
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class SimilarMoviesCard extends StatelessWidget {

  final int movieId;

  const SimilarMoviesCard(this.movieId); 

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getSimilarMovies(movieId),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {

        if(!snapshot.hasData){
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Movie> movie = snapshot.data!;

        return Container(
        width: double.infinity,
        height: 180,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, int index) => _SimilarCard(movie: movie[index],),
          ),

    );
      },
    );

  }
}

class _SimilarCard extends StatelessWidget {
 
  final Movie movie;

  const _SimilarCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'similar-card-${movie.id}';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 100,
        height: 100,

        child: Column(
          children: [

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details', arguments: movie ),
              child: Hero(
                tag: movie.heroId!,
                child: ClipRRect(
                  
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                   placeholder: const AssetImage('assets/no-image.jpg'), 
                    image: NetworkImage( movie.fullPosterImg),
                    height: 140,
                    width:100,
                    fit: BoxFit.cover,
                     ),
                ),
              ),
            ),
            const SizedBox(height: 5,),

             Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )



          ],
        ),

    );
  }
}