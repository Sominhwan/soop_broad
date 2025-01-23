
import 'dart:io';

const EnvProfile appEnv = EnvProfile.dev;

Uri? getAppStoreUrl(String aosPackage, String iosAppId) {
  if (Platform.isIOS) {
    if (iosAppId.isEmpty) {
      return null;
    }

    return Uri.parse('itms-apps://itunes.apple.com/app/id$iosAppId');
  } else if (Platform.isAndroid) {
    if (aosPackage.isEmpty) {
      return null;
    }
    return Uri.parse('market://details?id=$aosPackage');
  }

  return null;
}

enum EnvProfile {
  dev(
    url: 'http://192.168.0.218:9000',
  ),
  prod(
    url: 'https://sojungan.i-gns.co.kr',
  );

  const EnvProfile({
    required this.url,
  });
  final String url;
}
