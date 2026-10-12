import 'package:flutter/material.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});
  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showOptional = false;

  Widget field(String label, {TextInputType? keyboardType, bool required = false}) =>
    Padding(padding: const EdgeInsets.only(bottom: 14), child: TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      validator: required ? (v) => v == null || v.trim().isEmpty ? 'Required' : null : null));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Details')),
      body: Form(key: _formKey, child: ListView(padding: const EdgeInsets.all(20), children: [
        Text('Tell us about you', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Only include information you want on your resume.'),
        const SizedBox(height: 24),
        field('Full Name', required: true),
        field('Professional Title / Job Role', required: true),
        field('Mobile Number', keyboardType: TextInputType.phone, required: true),
        field('Email Address', keyboardType: TextInputType.emailAddress, required: true),
        field('City'), field('State'), field('Country'),
        const SizedBox(height: 8),
        Text('Professional Links', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        field('LinkedIn'), field('Portfolio / Website'), field('GitHub'),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Add optional personal details'),
          subtitle: const Text('Enable only when the employer or CV format requires them.'),
          value: showOptional, onChanged: (v) => setState(() => showOptional = v)),
        if (showOptional) ...[
          field('Full Address'), field('PIN Code', keyboardType: TextInputType.number),
          field('Date of Birth'), field('Nationality'), field('Marital Status')],
        const SizedBox(height: 20),
        FilledButton(onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Personal details ready')));
          }
        }, child: const Text('Save & Continue')),
      ])),
    );
  }
}
