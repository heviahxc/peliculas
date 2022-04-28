import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
     final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

     return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([

              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              CastingCards()
              
            ]

            )

            )

        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {


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
        color: Colors.black12,
        padding: EdgeInsets.only(bottom: 10),
        child: const Text('Movie.title', style: TextStyle(fontSize: 16),),
      ),
      background: const FadeInImage(
        placeholder: AssetImage('assets/loading.gif'), 
        image: NetworkImage( 'https://via.placeholder.com/300x400'),
        fit: BoxFit.cover,
        ),
),

    );
  }
}

class _PosterAndTitle extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage( 'https://via.placeholder.com/200x300'),
                height: 150,
                ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('movie.title', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text('movie.originaltitle', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis,),

                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                    SizedBox(width: 5,),
                    Text('movie.voteaverage', style: textTheme.caption,)
                  ],
                )


              ],
            )
          ],
        ),
);
  }
}

class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text('Fugiat ut adipisicing aliqua fugiat ea deserunt sunt Lorem consequat proident elit eiusmod. Officia consequat ut qui commodo velit. Reprehenderit aliquip occaecat labore pariatur consectetur. Id nostrud ipsum ut officia sint excepteur sint qui voluptate. Voluptate aliqua excepteur occaecat ullamco aliquip proident et reprehenderit duis reprehenderit nostrud pariatur. Tempor irure laboris enim in nostrud eiusmod minim elit.'
      , textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,),



    );
  }
}