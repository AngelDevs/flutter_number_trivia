class NumbersEndPoints {
  final url = 'http://numbersapi.com';

  String concreteNumberTrivia(number) {
    return '$url/$number';
  }

  String randomNumberTrivia() {
    return '$url/random';
  }
}
