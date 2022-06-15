import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ivoy_challenge_jchj/src/Query/query_strings.dart';

class DetailsPage extends StatelessWidget {
  final int animeId;
  final String animeTitle;
  DetailsPage({Key? key, required this.animeId, required this.animeTitle})
      : super(key: key);
  final _pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(animeTitle),
              backgroundColor: Colors.blueGrey[900],
              foregroundColor: Colors.amber[700],
            ),
            body: Query(
                options: QueryOptions(
                    document: gql(animeQueryByIdString),
                    variables: {'id': animeId}),
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
                  var info = result.data!['Media'];
                  return PageView(
                    controller: _pagecontroller,
                    children: [_frontPage(info), _moreDetailsPage(info)],
                  );
                })));
  }
  Widget _frontPage(info) {
    final english = info['title']['english'];
    final native = info['title']['native'];
    final common = info['title']['userPreferred'];
    final year = info['seasonYear'].toString();
    final status = info['status'];
    final type = info['type'];
    final format = info['format'];

    return Container(
      color: Colors.black,
      child: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Container(
                height: 460,
                width: 630,
                child: Image.network(
                  info['coverImage']['extraLarge'],
                  fit: BoxFit.fill,
                ),
              )),
          _styledFrontPageText(english),
          _styledFrontPageText(native),
          _styledFrontPageText(common),
          _styledFrontPageText(year),
          _styledFrontPageText(status, label: 'status'),
          _styledFrontPageText(type, label: 'tipo'),
          _styledFrontPageText(format, label: 'formato'),
        ],
      ),
    );
  }

  Widget _moreDetailsPage(info) {
    final avgScore = info['averageScore'].toString();
    final description = info['description']
        .toString()
        .replaceAll('<br>', '')
        .replaceAll('<i>', '')
        .replaceAll('</i>', '');
    final banner = info['bannerImage'];

    return Container(
        color: Colors.black,
        child: ListView(
          children: [
            const Icon(
              Icons.star,
              size: 48,
              color: Colors.amber,
            ),
            Text(
              '$avgScore/100',
              style: const TextStyle(
                color: Colors.white,
                letterSpacing: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Text(
              'Plot',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
                height: 100,
                width: double.infinity,
                child: Image.network(
                  banner,
                  fit: BoxFit.fill,
                )),
            const SizedBox(
              height: 25,
            )
          ],
        ));
  }

  _styledFrontPageText(text, {String? label}) {
    return Center(
      child: Text(
        label == null ? text : label + ': ' + text,
        style: const TextStyle(color: Colors.white, letterSpacing: 1.2),
      ),
    );
  }
}
