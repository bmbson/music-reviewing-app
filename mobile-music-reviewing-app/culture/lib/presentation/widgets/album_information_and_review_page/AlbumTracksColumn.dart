import 'package:culture/models/GetAlbumInfoModels/TrackInfoModel.dart';
import 'package:culture/utils/FormatTime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlbumTracksColumn extends StatelessWidget {
  const AlbumTracksColumn({super.key, required this.trackList});

  final List<TrackInfo> trackList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          for (var track in trackList)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8),
                      child: Text(
                        "${track.trackPosition}",
                      ),
                    ),
                    Flexible(
                      child: Text(
                        track.trackName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 8),
                      child:
                          Text(formatedTime(timeInSecond: track.trackDuration)),
                    ),
                  ],
                ),
                const Divider()
              ],
            ),
        ],
      ),
    );
  }
}
