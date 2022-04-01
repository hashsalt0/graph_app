class Config{
  // flat file name to store json string
  static const saveFile = "users_app_data.bin";

  // courses to enroll for a user
  static const int courseEntry = 4;

  static var envDevelopment = 0;
  static var envRelease = 1;

  static var env = envRelease;
}