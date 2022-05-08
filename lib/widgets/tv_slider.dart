import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/models.dart';

class TvSlider extends StatefulWidget {

final List<Tv> tv;
final String? title;
final Function onNextPage;

  const TvSlider({Key? key, required this.tv,
                               required this.onNextPage,
                               this.title
                               }) : super(key: key);

  @override
  State<TvSlider> createState() => _TvSliderState();
}

class _TvSliderState extends State<TvSlider> {

final ScrollController scrollController = new ScrollController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  scrollController.addListener(() {
    
    if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500){
      widget.onNextPage();

    }

  });


    
  }

  @override
  void dispose() {
    // TODO: implement dispose






    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,

        children: [

         if ( this.widget.title != null )
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child: Text( widget.title!, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold ),),
            ),

          const SizedBox( height: 5 ),
        
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.tv.length,
            itemBuilder: (_, int index) => _TvPoster(widget.tv[index], '${widget.title}-$index-${widget.tv[index].id}')
            ),
        )
        ],
      ),


    );
  }
}

class _TvPoster extends StatelessWidget {

 final Tv tv;
 final String heroId;

 const _TvPoster(this.tv, this.heroId);


  @override
  Widget build(BuildContext context) {
    
    tv.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        children: [

          GestureDetector(
           onTap: () => Navigator.pushNamed(context, 'tv_details', arguments: tv ),
            child: Hero(
              tag: tv.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage( tv.fullPosterImg ),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox( height: 5 ),

          Text( 
            tv.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )

        ],
      ),
    );
  }
}