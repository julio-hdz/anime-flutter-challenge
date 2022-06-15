import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AnimeListPage extends StatelessWidget {
  const AnimeListPage({Key? key}) : super(key: key);
  final String animeQueryString = """
  query getAnimes(\$page: Int, \$itemsPerPage: Int) {
    Page(page: \$page, perPage: \$itemsPerPage) {
      media {
        id
        title {
          userPreferred
        }
        status
        genres
        description
        coverImage{
          medium
        }
      }
    }
  }
""";

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
          options: QueryOptions(document: gql(animeQueryString), variables: const {
            'page': 1,
            'itemsPerPage':8
          }),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }
            List animes = result.data!['Page']['media'];
            return ListView.builder(
                itemCount: animes.length,
                itemBuilder: (context, index){
                  final title = animes[index]['title']['userPreferred'];
                  final cover = animes[index]['coverImage']['medium'];
                 return ListTile(
                   tileColor: Colors.black,
                   textColor: Colors.teal,
                   contentPadding: EdgeInsets.symmetric(vertical: 5),
                   visualDensity: VisualDensity(vertical: 4),
                   title: Text(title),
                   leading: Container(
                        height: 65,
                       width: 65,
                       child: Image.network(cover)),
                 );
                }
            );


          }),
    ));
  }
}
