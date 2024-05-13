import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/Models/Doctor.dart';

class DoctorService {
  Future<List<Doctor>> getDoctors() async {
    final response = await http.get(Uri.parse('https://run.mocky.io/v3/a4812f08-7c80-4874-a232-0961083cf2bc'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['doctors'];
      return data.map((json) => Doctor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }
}
