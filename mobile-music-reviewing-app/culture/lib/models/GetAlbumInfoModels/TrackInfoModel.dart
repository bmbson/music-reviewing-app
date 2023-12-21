class TrackInfo {
  final String trackName;
  final int trackDuration;
  final int trackPosition;

  const TrackInfo({
    required this.trackName,
    required this.trackDuration,
    required this.trackPosition,
  });

  factory TrackInfo.fromJson(Map<String, dynamic> jsonData) {
    return TrackInfo(
      trackName: jsonData['name'],
      trackDuration: jsonData['duration'],
      trackPosition: jsonData['@attr']['rank'],
    );
  }
}
