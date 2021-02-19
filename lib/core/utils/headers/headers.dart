abstract class Headers {
  Map<String, String> get applicationJsonContentType;
}

class AppHeaders implements Headers {
  final applicationJsonContentType = _contentTypeAppend('application/json');

  static Map<String, String> _contentTypeAppend(String type) {
    return {
      'Content-Type': type,
    };
  }
}
