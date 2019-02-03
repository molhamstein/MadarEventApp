import 'package:al_madar/NewsList.dart';
import 'package:al_madar/widgets/full_screen_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class PostDetails extends StatelessWidget {
  final Post post;

  const PostDetails({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(post.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
                background: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullScreenPicture(imageUrl: post.imageUrl,)));
                  },
                  child: Hero(
                    tag: FullScreenPicture.tag,
                    child: Image.network(
                      post.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: HtmlView(
          data: post.content,
        ),
      ),
    );
  }
}
