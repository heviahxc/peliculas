
import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 180,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, int index) => _CastCard(),
          ),




    );
  }
}

class _CastCard extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
        width: 100,
        height: 100,

        child: Column(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
               placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage( 'https://via.placeholder.com/150x300'),
                height: 140,
                width:100,
                fit: BoxFit.cover,
                 ),
            ),
            SizedBox(height: 5,),

            const Text(
              'Actornamed.blablabalbalballbabl',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )



          ],
        ),

    );
  }
}