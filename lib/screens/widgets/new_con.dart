import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Row(
              children: <Widget>[
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_left,
                      size: 20,
                      color: Colors.black,
                    )),
                SizedBox(width: 5.0),
                Text(
                  "View Post",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26.withOpacity(0.05),
                      offset: Offset(0.0, 6.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.10)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 60,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/m.png"),
                              radius: 22,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Monishwaran",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .4),
                                    ),
                                  ),
                                  SizedBox(height: 2.0),
                                  Text(
                                    "widget.question.created_at",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.bookmark,
                          color: Colors.grey.withOpacity(0.6),
                          size: 26,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "How to install flutter",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    " widget.question.content widget.question.content  widget.question.content  widget.question.content  widget.question.content widget.question.content  widget.question.content  widget.question.content",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 17,
                        letterSpacing: .2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.thumb_up,
                              color: Colors.grey.withOpacity(0.5),
                              size: 22,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              "votes",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 15.0),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey.withOpacity(0.5),
                              size: 18,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              "views",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.5),
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
            child: Text(
              "Replies",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Column(children: [
            Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.03),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 60,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage("assets/m.png"),
                                  radius: 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "reply.author.name",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: .4),
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        " widget.question.created_at",
                                        style: TextStyle(
                                            color:
                                                Colors.grey.withOpacity(0.4)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          "  reply.content",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.25),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.thumb_up,
                            color: Colors.grey.withOpacity(0.5),
                            size: 20,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            "{reply.likes}",
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.5)),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ])
        ]),
      ),
    );
  }
}
