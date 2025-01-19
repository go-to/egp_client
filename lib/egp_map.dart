import 'dart:async';

import 'package:egp_client/grpc_gen/egp.pb.dart';
import 'package:egp_client/src/shop_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'app_constants.dart';
import 'package:egp_client/grpc_egp_service.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class EgpMap extends StatefulWidget {
  const EgpMap({super.key});

  @override
  State<EgpMap> createState() => EgpMapState();
}

class EgpMapState extends State<EgpMap> {
  Map<String, Marker> defaultMarkers = {};
  Map<String, Marker> markers = {};

  initMarkers() async {
    // 店舗情報を取得
    final channel = GrpcEgpService.getChannel();
    ShopsResponse? shops;
    try {
      shops = await GrpcEgpService.getShops();
    } catch (e) {
      print('Caught error: $e');
    } finally {
      channel.shutdown();
    }

    var latLonList = [];
    for (final shop in shops!.shops) {
      var latitude = shop.latitude;
      var longitude = shop.longitude;
      var latLon = latitude.toString() + longitude.toString();
      // 緯度経度が同じ場合は、重なり防止のためにマーカーの位置をずらす
      if (latLonList.contains(latLon)) {
        latitude = latitude + AppConstants.latitudeAdjustValue;
        longitude = longitude + AppConstants.longitudeAdjustValue;
        latLon = latitude.toString() + longitude.toString();
      }
      latLonList.add(latLon);

      var marker = Marker(
        markerId: MarkerId(shop.iD.toString()),
        position: LatLng(latitude, longitude),
        onTap: () async => {
          // 店舗情報を更新
          _onMapCreated(_controller),
          // タップした店舗のマーカーを変更
          defaultMarkers[shop.iD.toString()] = Marker(
            markerId: MarkerId(shop.iD.toString()),
            position: LatLng(latitude, longitude),
            icon: await ShopMarker(
              shopName: '${shop.no}: ${shop.shopName}',
              inCurrentSales: shop.inCurrentSales,
            ).toBitmapDescriptor(
                logicalSize: const Size(150, 150),
                imageSize: const Size(300, 400)),
          ),
          defaultMarkers.values.toSet(),
          setState(() {}),
        },
        // 営業時間中か否かによって表示するアイコンを変える
        icon: shop.inCurrentSales ? shopOpenIcon : shopCloseIcon,
      );
      defaultMarkers[shop.iD.toString()] = marker;
    }

    setState(() {});
  }

  Position? currentPosition;
  late GoogleMapController _controller;
  late StreamSubscription<Position> positionStream;
  late BitmapDescriptor shopOpenIcon;
  late BitmapDescriptor shopCloseIcon;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: AppConstants.locationDistanceFilter,
  );

  // 初期位置
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(
        AppConstants.defaultMapLatitude, AppConstants.defaultMapLongitude),
    zoom: AppConstants.defaultMapZoom,
  );

  void setCustomMapPin() {
    shopOpenIcon = AssetMapBitmap(
      AppConstants.shopOpenImagePath,
      width: AppConstants.shopImageWidth,
      height: AppConstants.shopImageHeight,
    );
    shopCloseIcon = AssetMapBitmap(
      AppConstants.shopCloseImagePath,
      width: AppConstants.shopImageWidth,
      height: AppConstants.shopImageHeight,
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    initMarkers();
  }

  @override
  void initState() {
    setCustomMapPin();
    initMarkers();
    super.initState();

    // 位置情報が許可されていない時に許可をリクエストする
    Future(() async {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
    });

    // 現在位置を更新し続ける
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) async {
              _controller = controller;
              _onMapCreated(_controller);
            },
            markers: defaultMarkers.values.toSet(),
          ),
          Positioned(
            right: AppConstants.currentPositionButtonPositionRight,
            bottom: AppConstants.currentPositionButtonPositionBottom,
            child: _goToCurrentPositionButton(),
          )
        ],
      ),
    );
  }

  Widget _goToCurrentPositionButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(AppConstants.currentPositionButtonWidth,
            AppConstants.currentPositionButtonHeight),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const CircleBorder(),
      ),
      onPressed: () async {
        Position currentPosition = await Geolocator.getCurrentPosition(
            locationSettings: locationSettings);
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target:
                    LatLng(currentPosition.latitude, currentPosition.longitude),
                zoom: AppConstants.defaultMapZoom),
          ),
        );
        // 店舗情報を更新
        _onMapCreated(_controller);
      },
      child: const Icon(Icons.my_location_outlined),
    );
  }
}
