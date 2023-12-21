import 'package:culture/models/GetAlbumInfoModels/AlbumInfoModel.dart';
import 'package:culture/utils/StringExtension.dart';
import 'package:flutter/material.dart';

class AlbumInfoColumn extends StatelessWidget {
  const AlbumInfoColumn(
      {super.key,
      this.Artist,
      this.Type,
      this.Release,
      this.Rating,
      this.Genre,
      this.Mood});

  final String? Artist;
  final List<Tag>? Type;
  final String? Release;
  final String? Rating;
  final String? Genre;
  final String? Mood;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 300,
        child: Table(
          textBaseline: TextBaseline.alphabetic,
          children: [
            TableRow(children: [
              const TableCell(
                  child: Text(
                "Artist:",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              TableCell(child: Text(Artist ?? 'Not Available')),
            ]),
            TableRow(children: [
              const TableCell(
                  child: Text(
                'Tags:',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              TableCell(
                child: Wrap(children: [
                  if (Type != null)
                    for (var tag in Type!)
                      Text(
                          "${'${tag.tagName.capitalizeAfterSpacesAndDashes()},'} ")
                ]),
              ),
            ]),
            const TableRow(children: [
              TableCell(
                  child: Text(
                'Rating:',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              TableCell(child: Text('')),
            ]),
            TableRow(children: [
              const TableCell(
                  child: Text(
                "Date:",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              TableCell(child: Text(Release ?? 'Not Available')),
            ]),
          ],
        ),
      ),
    );
  }
}
