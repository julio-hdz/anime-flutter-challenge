import 'package:flutter/material.dart';
import 'package:ivoy_challenge_jchj/src/homepage/home_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final HttpLink httpLink = HttpLink('https://graphql.anilist.co');

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore())
      )
    );
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Anime listing app',
        home: const HomePage(),
      ),
    );
  }
}
