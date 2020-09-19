import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database.dart';
import 'favorite.dart';

class FavoriteIcon extends StatefulWidget {
  FavoriteIcon(this.productID);
  final int productID;
  @override
  State<StatefulWidget> createState() => _FavoriteIconState(productID);
}

class _FavoriteIconState extends State<FavoriteIcon> {
  final int productID;
  bool isFavorite;
  _FavoriteIconState(this.productID);
  final favoriteIcons = {
    false: Icon(Icons.favorite_border, color: Colors.red),
    true: Icon(Icons.favorite, color: Colors.red)
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: DBProvider.db.getFavorite(productID),
        builder: (context, snapshot) {
          snapshot.hasData ? isFavorite = true : isFavorite = false;
          return IconButton(
            icon: favoriteIcons[isFavorite],
            onPressed: () {
              isFavorite = !isFavorite;
              isFavorite
                  ? DBProvider.db.newFavorite(Favorite(productID))
                  : DBProvider.db.deleteFavorite(productID);
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
