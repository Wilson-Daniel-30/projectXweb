import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectx/Screens/home/views/home_screen.dart';
import 'package:projectx/Screens/search/views/search_screen.dart';

import 'Screens/checkout/views/cart_screen.dart';
import 'constants.dart';


class EntryPoint extends StatefulWidget {
  final int initialIndex;
  const EntryPoint({super.key, this.initialIndex = 0}); // default = 0 (Home)

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final List _pages =  [
    HomeScreen(),
    // DiscoverScreen(),
    // BookmarkScreen(),
    // EmptyCartScreen(), // if Cart is empty
    CartScreen(),
    // ProfileScreen(),
  ];
  late int _currentIndex;

  @override
  void initState() {
  super.initState();

  _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      appBar: AppBar(
        // pinned: true,
        // floating: true,
        // snap: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white,Colors.white70,Colors.white60, Color(0xff0b2545)], // soft blue-white shades
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        leadingWidth: 0,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(left: 0),
          child: Row(
            children: [
              // Container(
              //   width: 25,
              //   height: 30,
              //   child: Image.asset('assets/flags/erasebg-transformed.png',),),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Transform(
                  transform: Matrix4.diagonal3Values(1.13, 1, 1.0), // stretch 1.2x width
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'O',
                    style: TextStyle(
                        fontFamily: 'HeliosExtended',
                        fontWeight: FontWeight.w500,
                        fontSize: 32
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 0),
                    child: Transform(
                      transform: Matrix4.diagonal3Values(1.13, 1, 1.0), // stretch 1.2x width
                      child: Text(
                        'liviya',
                        style: TextStyle(
                            fontFamily: 'HeliosExtended',
                            fontWeight: FontWeight.w700,
                            fontSize: 11
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 0),

                    child: Transform(
                      transform: Matrix4.diagonal3Values(1.13, 1, 1.0), // stretch 1.2x width
                      // alignment: Alignment.bottomRight,
                      child: Text(
                        'ccurance',
                        style: TextStyle(
                            fontFamily: 'HeliosExtended',
                            fontWeight: FontWeight.w400,
                            fontSize: 11
                        ),
                      ),
                    ),
                  )
                ],
              )
              ,
            ],
          )
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(left:defaultPadding,right:defaultPadding),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            icon: SvgPicture.asset(
              "assets/icons/Search.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, notificationsScreenRoute);
          //   },
          //   icon: SvgPicture.asset(
          //     "assets/icons/Notification.svg",
          //     height: 24,
          //     colorFilter: ColorFilter.mode(
          //         Theme.of(context).textTheme.bodyLarge!.color!,
          //         BlendMode.srcIn),
          //   ),
          // ),
        ],
      ),
      // body: _pages[_currentIndex],
      body: PageTransitionSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(

        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF101015),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          type: BottomNavigationBarType.fixed,
          // selectedLabelStyle: TextStyle(color: primaryColor),
          selectedFontSize: 12,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Shop.svg"),
              activeIcon: svgIcon("assets/icons/Shop.svg", color: primaryColor),
              label: "Shop",
            ),
            // BottomNavigationBarItem(
            //   icon: svgIcon("assets/icons/Category.svg"),
            //   activeIcon:
            //       svgIcon("assets/icons/Category.svg", color: primaryColor),
            //   label: "Discover",
            // ),
            // BottomNavigationBarItem(
            //   icon: svgIcon("assets/icons/Bookmark.svg"),
            //   activeIcon:
            //       svgIcon("assets/icons/Bookmark.svg", color: primaryColor),
            //   label: "Bookmark",
            // ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Bag.svg"),
              activeIcon: svgIcon("assets/icons/Bag.svg", color: primaryColor),
              label: "Cart",
            ),
            // BottomNavigationBarItem(
            //   icon: svgIcon("assets/icons/Profile.svg"),
            //   activeIcon:
            //       svgIcon("assets/icons/Profile.svg", color: primaryColor),
            //   label: "Profile",
            // ),
          ],
        ),
      ),
    );
  }
}
