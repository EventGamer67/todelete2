import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:todelete2/presentation/screens/screens/send_a_package_receipt.dart';
import 'package:todelete2/presentation/screens/screens/transaction_screen.dart';

class SendAPackageProvider extends ChangeNotifier {
  TextEditingController address = TextEditingController();
  TextEditingController country = TextEditingController();

  goToReceipt(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => const SendAPackageReceiptScreen()));
  }

  goToTransaction(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const TransactionScreen()));
  }

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
    address.text = "${mark.street} ${mark.name}";
    country.text = "${mark.country}";
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
