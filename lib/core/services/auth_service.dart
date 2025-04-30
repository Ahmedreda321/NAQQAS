import 'package:google_sign_in/google_sign_in.dart';

import '../constants/app_constants.dart';
import 'logger_service.dart';

class AuthService {
  static final List<String> scopes = <String>[
    'email',
    'profile',
    'https://www.googleapis.com/auth/drive.file',
    'https://www.googleapis.com/auth/spreadsheets',
  ];

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: scopes,
    serverClientId: AppConstants.serverClientId,
  );

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      AppLogger.e('Sign in failed: $error');
      return null;
    }
  }
}
