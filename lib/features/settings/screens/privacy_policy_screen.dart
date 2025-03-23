import 'package:flutter/material.dart';
import '../../../shared/widgets/gradient_background.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
                  'Privacy Policy',
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
                _buildPolicySection(
                  title: 'Introduction',
                  content: 'Arjh Tech Labs Private Limited ("we", "our", or "us") operates the Sportsvani mobile application (the "Service"). This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our Service and the choices you have associated with that data.',
                ),
                _buildPolicySection(
                  title: 'Information Collection and Use',
                  content: 'We collect several different types of information for various purposes to provide and improve our Service to you.',
                ),
                _buildPolicySection(
                  title: 'Types of Data Collected',
                  content: 'Personal Data: While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you ("Personal Data"). Personally identifiable information may include, but is not limited to:\n\n• Email address\n• First name and last name\n• Phone number\n• Address, State, Province, ZIP/Postal code, City\n• Cookies and Usage Data',
                ),
                _buildPolicySection(
                  title: 'Use of Data',
                  content: 'Sportsvani uses the collected data for various purposes:\n\n• To provide and maintain the Service\n• To notify you about changes to our Service\n• To allow you to participate in interactive features of our Service when you choose to do so\n• To provide customer care and support\n• To provide analysis or valuable information so that we can improve the Service\n• To monitor the usage of the Service\n• To detect, prevent and address technical issues',
                ),
                _buildPolicySection(
                  title: 'Transfer of Data',
                  content: 'Your information, including Personal Data, may be transferred to — and maintained on — computers located outside of your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from your jurisdiction.',
                ),
                _buildPolicySection(
                  title: 'Security of Data',
                  content: 'The security of your data is important to us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security.',
                ),
                _buildPolicySection(
                  title: 'Contact Us',
                  content: 'If you have any questions about this Privacy Policy, please contact us:\n\n• By email: sportsvaniapp@gmail.com\n• By phone: +919670006261\n• By mail: D9 Ground Floor Sector 3 Noida 201301 UP India',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPolicySection({required String title, required String content}) {
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

