class ApiUrl{

  // BaseUrl
  static String BaseUrl = 'https://falgunigajjar.artologyplus.com/BussinessDialouge/public';

  //Login Api
  static String login ='$BaseUrl/api/login';

  //Register
  static String register = '$BaseUrl/api/register';

  // Category List
  static String  category_List = '$BaseUrl/api/categories/index';
  //Category_Business
  static String  category_Business_List = '$BaseUrl/api/bussiness/index';

  //Profile
  static String user_edit = '$BaseUrl/api/user/update';

  //Logout
  static String logout = '$BaseUrl/api/logout';

  //Forget Password
  static String forget_password ='$BaseUrl/api/forget-password-request';
  static String otp_verify = '$BaseUrl/api/verify-otp';
  static String reset_password = '$BaseUrl/api/reset-password';


}