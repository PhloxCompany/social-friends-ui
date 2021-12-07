import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:phlox_animations/phlox_animations.dart';
import 'package:social_friends_ui/post_model.dart';

const primaryDarkColor = Color(0xff191926); //  radius 24
const primaryColor = Color(0xFF36364E);
const accentColor = Color(0xff03c4ff);
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
List<PostModel> listPosts = [
  PostModel(
      imageUrl: 'assets/images/image1.jpg',
      userName: 'Babak',
      isFollowed: false),
  PostModel(
      imageUrl: 'assets/images/image2.jpg',
      userName: 'Yoshi',
      isFollowed: true),
  PostModel(
      imageUrl: 'assets/images/image3.jpg',
      userName: 'Eliana',
      isFollowed: false),
];

class _HomePageState extends State<HomePage> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            PhloxAnimations(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 100),
              fromOpacity: 0,
              fromY: -30,
              child: const Padding(
                padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Text(
                  "Discover",
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PhloxAnimations(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 300),
                  fromOpacity: 0,
                  fromY: -30,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("add new friend"),
                  ),
                ),
                PhloxAnimations(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 400),
                  fromOpacity: 0,
                  fromY: -30,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.notifications)),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemBuilder: (context, index) => PhloxAnimations(
                    duration: const Duration(milliseconds: 600),
                    delay: Duration(milliseconds: 300 * (index + 1)),
                    fromOpacity: 0,
                    fromY: -30,
                    child: itemTab(index)),
                itemCount: 4,
                scrollDirection: Axis.horizontal,
              ),
            ),
            ListView.builder(
              itemBuilder: (context, index) => PhloxAnimations(
                  duration: const Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 600 * (index + 2)),
                  fromOpacity: 0,
                  fromY: -30,
                  child: itemPosts(listPosts[index])),
              itemCount: listPosts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            )
          ],
        ),
      ),
    );
  }

  Widget itemTab(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: currentTabIndex == index ? Color(0xff1e2139) : null,
        onPressed: () => setState(() {
          currentTabIndex = index;
        }),
        child: Text(
          "Tab $index",
          style: TextStyle(
              fontWeight: currentTabIndex == index ? FontWeight.bold : null,
              fontSize: currentTabIndex == index ? 16 : 14),
        ),
      ),
    );
  }

  Widget itemPosts(PostModel postModel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Color(0xff1e2139),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Image.asset(postModel.imageUrl ?? ""),
          ),
          ListTile(
            // user profile
            leading: Card(
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                'assets/images/image1.jpg',
                fit: BoxFit.cover,
                height: 40,
              ),
            ),
            // user name
            title: Text(
              postModel.userName ?? "Guest user",
              style: TextStyle(fontSize: 18),
            ),
            trailing: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              onPressed: () => setState(() {
                postModel.isFollowed = !postModel.isFollowed!;
              }),
              color: postModel.isFollowed!
                  ? const Color(0xff314350)
                  : Color(0xff03c4ff),
              child: Text(postModel.isFollowed! ? "Followed" : "Follow"),
            ),
          )
        ],
      ),
    );
  }
}
