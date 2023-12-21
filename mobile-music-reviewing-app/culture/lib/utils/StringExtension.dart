extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension StringExtensionAll on String {
  String capitalizeAfterSpacesAndDashes() {
    return replaceAllMapped(
      RegExp(r'(?<= |-|^).'),
      (match) => match[0]!.toUpperCase(),
    );
  }
}
