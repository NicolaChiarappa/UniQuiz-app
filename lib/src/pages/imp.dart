import 'package:flutter/material.dart';
import '../../auth.dart';

class ImpPage extends StatelessWidget {
  const ImpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (ListView(
      scrollDirection: Axis.vertical,
      children: [
        Column(children: [
          ElevatedButton(
              onPressed: () {
                Auth().signOut();
              },
              child: const Text('Logout')),
          SizedBox(
            height: width * 0.05,
          ),
          CircleAvatar(
              radius: 60,
              backgroundColor: Colors.deepPurpleAccent,
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/3586798/pexels-photo-3586798.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')),
          SizedBox(
            height: width * 0.02,
          ),
          Text(
            Auth().getDisplayName(),
            style:
                TextStyle(fontSize: width * 0.09, fontWeight: FontWeight.bold),
          )
        ])
      ],
    ));
  }
}
