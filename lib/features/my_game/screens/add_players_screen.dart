import 'package:flutter/material.dart';
import '../../../shared/widgets/gradient_background.dart';

class AddPlayersScreen extends StatefulWidget {
  const AddPlayersScreen({super.key});

  @override
  State<AddPlayersScreen> createState() => _AddPlayersScreenState();
}

class _AddPlayersScreenState extends State<AddPlayersScreen> {
  final List<Map<String, dynamic>> _contacts = List.generate(
    10,
    (index) => {
      'name': 'Aakash',
      'phone': '+919876543210',
      'selected': false,
    },
  );

  int get _selectedCount => _contacts.where((c) => c['selected'] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Players to Trailblazers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onChanged: (value) {
                    // Filter contacts
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return ListTile(
                    leading: Checkbox(
                      value: contact['selected'],
                      onChanged: (value) {
                        setState(() {
                          contact['selected'] = value;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(0xFFFF9800);
                          }
                          return Colors.white;
                        },
                      ),
                    ),
                    title: Text(
                      contact['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      contact['phone'],
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFFF9800),
              child: Text(
                'ADD PLAYER${_selectedCount > 1 ? 'S' : ''}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

