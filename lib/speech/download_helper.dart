import 'download_helper_stub.dart'
    if (dart.library.html) 'download_helper_web.dart'
    as impl;

class DownloadHelper {
  const DownloadHelper._();

  static void trigger(Uri url, {String? fileName}) {
    impl.triggerDownload(url, fileName: fileName);
  }
}
