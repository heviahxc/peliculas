import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/models.dart';

class MovieSlider extends StatelessWidget {

final List<Movie> movies;

  const MovieSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          //depende del titulo
         const Padding
         (padding: EdgeInsets.symmetric(horizontal: 20),
         child: Text('Populares', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
         ),
        
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MoviePoster(movies[index])
            ),
        )
        ],
      ),


    );
  }
}

class _MoviePoster extends StatelessWidget {

 final Movie movie;

 const _MoviePoster(this.movie);


  @override
  Widget build(BuildContext context) {
    
    return Container(
                
                width: 130,
                height: 190,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                   
                    GestureDetector(

                           onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),

                      child: ClipRRect(
                        
                        borderRadius: BorderRadius.circular(20),
                        child:  FadeInImage(
                          placeholder: AssetImage('assets/no-image.jpg'), 
                          image: NetworkImage(movie.fullPosterImg),
                          width: 120,
                          height: 190,
                          fit: BoxFit.cover,
                          ),
                      ),
                    ),

                   const  SizedBox(height: 5,),
                  
                 Text(
                  'movie.title',
              
                     overflow: TextOverflow.ellipsis,
                     textAlign: TextAlign.center,)
                  ],
                ),
              );
  }
}