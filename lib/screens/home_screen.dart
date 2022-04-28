import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';



class HomeScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

     return Scaffold(
       appBar: AppBar(
         title: const Text('Peliculas en Cine'),
         elevation: 0,
         actions: [
           IconButton
           (onPressed: (() {}),
            icon: const Icon(Icons.search_outlined))
         ],
       ),

       body: SingleChildScrollView(
         child:Column(
        children: [
         CardSwiper(movies: moviesProvider.onDisplayMovies, ),
         MovieSlider(movies: moviesProvider.popularMovies,)


        ],
      ) ,
         )


       
     
      );
    
  }
}