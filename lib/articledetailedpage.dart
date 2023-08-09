import 'package:flutter/material.dart';

import 'class/newsclass.dart';

class ArticleDetailedPage extends StatelessWidget {
  Articles articles;
  ArticleDetailedPage({required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text(
          articles.title as String,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(articles.urlToImage == null
                          ? 'https://www.dcm.co.za/wp-content/uploads/2019/11/placeholder-image-icon-21.jpg'
                          : articles.urlToImage as String))),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.red),
                                        child: Text(
                                          "${articles.source?.name.toString()}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Author: ${ articles.author} " as String,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
             Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Useful link: ${ articles.url} " as String,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),),
            SizedBox(height: 10,),
            Container(
               margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                articles.description as String,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
