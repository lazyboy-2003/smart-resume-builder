import 'package:flutter/material.dart';
import '../resume/personal_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Resume')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 24),
          Text('Build a resume that fits the job.',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('ATS-friendly, simple and privacy-first.'),
          const SizedBox(height: 32),
          Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
            const Icon(Icons.description_outlined, size: 56),
            const SizedBox(height: 16),
            const Text('Create your first resume', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Start with your personal and professional details.', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: FilledButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonalDetailsScreen())),
              icon: const Icon(Icons.add), label: const Text('Create Resume'))),
          ]))),
        ]),
      ),
    );
  }
}
