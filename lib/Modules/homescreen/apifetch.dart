import 'dart:convert'; // For JSON parsing
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Email & Password Input')),
        body: const Apifetch(),
      ),
    );
  }
}

class Apifetch extends StatefulWidget {
  const Apifetch({super.key});

  @override
  _DataFetchingScreenState createState() => _DataFetchingScreenState();
}

class _DataFetchingScreenState extends State<Apifetch> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Function to fetch data from the API
  Future<void> fetchData() async {
    const url =
        'http://fashionapp.idealake.com/api/user/login'; // Replace with your API URL

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Assuming the API returns JSON with 'email' and 'password' fields
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _emailController.text = data['email'] ?? ''; // Pre-fill email
          _passwordController.text =
              data['password'] ?? ''; // Pre-fill password
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Error: $error';
      });
    }
  }

  // Function to handle form submission
  void _submitData() {
    final email = _emailController.text;
    final password = _passwordController.text;

    // You can send the data back to the server here
    // For now, we're just printing the values
    print('Email: $email');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return Center(child: Text(_errorMessage));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _passwordController,
            obscureText: true, // Hide password input
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitData,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
