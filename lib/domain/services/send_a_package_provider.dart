import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SendAPackageProvider extends ChangeNotifier {
  List<Package> packages = [Package()];

  appendNewDestination() {
    packages[0].destinations.add(DestinationDetailsModel());
    notifyListeners();
  }

  SendAPackageProvider(BuildContext context) {
    _getLocation();
  }

  Future<Position> _determinePosition() async {
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
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  _getLocation() async {
    Position pos = await _determinePosition();
    GetIt.I.get<Talker>().debug(pos);
    Placemark mark =
        (await placemarkFromCoordinates(pos.latitude, pos.longitude))[0];
    GetIt.I.get<Talker>().debug(mark.country);
    GetIt.I.get<Talker>().debug(mark.street);
    GetIt.I.get<Talker>().debug(mark.subAdministrativeArea);
    GetIt.I.get<Talker>().debug(mark.postalCode);
    notifyListeners();
  }
}

class Package {
  OriginDetailsModel origin = OriginDetailsModel();
  List<DestinationDetailsModel> destinations = [DestinationDetailsModel()];
  PackageDetailsModel package = PackageDetailsModel();
}

class OriginDetailsModel {
  String address = "";
  String stateCounty = "";
  String phone = "";
  String others = "";
}

class DestinationDetailsModel {
  String address = "";
  String stateCounty = "";
  String phone = "";
  String others = "";
}

class PackageDetailsModel {
  String packageItem = "";
  String weight = "";
  String worth = "";
}
