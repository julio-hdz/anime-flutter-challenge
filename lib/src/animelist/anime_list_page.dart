import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ivoy_challenge_jchj/src/Query/query_strings.dart';
import 'package:ivoy_challenge_jchj/src/animelist/details_page.dart';
import 'package:ivoy_challenge_jchj/src/misc/navigator_utils.dart';

class AnimeListPage extends StatelessWidget {
  const AnimeListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.amber[700],
        title: const Text('Listado de Animes'),
      ),
      body: Query(
          options: QueryOptions(
              document: gql(animeQueryString),
              variables: const {'page': 1, 'itemsPerPage': 20}),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List animes = result.data!['Page']['media'];
            return ListView.builder(
                itemCount: animes.length,
                itemBuilder: (context, index) {
                  final id = animes[index]['id'];
                  final title = animes[index]['title']['userPreferred'];
                  final cover = animes[index]['coverImage']['medium'];
                  final year = animes[index]['seasonYear'].toString();
                  final format =
                      animes[index]['format'].toString().toUpperCase();
                 return ListTile(
                    tileColor: Colors.black,
                    textColor: Colors.teal,
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    visualDensity: VisualDensity(vertical: 4),
                    dense: false,
                    subtitle: Text(format),
                    title: Text(title + ' ($year)'),
                    leading: Container(
                        height: 65, width: 65, child: Image.network(cover)),
                    onTap: ()=>NavigatorUtils.navigateTo(context, DetailsPage(animeId: id, animeTitle: title,)),
                  );
                });
          }),
    ));
  }
}
