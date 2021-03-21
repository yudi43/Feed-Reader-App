import 'package:demoapp/components/singleArticleDetail.dart';
import 'package:demoapp/models/article.dart';
import 'package:flutter/material.dart';

class SingleArticleTile extends StatefulWidget {
  final Article article;
  SingleArticleTile({this.article});
  @override
  _SingleArticleTileState createState() => _SingleArticleTileState();
}

class _SingleArticleTileState extends State<SingleArticleTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SingleArticleDetail(article: widget.article)));
        },
        child: Card(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    widget.article.urlToImage,
                    fit: BoxFit.fill,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      print(exception);
                      print(stackTrace);
                      return Container(
                        child: Image.network(
                          "https://www.allianceplast.com/wp-content/uploads/2017/11/no-image.png",
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.article.title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather-title"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.article.publishedAt,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Merriweather-title"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
