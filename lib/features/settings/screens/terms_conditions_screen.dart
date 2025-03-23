import 'package:flutter/material.dart';
import '../../../shared/widgets/gradient_background.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Last updated: August 1, 2023',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTermsSection(
                  title: 'Introduction',
                  content: 'These Terms and Conditions ("Terms", "Terms and Conditions") govern your use of the Sportsvani mobile application (the "Service") operated by Arjh Tech Labs Private Limited ("us", "we", or "our").\n\nPlease read these Terms and Conditions carefully before using the Service.',
                ),
                _buildTermsSection(
                  title: 'Acceptance of Terms',
                  content: 'By accessing or using the Service, you agree to be bound by these Terms. If you disagree with any part of the terms, then you may not access the Service.',
                ),
                _buildTermsSection(
                  title: 'Use of the Service',
                  content: 'The Service is intended for users who are at least 13 years of age. By using the Service, you confirm and warrant that you are at least 13 years of age and that you agree to and will abide by all of the terms and conditions of this Agreement.',
                ),
                _buildTermsSection(
                  title: 'User Accounts',
                  content: 'When you create an account with us, you must provide us with information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.',
                ),
                _buildTermsSection(
                  title: 'Intellectual Property',
                  content: 'The Service and its original content, features, and functionality are and will remain the exclusive property of Arjh Tech Labs Private Limited and its licensors. The Service is protected by copyright, trademark, and other laws of both India and foreign countries.',
                ),
                _buildTermsSection(
                  title: 'Termination',
                  content: 'We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.',
                ),
                _buildTermsSection(
                  title: 'Limitation of Liability',
                  content: 'In no event shall Arjh Tech Labs Private Limited, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from your access to or use of or inability to access or use the Service.',
                ),
                _buildTermsSection(
                  title: 'Changes to Terms',
                  content: 'We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will try to provide at least 30 days\' notice prior to any new terms taking effect.',
                ),
                _buildTermsSection(
                  title: 'Contact Us',
                  content: 'If you have any questions about these Terms, please contact us:\n\n• By email: sportsvaniapp@gmail.com\n• By phone: +919670006261\n• By mail: D9 Ground Floor Sector 3 Noida 201301 UP India',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

