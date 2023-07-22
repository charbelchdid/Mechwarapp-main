import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_theme.dart';

class ConnectivityProvider extends ChangeNotifier {
  late ConnectivityResult _connectivityResult=ConnectivityResult.none;

  ConnectivityResult get connectivityResult => _connectivityResult;

  Future<void> initConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _connectivityResult = connectivityResult;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityResult = result;
      notifyListeners();
    });
  }
}

class ConnectivityHandler extends StatefulWidget {
  final Widget child;

  ConnectivityHandler({required this.child});

  @override
  _ConnectivityHandlerState createState() => _ConnectivityHandlerState();
}

class _ConnectivityHandlerState extends State<ConnectivityHandler> {
  @override
  Widget build(BuildContext context) {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);
    final connectivityResult = connectivityProvider.connectivityResult;

    if (connectivityResult == ConnectivityResult.none) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No internet connection',
                style: FlutterFlowTheme.of(context).title1,
              ),
              ElevatedButton(
                child: Text('Retry'),
                style: ElevatedButton.styleFrom(backgroundColor: FlutterFlowTheme.of(context).primaryColor),
                onPressed: () {
                  connectivityProvider.initConnectivity();
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return widget.child;
    }
  }
}
