import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Pick one of the choices below to call free APIs',
            ),
            SizedBox(height: 30),
            CustomListTile(
              title: 'All Posts',
              leading: 'GET',
              color: Colors.green,
              onTap: null,
            ),
            CustomListTile(
              title: 'Post with Id',
              leading: 'GET',
              color: Colors.green,
              onTap: null,
            ),
            CustomListTile(
              title: 'Comments for Post with Id (1)',
              leading: 'GET',
              color: Colors.green,
              onTap: null,
            ),
            CustomListTile(
              title: 'Comments for Post with Id (2)',
              leading: 'GET',
              color: Colors.green,
              onTap: null,
            ),
            CustomListTile(
              title: 'User Login',
              leading: 'POST',
              color: Colors.amber,
              onTap: null,
            ),
            CustomListTile(
              title: 'Payment gateway (Chargily)',
              leading: 'POST',
              color: Colors.amber,
              onTap: null,
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.leading,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String leading;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(
                minHeight: 40,
                minWidth: 70,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                leading,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
