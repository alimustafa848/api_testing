import 'dart:convert';

import 'package:apitestingproject/articledetailedpage.dart';
import 'package:apitestingproject/class/newsclass.dart';
import 'package:apitestingproject/class/newsclass.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'class/newsclass.dart';
import 'class/newsclass.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

// List<Posts> postslist = [];

class _NewsState extends State<News> {
  List<Articles> articles = [];

  Future refreshlist() async {
    await Future.delayed(Duration(seconds: 2));
    await fetchdata();
    print('refresh ho rha hai');
    setState(() {});
  }

  Future fetchdata() async {
    Response response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3c92390d38fb415594831f37470927c6"));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> body = data['articles'];
      for (Map i in body) {
        articles.add(Articles.fromJson(i));
      }
      return articles;
    } else {
      throw ("can't find articles");
    }
  }
  // Future<List<Posts>> fetchdata() async {
  //   Response response =
  //       await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  //   if (response.statusCode == 200) {
  //     var mydata = jsonDecode(response.body);

  //     for (Map i in mydata) {
  //       postslist.add(Posts.fromJson(i));
  //     }
  //      print(postslist);
  //     return postslist;
  //     // print(response.body);
  //     // for (Map i in data1) {
  //     //   articles.add(Newsapi.fromJson(i));

  //     // }
  //   } else {
  //     return postslist;
  //   }
  // }

  @override
  void initState() {
    // fetchdata();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "News App",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body:
            // ElevatedButton(
            //     onPressed: () {
            //       fetchdata();
            //     },
            //     child: Text("Press me"))
            FutureBuilder(
                future: fetchdata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await refreshlist();
                        },
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: articles.length,
                            itemBuilder: ((context, i) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ArticleDetailedPage(
                                                articles: snapshot.data[i],
                                              )));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  color: Colors.white,
                                  elevation: 8,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  // height: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(snapshot
                                                              .data[i]
                                                              .urlToImage ==
                                                          null
                                                      ? 'https://www.dcm.co.za/wp-content/uploads/2019/11/placeholder-image-icon-21.jpg'
                                                      : snapshot.data[i]
                                                          .urlToImage))),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.red),
                                          child: Text(
                                            snapshot.data[i].source.name,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data[i].title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //   Text(
                                        //  " UserId : ${ snapshot.data![i].userId.toString()}",
                                        //     style: TextStyle(color: Colors.red),
                                        //   ),
                                        //   Text(
                                        //    " Title : ${ snapshot.data![i].title.toString()}",
                                        //     style: TextStyle(color: Colors.red),
                                        //   ),
                                        //   Text(
                                        //    " Body : ${ snapshot.data![i].body.toString()}",
                                        //     style: TextStyle(color: Colors.black,fontSize: 20),
                                        //   ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Sorry data can't be found"));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }));
  }
}
