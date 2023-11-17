import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../exceptions/geolocator_service_exception.dart';

class GeolocatorService {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw GeolocatorServiceException('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw GeolocatorServiceException(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Location> determinePositionByAddress(String address) async {
    List<Location?> locations = await locationFromAddress(address);
    if (locations.first == null) {
      throw GeolocatorServiceException(
          "Endereço está errado pois não representa nenhuma localização conhecida");
    }
    return locations.first!;
  }
}
