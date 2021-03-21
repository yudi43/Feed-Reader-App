import 'package:demoapp/models/article.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleArticleDetail extends StatefulWidget {
  final Article article;
  SingleArticleDetail({this.article});
  @override
  _SingleArticleDetailState createState() => _SingleArticleDetailState();
}

class _SingleArticleDetailState extends State<SingleArticleDetail> {
  void _launchURL() async => await canLaunch(widget.article.url)
      ? await launch(widget.article.url)
      : throw 'Could not launch ${widget.article.url}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.article.title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: widget.article.urlToImage != null
                  ? Image.network(
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
                    )
                  : Container(),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.article.description == null
                  ? Text("No Description available.")
                  : Text(
                      widget.article.description,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Merriweather-content"),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.article.content == null
                  ? Text("No content available.")
                  : Text(
                      widget.article.content,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Merriweather-content"),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: _launchURL,
                child: Text('Read the full Article here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
