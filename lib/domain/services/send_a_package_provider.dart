import 'package:flutter/material.dart';

class SendAPackageProvider extends ChangeNotifier {
  List<Package> packages = [Package()];

  appendNewDestination() {
    packages[0].destinations.add(DestinationDetailsModel());
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
