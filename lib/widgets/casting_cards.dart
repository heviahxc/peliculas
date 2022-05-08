
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards(this.movieId); 

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {

        if(!snapshot.hasData){
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
        width: double.infinity,
        height: 180,
        child: ListView.builder(
          itemCount: cast.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, int index) => _CastCard(actor: cast[index],),
          ),

    );
      },
    );


   
  }
}

class _CastCard extends StatelessWidget {
 
  final Cast actor;

  const _CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 100,
        height: 100,

        child: Column(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
               placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage( actor.fullProfilePaht),
                height: 140,
                width:100,
                fit: BoxFit.cover,
                 ),
            ),
            const SizedBox(height: 5,),

             Text(
              actor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )



          ],
        ),

    );
  }
}