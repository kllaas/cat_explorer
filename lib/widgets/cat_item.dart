import 'package:flutter/material.dart';
import 'package:catexplorer/models/cat.dart';
import 'package:google_fonts/google_fonts.dart';

class CatItem extends StatelessWidget {
  const CatItem({Key key, this.cat}) : super(key: key);

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).cardTheme.color,
        child: Column(
          children: [
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(cat.name, style: GoogleFonts.exo2(textStyle: Theme.of(context).textTheme.headline5)),
                ],
              ),
            ),
            new Container(
                child: AspectRatio(
                    aspectRatio: cat.imageWidth / cat.imageHeight,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.scaleDown,
                      placeholder: 'assets/placeholder.gif',
                      image: cat.imageUrl,
                    ))),
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cat.description, style: GoogleFonts.exo(textStyle: Theme.of(context).textTheme.caption)),
                ],
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }
}
