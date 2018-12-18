import 'package:al_madar/network.dart';
import 'package:al_madar/post_details.dart';
import 'package:al_madar/widgets/Ticket.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  @override
  NewsScreenState createState() {
    return new NewsScreenState();
  }
}

class NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin<NewsScreen> {
  List<Widget> news = [];

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return news[index];
          },
          itemCount: news.length,
          padding: EdgeInsets.only(top: 8, bottom: 8),
        ),
      ),
    );
  }

  getNews() {
    Network.getNews().then((newsList) {
      setState(() {
        news = newsList.posts.map((post) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetails(post: post),
                ),
              );
            },
            child: Ticket(post: post),
          );
        }).toList();
      });
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
