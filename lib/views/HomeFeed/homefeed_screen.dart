import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/views/AddPost/addpost_screen.dart';
import 'package:instagram_clone/views/HomeFeed/feed_body.dart';
import 'package:instagram_clone/views/NotificationScreen/notif_screen.dart';
import 'package:instagram_clone/views/ProfileScreen/profile_screen.dart';
import 'package:instagram_clone/views/SearchScreen/search_screen.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({Key? key}) : super(key: key);

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  List<Widget> screenItems = [
     FeedBodyScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: mobileBackgroundColor,
      body: screenItems[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: mobileBackgroundColor,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: (_currentIndex == 0) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: (_currentIndex == 1) ? primaryColor : secondaryColor,
                ),
                label: '',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle,
                  color: (_currentIndex == 2) ? primaryColor : secondaryColor,
                ),
                label: '',
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: (_currentIndex == 3) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: (_currentIndex == 4) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
          ]),
    );
  }
}
