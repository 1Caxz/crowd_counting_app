class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:8000';
  static const String baseUploads = '$baseUrl/uploads';

  // Auth endpoints
  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';

  // Posts endpoints
  static const String postCreate = '$baseUrl/posts/create';
  static const String postUpdate = '$baseUrl/posts/update';
  static const String postDelete = '$baseUrl/posts/delete';
  static const String postList = '$baseUrl/posts/list';
}