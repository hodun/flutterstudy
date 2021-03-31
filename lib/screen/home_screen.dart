import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterstudy/model/model_movie.dart';
import 'package:flutterstudy/widget/box_slider.dart';
import 'package:flutterstudy/widget/carousel_slider.dart';
import 'package:flutterstudy/widget/circle_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreeen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreeen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> streamData;
  //Firestore fireStore = Firestore.instance

  @override
  void initState() {
    super.initState();
    streamData = firestore.collection('movie').snapshots();
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        CircleSlider(movies: movies),
        BoxSlider(movies: movies),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        children: <Widget>[
          Image.asset(
            'images/bbongflix_logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
