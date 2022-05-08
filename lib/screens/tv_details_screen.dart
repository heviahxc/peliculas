import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class TvDetailsScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    // TODO: Cambiar luego por una instancia de movie
    final Tv tv = ModalRoute.of(context)!.settings.arguments as Tv;
  

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( tv ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle( tv ),
              _Overview( tv ),
              //CastingCards( tv.id ),
             // SizedBox(height: 5),
             //const Text('Peliculas Similares', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
             //SizedBox(height: 5),
              //SimilarMoviesCard(movie.id)
              

            ]),
            
          ),
          
        ],
        
      )
      
    );
  }
}


class _CustomAppBar extends StatelessWidget {

  final Tv tv;

  const _CustomAppBar( this.tv );

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only( bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
              tv.name,
              style: const TextStyle( fontSize: 16 ),
              textAlign: TextAlign.center,
            ),
        ),

        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage( tv.fullBackDropPath ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class _PosterAndTitle extends StatelessWidget {
  
  final Tv tv;
 

  const _PosterAndTitle( this.tv );


  @override
  Widget build(BuildContext context) {
    
  
    
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;


    return Container(
      margin: const EdgeInsets.only( top: 20 ),
      padding: const EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [

          
          Hero(
            tag: tv.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage( tv.fullPosterImg ),
                height: 150,
              ),
            ),
          ),

          const SizedBox( width: 20 ),

          ConstrainedBox(
            constraints: BoxConstraints( maxWidth: size.width - 190 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text( tv.name, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2 ),
                
                Text( tv.originalName, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),

                Row(
                  children: [
                   const Icon( Icons.star_outline, size: 15, color: Colors.grey ),
                  const  SizedBox( width: 5 ),
                    Text( '${tv.voteAverage}', style: textTheme.caption )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {

  final Tv tv;

  const _Overview(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 10),
      child: Text(
        tv.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}