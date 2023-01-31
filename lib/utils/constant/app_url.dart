class AppUrl {
  static const String liveBaseURL = "https://www.carelan.in/surgeondata";
//Authentication
  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/login.php";
  static const String register = baseURL +"/register.php";
  static const String addNewMeeting = baseURL + "/data_insert.php";
  static const String getMeetings = baseURL + "/getmeetings.php";
  static const String updateMeeting = baseURL + "/update.php";
  static const String getCompletedMeeting = baseURL + "/fetch.php";
  static const String getRevivalList = baseURL + "/revivallist.php";
  static const String revivalUpdate = baseURL + "/revival.php";
  static const String getFieldWorkerList = baseURL + "/getfieldworkerlist.php";
  static const String updateActive = baseURL + "/updateActive.php";
  static const String activeSurgeonList = baseURL + "/activeSergeon.php";

}