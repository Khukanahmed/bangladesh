class Urls {
  static const String baseUrl = 'https://api.mfmebooks.com/api/v1';
  // static const String baseUrl = 'http://10.0.20.20:5005/api/v1';

  static const String login = '$baseUrl/auth/login';
  static const String forgetPassword = '$baseUrl/auth/forgot-password';
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static const String changePassword = '$baseUrl/auth/change-password';
  static const String resendOtp = '$baseUrl/auth/resend-otp';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String userProfile = '$baseUrl/auth/profile';
  static const String updateProfile = '$baseUrl/users/profile';
  static const String banner = '$baseUrl/banner';
  static const String toggleFavourite = '$baseUrl/favorites/toggle';
  static const String getRecommended = '$baseUrl/book/recommended';
  static const String getBestselling = '$baseUrl/book/best-selling';
  static const String getNotification = '$baseUrl/notifications';

  static const String register = '$baseUrl/users/register';
  static const String userUpdateProfile = '$baseUrl/users/profile';
  static const String getChapter = '$baseUrl/chapter';
  static const String addChapter = '$baseUrl/chapter';

  static String updatedChapterAndTheory(String id) => '$baseUrl/chapter/$id';

  static const String deleteChapter = '$baseUrl/chapter';
  static const String getAdminList = '$baseUrl/users/get-admin-list';
  static const String addAdmin = '$baseUrl/users/make-admin';
  static const String deleteAdmin = '$baseUrl/users';

  static const String addExercise = '$baseUrl/chapter';
  static const String adminParcentage = '$baseUrl/complete/admin';

  static const String fetchFavourite = '$baseUrl/favorites/user/all';

  static const String helpSupport = '$baseUrl/users/send-support-mail';

  static const String userPercentage = '$baseUrl/complete';

  static const String editExercise = '$baseUrl/chapter/exercise';
}
