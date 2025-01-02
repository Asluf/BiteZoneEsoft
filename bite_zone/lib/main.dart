import 'package:bite_zone/providers/theme_provider.dart';
import 'package:bite_zone/screens/common_screens/get_started_screen.dart';
import 'package:bite_zone/screens/common_screens/login_screen.dart';
import 'package:bite_zone/screens/common_screens/user_register_screen.dart';
import 'package:bite_zone/screens/user_screens/user_router_screen.dart';
import 'package:flutter/material.dart';
import 'package:bite_zone/services/bite_zone_db_service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await BiteZoneDBService.instance.database;
  // await BiteZoneDBService.instance.deleteAndRecreateUserTable();
  bool permissionsGranted = await _checkPermissions();
  if (!permissionsGranted) {
    runApp(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Permissions not granted. The app cannot proceed.'),
        ),
      ),
    ));
    return;
  }
  final user = await BiteZoneDBService.instance.getUser();
  // hive for offline access
  await Hive.initFlutter();
  await Hive.openBox('placesBox');
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(user: user),
    ),
  );
}

Future<bool> _checkPermissions() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  bool allGranted = true;

  // Request location permissions
  PermissionStatus locationPermission =
      await Permission.locationWhenInUse.request();
  if (!locationPermission.isGranted) {
    allGranted = false;
  }

  // Request storage or media permissions (depending on Android version)
  if (androidInfo.version.sdkInt >= 33) {
    PermissionStatus imagesPermission = await Permission.photos.request();
    if (!imagesPermission.isGranted) {
      allGranted = false;
    }
  } else {
    PermissionStatus storagePermission = await Permission.storage.request();
    if (!storagePermission.isGranted) {
      allGranted = false;
    }
  }

  return allGranted;
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? user;

  const MyApp({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _setInitialTheme(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'Bite Zone',
                debugShowCheckedModeBanner: false,
                theme: themeProvider.themeData,
                initialRoute: user == null
                    ? '/get_started'
                    : _getHomeRoute(user!['role']),
                routes: {
                  '/get_started': (context) => const GetStartedScreen(),
                  '/login': (context) => LoginScreen(),
                  '/register_user': (context) => UserRegisterScreen(),
                  '/user_home': (context) => UserRouterScreen(),
                },
              );
            },
          );
        }
      },
    );
  }

  Future<void> _setInitialTheme(BuildContext context) async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    if (user != null) {
      themeProvider.setTheme(user!['role']);
    }
  }

  String _getHomeRoute(String role) {
    switch (role) {
      case 'SUPER_ADMIN':
        return '/admin_dashboard';
      case 'USER':
        return '/user_home';
      default:
        return '/login';
    }
  }
}
