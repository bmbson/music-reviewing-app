class Album {
  final String albumName;
  final String artistName;
  final String albumImageUrl;

  const Album({
    required this.albumName,
    required this.artistName,
    required this.albumImageUrl,
  });

  factory Album.fromJson(Map<String, dynamic> jsonData) {
    return Album(
      albumName: jsonData['name'],
      artistName: jsonData['artist']['name'],
      albumImageUrl: jsonData['image'][3]['#text'],
    );
  }
}
