class HomeRepositoryException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  HomeRepositoryException(this.message, [this.stackTrace]);
}
