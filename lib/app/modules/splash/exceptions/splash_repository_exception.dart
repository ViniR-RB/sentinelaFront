class SplashRepositoryException implements Exception {
  final String message;
  final StackTrace? stack;
  SplashRepositoryException(this.message, [this.stack]);
}
