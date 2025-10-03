// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

void triggerDownload(Uri url, {String? fileName}) {
  final anchor = html.AnchorElement(href: url.toString())
    ..style.display = 'none'
    ..download = fileName ?? ''
    ..target = '_blank';

  html.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}
