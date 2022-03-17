import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:sweetalert/sweetalert.dart';

class MyDialog {
  Future<void> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
        context: context, builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        ));
  }

  Future<Null> alertLocationService(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const ListTile(
          leading: Icon(Icons.location_off),
          title: Text('Location Service ปิดอยู่ ?'),
          subtitle: Text('กรุณาเปิด Location Service'),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                // Navigator.pop(context);
                await Geolocator.openLocationSettings();
                exit(0);
              },
              child: Text('ตกลง'))
        ],
      ),
    );
  }

  alertLocationService2(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      // dialogBackgroundColor: Colors.orange,
      borderSide: BorderSide(color: Colors.orangeAccent, width: 1),
      width: 400,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.SCALE,
      title: 'Location Service ปิดอยู่',
      desc: 'กรุณาเปิด Location Service',
      showCloseIcon: false,
      btnOkText: "ตกลง",
      // btnOkOnPress: () {},
    ).show();
  }

  alertLocationService3(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: ListTile(
                title: Text("Location Service ปิดอยู่"),
                subtitle: Text("กรุณาเปิด Location Service"),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Future.delayed(Duration(seconds: 2), () {
                        Geolocator.openLocationSettings();
                        exit(0);
                      });
                    },
                    child: Text('OK'))
              ],
            ));

    // return SweetAlert.show(context,
    //     title: "Location Service ปิดอยู่",
    //     subtitle: "กรุณาเปิด Location Service",
    //     style: SweetAlertStyle.confirm,
    //     showCancelButton: false,
    //     confirmButtonText: "ตกลง", onPress: (bool isConfirm) {
    //   if (isConfirm) {
    //     SweetAlert.show(context,
    //         title: "Please Open Location!", style: SweetAlertStyle.loading);
    //     // Future.delayed(Duration(seconds: 2),(){
    //     //   SweetAlert.show(context,
    //     //       title: "Please Open Location Before Use.",
    //     //       style: SweetAlertStyle.error
    //     //   );
    //     // });
    //     Future.delayed(Duration(seconds: 2), () {
    //       Geolocator.openLocationSettings();
    //       exit(0);
    //     });

    //     // SweetAlert.show(context,subtitle: "Deleting...", style: SweetAlertStyle.loading);
    // } else {
    Geolocator.openLocationSettings();
    exit(0);
    // SweetAlert.show(context,subtitle: "Canceled!", style: SweetAlertStyle.error);
    //   }
    //   // return false to keep dialog
    //   return false;
    // });
  }
}
