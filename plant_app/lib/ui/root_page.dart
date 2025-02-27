import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/ui/screens/cart_page.dart';
import 'package:plant_app/ui/screens/favorite_page.dart';
import 'package:plant_app/ui/screens/home_page.dart';
import 'package:plant_app/ui/screens/profile_page.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/ui/login_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_app/ui/screens/scan_page.dart';
import 'package:plant_app/models/plants.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int _bottomNavIndex = 0;

  List<Plant> favorites = [];
  List<Plant> myCart = [];

  //List of the pages
  List<Widget> _widgetOptions(){
    return [
    const HomePage(),
    FavoritePage(favoritedPlants: favorites),
    CartPage(addedToCartPlants: myCart),
    const ProfilePage(),
    ];
  }

  //List of the icons
  List<IconData> iconList = const [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  //List of the titles page
  List<String> titleList = const [
    "Home",
    "Favorite",
    "Cart",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titleList[_bottomNavIndex],
              style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Icon(
              Icons.notifications,
              color: Constants.blackColor,
              size: 30.0,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, 
            PageTransition(
              type: PageTransitionType.bottomToTop, 
              child: const ScanPage()
            )
          );
        },
        child: Image.asset("assets/images/code-scan-two.png", height: 30,),
        backgroundColor: Constants.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        activeColor: Constants.primaryColor,
        splashColor: Constants.primaryColor,
        inactiveColor: Constants.blackColor.withOpacity(.5),
        onTap: (index){
          setState(() {
            _bottomNavIndex = index;
            final List<Plant> favoritePlants = Plant.getFavoritedPlants();
            final List<Plant> addedToCartPlants = Plant.addedToCartPlants();

            favorites = favoritePlants;
            myCart = addedToCartPlants.toSet().toList();
          });
        }
      )
    );
  }
}