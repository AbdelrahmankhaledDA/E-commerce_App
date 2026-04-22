import 'dart:async';

import 'package:e_commerceapp/core/routing/router_generation_config.dart';
import 'package:e_commerceapp/core/styling/AppColors.dart';
import 'package:e_commerceapp/core/widgets/PrimayButtonWidget.dart';
import 'package:e_commerceapp/features/maps/data/repo/location.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  LatLng currentLoctiion = LatLng(30.033333, 31.233334);
  CameraPosition intialCameraPostion = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 16,
  );
  Set<Marker> Markers = {
    Marker(markerId: MarkerId("1"), position: LatLng(30.033333, 31.233334)),
  };
  getCurrentLoaction() async {
    final getpostion = await Location().determinePosition();
    setState(() {
      currentLoctiion = LatLng(getpostion.latitude, getpostion.longitude);
      // i need to convert this current loction to string by geacoding (string )

      Markers = {Marker(markerId: MarkerId("1"), position: currentLoctiion)};
    });
    MoveToPostion(currentLoctiion);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLoaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Markers,
            mapType: MapType.normal,
            initialCameraPosition: intialCameraPostion,
          ),
          Positioned(
            bottom: 50,
            child: Container(child: Text("currentLoction by text ")),
          ),
          Positioned(
            bottom: 100, // المسافة من أسفل الشاشة
            left: 20, // المسافة من اليسار
            right: 20, // المسافة من اليمين (عشان يمتد الزرار بالعرض)
            child: PrimayButtonWidget(
              textColor: AppColors.blackColor,
              buttonColor: const Color(0x802196F3),
              buttonText: "Confirm Location",
              onPress: () {
                GoRouter.of(context).push(RouterGeneration.home);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> MoveToPostion(LatLng loction) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: loction, zoom: 16)),
    );
  }
}
