import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_temp_by_nqh/app/app.dart';
import 'package:flutter_temp_by_nqh/app/multi_languages/multi_languages_utils.dart';
import 'package:flutter_temp_by_nqh/gen/assets.gen.dart';
import 'package:local_auth/local_auth.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _canCheckBiometrics = false;
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (_) {
      canCheckBiometrics = false;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (_) {
      availableBiometrics = <BiometricType>[];
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Assets.images.cartoonBirdsBlueFlyingAnimationClipart.image(),
          ),
          Text(
            "Home Page",
            style: StyleManager.label2,
          ),
          Text(
            "Login Screen ${LocaleKeys.title.tr()} ${ConfigManager.getInstance()!.appFlavor}",
            style: StyleManager.label4,
          ),
          if (_supportState == _SupportState.unknown)
            const CircularProgressIndicator()
          else if (_supportState == _SupportState.supported)
            const Text('This device is supported')
          else
            const Text('This device is not supported'),
          Text('Can check biometrics: $_canCheckBiometrics\n'),
          ElevatedButton(
            onPressed: _checkBiometrics,
            child: const Text('Check biometrics'),
          ),
          Text(
              'Available biometrics: ${_availableBiometrics ?? "Click to check"}\n'),
          ElevatedButton(
            onPressed: _getAvailableBiometrics,
            child: const Text('Get available biometrics'),
          ),
          Text('Current State: $_authorized\n'),
          if (_isAuthenticating)
            ElevatedButton(
              onPressed: _cancelAuthentication,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text('Cancel Authentication'),
                  Icon(Icons.cancel),
                ],
              ),
            )
          else
            Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: _authenticate,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Text('Authenticate'),
                      Icon(Icons.perm_device_information),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _authenticateWithBiometrics,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(_isAuthenticating
                          ? 'Cancel'
                          : 'Authenticate: biometrics only'),
                      const Icon(Icons.fingerprint),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
