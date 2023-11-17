class GeolocatorServiceException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  GeolocatorServiceException(this.message, [this.stackTrace]);
}
