import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {
  /// 권한 상태 확인
  Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.status == PermissionStatus.granted;
  }

  /// 단인 권한 요청
  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }

  /// 다중 권한 요청
  Future<Map<Permission, PermissionStatus>> requestPermissions(List<Permission> permissions) async {
    return await permissions.request();
  }

  /// 앱 설정 열기
  Future<bool> openAppSettingsScreen() async {
    return await openAppSettings();
  }

  /// 다중 권한 체크
  Future<Map<Permission, PermissionStatus>> checkPermissionsStatus(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = {};
    for (Permission permission in permissions) {
      statuses[permission] = await permission.status;
    }
    return statuses;
  }

  /// 허용한 모든 권한 체크
  Future<bool> areAllPermissionsGranted(List<Permission> permissions) async {
    for (Permission permission in permissions) {
      if (await permission.status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  // Request storage permission
  Future<PermissionStatus> requestStoragePermission() async {
    return await Permission.storage.request();
  }

  // Request location permission
  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.location.request();
  }

  // Request camera permission
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  // Request notification permission
  Future<PermissionStatus> requestNotificationPermission() async {
    return await Permission.notification.request();
  }

  // Request exactNotification permission
  Future<PermissionStatus> requestExactNotificationPermission() async {
    return await Permission.scheduleExactAlarm.request();
  }
}