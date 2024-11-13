import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Bill>> fetchBills(String token) async {
  final response = await http.get(
    Uri.parse('https://huflit.id.vn:4321/api/Bill/getHistory'),
    headers: {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Bill.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load bills');
  }
}

class Bill {
  final String name;
  final String date;
  final String status;

  Bill({required this.name, required this.date, required this.status});

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      name: json['name'],
      date: json['date'],
      status: json['status'],
    );
  }
}
