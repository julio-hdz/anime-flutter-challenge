
String animeQueryByIdString = """
  query getAnimeById(\$id: Int) {
    	Media(id: \$id ){
        title{
          native
          english
          userPreferred
        }
        type
        status
        description
        seasonYear
        format
        coverImage{
          extraLarge
          color
        }
        bannerImage
        averageScore
      }
  }
""";

String animeQueryString = """
  query getAnimes(\$page: Int, \$itemsPerPage: Int) {
    Page(page: \$page, perPage: \$itemsPerPage) {
      media(sort: POPULARITY_DESC) {
        id
        format
        seasonYear
        title {
          userPreferred
        }
        coverImage{
          medium
        }
      }
    }
  }
""";