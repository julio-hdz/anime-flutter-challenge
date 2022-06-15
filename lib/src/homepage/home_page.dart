import 'package:flutter/material.dart';
import 'package:ivoy_challenge_jchj/src/animelist/anime_list_page.dart';
import 'package:ivoy_challenge_jchj/src/misc/navigator_utils.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('iVoy Challenge'),
            backgroundColor: Colors.blueGrey[900],
            foregroundColor: Colors.amber[700],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
            Image.asset('assets/landing.png',fit: BoxFit.fill),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom( primary: Colors.amber[700]),
                onPressed: () => NavigatorUtils.navigateTo(context, AnimeListPage()),
                child: const Text('ir al listado de animes populares'),
              ),
            ),
            ],
          ),
        ));
  }
}
