
import 'package:flutter/material.dart';

import 'live_video_streming.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LiveVideoStreming(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   CameraController? controller;
//   bool isLoading = true;
//   bool isRecording = false;
//   Timer? time;
//   XFile? vPath;
//   Duration _duration = const Duration(seconds: 0);
//   bool timerStrart = false;

//   int clickFirsttime = 0;

//   bool flipCamera = false;

//   @override
//   void initState() {
//     initCamera();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     time!.cancel();
//     super.dispose();
//   }

//   initCamera() async {
//     final cameras = await availableCameras();
//     CameraDescription front;
//     if (flipCamera) {
//       front = cameras.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.front);
//     } else {
//       front = cameras.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.back);
//     }
//     controller = CameraController(front, ResolutionPreset.max);
//     await controller!.initialize();
//     setState(() => isLoading = false);
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     String hours = duration.inHours.toString();
//     return "$hours : $twoDigitMinutes : $twoDigitSeconds";
//   }

//   void _startTimer() async {
//     setState(() {
//       _duration = const Duration(seconds: 0);
//       timerStrart = true;
//     });
//     await controller!.startVideoRecording();
//     const oneSec = Duration(seconds: 1);
//     // time = Timer.periodic(
//     //   oneSec,
//     //   (timer) => setState(() {
//     //     _duration += oneSec;
//     //   }),
//     // );
//   }

//   void _stopTimer() async {
//     setState(() {
//       timerStrart = false;
//       _duration = const Duration(seconds: 0);
//     });
//     final path = await controller!.stopVideoRecording();
//     setState(() {
//       vPath = path;
//     });
//     time!.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         title: const Text("Live Video Recording",style: TextStyle(
//           fontSize: 17,
//           color: Colors.white
//         ),),
//         centerTitle: true,
//       ),
//       body: Stack(
//         // fit: StackFit.expand,
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child:
//                 controller != null ? CameraPreview(controller!) : Container(),
//           ),
//           Positioned(
//             bottom: 35,
//             left: 20,
//             child: GestureDetector(
//               onTap: () {
//                 if (flipCamera) {
//                   initCamera();
//                   setState(() {
//                     flipCamera = false;
//                   });
//                 } else {
//                   initCamera();
//                   setState(() {
//                     flipCamera = true;
//                   });
//                 }
//               },
//               child: Container(
//                   height: 50,
//                   width: 50,
//                   padding: const EdgeInsets.all(5),
//                   decoration: const BoxDecoration(shape: BoxShape.circle),
//                   child: const Icon(Icons.flip_camera_android,
//                       color: Colors.white, size: 30)),
//             ),
//           ),
//           Positioned(
//               left: 0,
//               right: 0,
//               bottom: 20,
//               child: Column(
//                 children: [
//                   if (timerStrart)
//                     Container(
//                         width: 90,
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 7, vertical: 5),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.red[500]),
//                         child: Text(
//                           _formatDuration(_duration),
//                           style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500),
//                         )),
//                   const SizedBox(height: 15),
//                   GestureDetector(
//                     onTap: () async {
//                       if (timerStrart == false) {
//                         _startTimer();
//                       } else {
//                         _stopTimer();
//                       }
//                     },
//                     child: Container(
//                       height: 80,
//                       width: 80,
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: 5)),
//                       child: timerStrart
//                           ? const Icon(Icons.pause,
//                               color: Colors.white, size: 40)
//                           : Container(
//                               decoration: const BoxDecoration(
//                                   color: Colors.white, shape: BoxShape.circle),
//                             ),
//                     ),
//                   ),
//                 ],
//               )),
//           if (vPath != null)
//             Positioned(
//               bottom: 35,
//               right: 20,
//               child: GestureDetector(
//                 onTap: () async {
//                   await GallerySaver.saveVideo(vPath!.path).then(
//                     (value) => ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         behavior: SnackBarBehavior.floating,
//                         backgroundColor: Colors.grey,
//                         content: Text(
//                           "Video Saved",
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                     height: 50,
//                     width: 50,
//                     padding: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 2)),
//                     child: const Icon(Icons.download, color: Colors.white)),
//               ),
//             )
//         ],
//       ),
//     );
//   }
// }
