import 'package:culture/models/GenreSearchModels/AlbumModel.dart';

class SearchResultsAlbums {
  final String page;
  final String searchTerm;
  final List<Album> searchResults;
  final String searchResultsAmount;

  const SearchResultsAlbums({
    required this.page,
    required this.searchTerm,
    required this.searchResults,
    required this.searchResultsAmount,
  });

  factory SearchResultsAlbums.fromJson(Map<String, dynamic> jsonData) {
    return SearchResultsAlbums(
      page: jsonData['results']['opensearch:Query']['startPage'],
      searchTerm: jsonData['results']['opensearch:Query']['searchTerms'],
      searchResults: jsonData['results']['albummatches']['album'],
      searchResultsAmount: jsonData['results']['opensearch:totalResults'],
    );
  }
}
