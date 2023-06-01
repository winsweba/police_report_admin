import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:video_player/video_player.dart';

class DetailsPage extends StatefulWidget {
  final String locationLat;
  final String locationLong;
  final String fileSend;
  final String messageReported;
  final String reporterLocation;
  // final String uid;
  // // final String timestamp;
  final String reporterPhone;
  final String reporterName;
  const DetailsPage({
    super.key,
    required this.messageReported,
    required this.reporterLocation,
    required this.reporterPhone,
    required this.reporterName,
    required this.locationLat,
    required this.locationLong,
    required this.fileSend,
  });
  // const DetailsPage({super.key, required this.locationLat, required this.locationLong, required this.fileSend, required this.messageReported, required this.reporterLocation, required this.uid, required this.reporterPhone, required this.reporterName});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  VideoPlayerController? _controller;
  bool _isVideo = false;
  String pic = '';

  getVideo() {
    try {
      _controller = VideoPlayerController.network(widget.fileSend);
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
      // ..initialize().then((_) {
      //   // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      //   setState(() {});
      // });
      setState(() {
        _isVideo = true;
        //  widget.fileSend;
      });
      // Initialize the controller and store the Future for later use.
      _controller!.initialize();

      // Use the controller to loop the video.
      _controller!.setLooping(true);

      _controller!.play();
    } catch (e) {
      print("VVVVVVVVVVVVVVVVV$e");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 8),
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                        image: AssetImage('assets/cctv.jpg'), fit: BoxFit.fill),
                  ),

              //     child: _isVideo
              //       ? VideoPlayer(_controller!)
              //       : _pickFile == null
              //           // child: _isVideo ? VideoPlayer(_controller!) : _pickFile == null
              //           ? const Text("")
              //           : Image.file(
              //               _pickFile!,
              //               fit: BoxFit.fill,
              //             ),
              // ),
                  child: _isVideo
                      ? VideoPlayer(_controller!) 
                      : pic =='' ? const Text("") :
                      Image.network(
                          pic,
                          fit: BoxFit.fill,
                        ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        "view photo ",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      onPressed: () {
                     setState(() {
                       pic = widget.fileSend;
                       _isVideo = false;
                     });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        "view video ",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      onPressed: () {

                        getVideo();
                        
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Name:: ${widget.reporterName}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Phone No.:: ${widget.reporterPhone}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Reporters Location:: ${widget.reporterLocation}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Reported Message::",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.messageReported,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    "view Location ",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    if (widget.locationLat == "null" ||
                        widget.locationLong == "null") {
                      Fluttertoast.showToast(
                        msg: "Location is not Given",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return;
                    }
                    double lat = double.parse(widget.locationLat);
                    double long = double.parse(widget.locationLong);
                    MapsLauncher.launchCoordinates(
                        lat, long, 'Google Headquarters are here');
                    // print(widget.locationLat);
                    // print(widget.locationLong);
                  },
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
