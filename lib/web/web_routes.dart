const String kShopRoute = '/';
const String kProductRoutePrefix = '/product';

/// Lowercase the title, strip punctuation, and hyphenate remaining words.
String productSlugFromTitle(String title) {
  final lower = title.toLowerCase();
  final withoutPunctuation = lower.replaceAll(RegExp(r"[^a-z0-9\s-]"), '');
  return withoutPunctuation
      .trim()
      .replaceAll(RegExp(r'[\s-]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
}

String productPathFromTitle(String title) =>
    '$kProductRoutePrefix/${productSlugFromTitle(title)}';

String? productSlugFromPath(String? path) {
  if (path == null || path.isEmpty) return null;
  var cleaned = path.split('#').last;
  cleaned = cleaned.split('?').first;
  final segments =
      cleaned.split('/').where((segment) => segment.isNotEmpty).toList();
  if (segments.length >= 2 && segments.first == 'product') {
    return Uri.decodeComponent(segments[1]);
  }
  return null;
}

bool isProductPath(String? path) => productSlugFromPath(path) != null;
