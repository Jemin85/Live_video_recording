import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LiveVideoStreming extends StatefulWidget {
  const LiveVideoStreming({super.key});

  @override
  State<LiveVideoStreming> createState() => _LiveVideoStremingState();
}

class _LiveVideoStremingState extends State<LiveVideoStreming> {
  TextEditingController first = TextEditingController();
  TextEditingController secound = TextEditingController();
  GlobalKey<FormState> _from = GlobalKey();
  var host = false;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Streaming'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _from,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: first,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Enter User ID";
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: "User ID"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: secound,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Enter User Name";
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: "User Name"),
              ),
              const SizedBox(height: 20),
              Checkbox(
                  value: host,
                  onChanged: (value) {
                    setState(() {
                      host = value!;
                    });
                  }),
              const Text("Host"),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (_from.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecoundWidgets(
                                  liveID: "100",
                                  host: host,
                                  userid: first.text,
                                  username: secound.text)));
                    }
                  },
                  child: const Text("Join"))
            ],
          ),
        ),
      ),
    );
  }
}

class SecoundWidgets extends StatefulWidget {
  final String liveID;
  final bool host;
  final String userid;
  final String username;
  const SecoundWidgets(
      {super.key,
      required this.liveID,
      required this.host,
      required this.userid,
      required this.username});

  @override
  State<SecoundWidgets> createState() => _SecoundWidgetsState();
}

class _SecoundWidgetsState extends State<SecoundWidgets> {
  ZegoUIKitPrebuiltLiveStreamingController controller =
      ZegoUIKitPrebuiltLiveStreamingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ZegoUIKitPrebuiltLiveStreaming(
      appID: 1370142978,
      appSign:
          "91398cab5cf9fd39ad035ac1e9749d151f9bed73f0dff6e72278165d8c1ff7cc",
      userID: widget.userid,
      liveID: widget.liveID,
      userName: widget.username,
      controller: controller,
      onDispose: () {
        controller.leave(context, showConfirmation: true);
        // controller.
      },
      config: widget.host
          ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
          : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
    ));
  }
}
