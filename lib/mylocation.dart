// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';

import 'package:basics/basics.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'myAlertLocation.dart';

class GetlocationPage extends StatefulWidget {
  const GetlocationPage({Key? key}) : super(key: key);

  @override
  _GetlocationPageState createState() => _GetlocationPageState();
}

class _GetlocationPageState extends State<GetlocationPage> {
  LatLng officelatLng = const LatLng(13.672462002395713, 100.60704757736507);
  late double lat, lng;
  bool loading = false;
  // late double lat1,lng1,lat2,lng2, distance;
  // late double lng;
  late GoogleMapController _mapController;
  double distanceInMeters = 0;
  double radius = 100;
  late String _timeString;
  String time = "16:16";
  DateTime timenow = DateTime.now();

  late DateTime startTimeCheckIn;
  late DateTime endTimeCheckOut;

  late Timer _timer;

  double? distance; // ระยะห่าง

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        loading = true;
        // radius = 100;
      });
    });
    checkPermission();
    _timeString = _formatDateTime(DateTime.now());
    // Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timer.isActive) {
        _getTime();
      }
    });

    var now = DateTime.now();
    final _StartInH = 14;
    final _StartInM = 00;
    final _EndOutH = 17;
    final _EndOutM = 00;
    startTimeCheckIn =
        DateTime(now.year, now.month, now.day, _StartInH, _StartInM);
    print("เวลาตอนนี้: $now");
    endTimeCheckOut =
        DateTime(now.year, now.month, now.day, _EndOutH, _EndOutM);
    print("เวลาออกงาน: $endTimeCheckOut");

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _getTime() async {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss dd/MM/yyyy').format(dateTime);
  }

  Future<void> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      // print('เปิดโลเคชั่นแล้ว');
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService3(context);
        } else {
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService3(context);
        } else {
          findLatLng();
        }
      }
    } else {
      print('โลเคชั่นปิดอยู่');
      MyDialog().alertLocationService3(context);
      // MyDialog().alertLocationService2(context);
      // MyDialog().alertLocationService(context);
    }
  }

  Future<void> findLatLng() async {
    Position? position = await findPostion();
    if (position != null) {
      setState(() {
        lat = position.latitude;
        lng = position.longitude;

        distance = calculateDistance(
            officelatLng.latitude, officelatLng.longitude, lat, lng);
        print('ละติจูด =$lat, ลองติจูด = $lng, distance ===>> $distance');
      });
    } else {
      lat = 8.166038894896127;
      lng = 99.65489290972046;
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  Future<Position?> findPostion() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: const MarkerId('HrPos'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: 'ตำแหน่งของคุณ',
          snippet: 'ละติจูด = $lat, ลองติจูต = $lng',
        ),
      ),
      Marker(
        markerId: MarkerId('office'),
        position: officelatLng,
        infoWindow: InfoWindow(
          title: 'Office',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(60),
      ),
    ].toSet();
  }

  showMap() {
    LatLng latLng = LatLng(lat, lng);
//    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    // return SizedBox(
    //   height: 300.0,
    //   child: GoogleMap(
    //     initialCameraPosition: cameraPosition,
    //     mapType: MapType.normal,
    //     onMapCreated: (controller) {},
    //     // markers: myMarker(),
    //   ),
    // );

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: const Text(
              "ขณะนี้เวลา",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              _timeString,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.location_on_outlined,
              size: 50,
              color: Colors.orangeAccent,
            ),
            title: Text('Lat: $lat'),
            subtitle: Text('Lng: $lng'),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: const Text(
              "ตำแหน่งของฉัน",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          lat == null
              ? Center(
                  child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                  strokeWidth: 5,
                ))
              : Container(
                  height: 300.0,
                  child: Card(
                    color: Colors.transparent,
                    child: GoogleMap(
                      initialCameraPosition: cameraPosition,
                      mapType: MapType.normal,
                      onMapCreated: (controller) => _mapController = controller,
                      markers: myMarker(),
                      circles: {
                        Circle(
                          circleId: CircleId('1'),
                          center: LatLng(lat, lng),
                          radius: radius,
                          fillColor:
                              Color.fromRGBO(255, 0, 0, 0.10196078431372549),
                          strokeColor: Colors.transparent,
                        )
                      },
                      myLocationEnabled: false,
                    ),
                    elevation: 20,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.green)),
                  )),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 0,
            child: Container(
              width: double.infinity,
              child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    if (distance! <= 100) {
                      
                    } else {
                      MyDialog().normalDialog(context, 'Distance Over',
                          'distanc => $distance เมตร');
                    }
                  },
                  child: const Text(
                    'เช็คอิน',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sarabun",
                    ),
                  )),
            ),
          ),
          timenow > endTimeCheckOut
              ? Expanded(
                  flex: 0,
                  child: Container(
                    width: double.infinity,
                    child: FlatButton(
                        color: Colors.orangeAccent,
                        onPressed: () {},
                        child: Text(
                          'เช็คเอ้า',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sarabun",
                          ),
                        )),
                  ),
                )
              : Container(
                  child: const Center(
                    child: Text(
                      'เวลาออกงาน 17:00 น.',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Sarabun',
                          color: Colors.grey),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ลงเวลา'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
              // border: Border.all(width: 15, color: Colors.white),
              gradient: LinearGradient(
                colors: [
                  Color(0xff6200EA),
                  Colors.white,
                ],
                begin: FractionalOffset(0.0, 1.0),
                end: FractionalOffset(1.5, 1.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurpleAccent,
                  spreadRadius: 5,
                  blurRadius: 30,
                  offset: Offset(5, 3),
                ),
              ],
              // image: DecorationImage(image: NetworkImage('https://www.pngitem.com/pimgs/m/391-3918613_personal-service-platform-person-icon-circle-png-transparent.png'))
            ),
          ),
        ),
        body: loading
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    showMap(),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                strokeWidth: 5,
              )));
  }
}
