import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_favorite_places/places/place_detail_screen.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import 'my_fav_places.dart';

class PlacesListScreen extends StatefulWidget {
  static const routeName = '/places-list-screen';

  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.flight),
            SizedBox(width: 10),
            Text('JourneyJar'),
          ],
        ),
      ),
      body: FutureBuilder(
        future:
            Provider.of<MyFavoritePlaces>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<MyFavoritePlaces>(
                child: Center(
                  child: TextButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, AddPlaceScreen.routeName),
                    icon: const Icon(LineIcons.camera),
                    label: const Text('Add your first place'),
                  ),
                ),
                builder: (ctx, myFavPlaces, ch) => myFavPlaces.items.isEmpty
                    ? ch!
                    : GridView.count(
                        childAspectRatio: 3 / 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 10,
                        padding: const EdgeInsets.all(10),
                        crossAxisCount: 2,
                        children: List.generate(myFavPlaces.items.length, (i) {
                          return AnimationConfiguration.staggeredGrid(
                            position: i,
                            columnCount: 3,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: GridTile(
                                  footer: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      myFavPlaces.items[i].placeName,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  child: Hero(
                                    flightShuttleBuilder: (
                                      flightContext,
                                      animation,
                                      flightDirection,
                                      fromHeroContext,
                                      toHeroContext,
                                    ) {
                                      return Image.file(
                                        myFavPlaces.items[i].image,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    tag: myFavPlaces.items[i].id,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          PlaceDetailScreen.routeName,
                                          arguments: myFavPlaces.items[i].id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        child: Image.file(
                                          myFavPlaces.items[i].image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
              ),
      ),
    );
  }
}
