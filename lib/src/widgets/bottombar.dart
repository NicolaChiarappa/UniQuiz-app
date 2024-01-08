/*import 'package:flutter/material.dart';
import '../pages/esami.dart';
import '../pages/home.dart';
import '../pages/imp.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  final selected = {
    'home': true,
    'esami': false,
    'imp': false,
  };

  @override
  Widget build(BuildContext context) {
    return (Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff4338CA), Color(0xff6D28D9)])),
        child: BottomNavigationBar(
          elevation: 10,
          destinations:[]
          child: SizedBox(
              height: 60,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Bottombutton(
                          testo: 'Home',
                          icona: Icons.home_filled,
                          isSelected: selected['home']!,
                          onPressed: () {
                            setState(() {
                              selected['home'] = true;
                              selected['esami'] = false;
                              selected['imp'] = false;
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Myhome(),
                              ),
                            );
                          }),
                      Bottombutton(
                        testo: 'Esami',
                        icona: Icons.book_rounded,
                        onPressed: () {
                          setState(() {
                            selected['home'] = false;
                            selected['esami'] = true;
                            selected['imp'] = false;
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const EsamiPage(),
                            ),
                          );
                        },
                        isSelected: selected['esami']!,
                      ),
                      Bottombutton(
                        testo: 'Impost.',
                        icona: Icons.settings,
                        isSelected: selected['imp']!,
                        onPressed: () {
                          setState(() {
                            selected['home'] = false;
                            selected['esami'] = false;
                            selected['imp'] = true;
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ImpPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ))),
        )));
  }
}

class Bottombutton extends StatelessWidget {
  final String testo;
  final IconData icona;
  final VoidCallback onPressed;
  final bool isSelected;

  const Bottombutton(
      {required this.testo,
      required this.icona,
      required this.onPressed,
      required this.isSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: SizedBox(
            width: 100,
            child: FilledButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(isSelected == true
                      ? Colors.lightBlueAccent
                      : Colors.blueAccent)),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icona,
                    size: 17,
                  ),
                  Text(testo),
                ],
              ),
            )));
  }
}

import 'package:flutter/material.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Commute',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}*/
