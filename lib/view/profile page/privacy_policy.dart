import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_seat_booking/view%20model/sizedbox.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(175, 143, 111, 1.0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(116, 81, 45, 1.0),
        title: const Text(
          'Privacy And Policy',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
          ),
         10.hBox,
          const Text(
            'Effective Date: [Date]',
            style: TextStyle(fontSize: 16,color: Colors.white),
          ),
           10.hBox,
          const Text(
            '1. Introduction\n\nWelcome to [Restaurant Name]\'s Seat Booking App ("we", "our", "us"). We are committed to protecting and respecting your privacy. This Privacy Policy explains how we collect, use, and disclose information about you when you use our app.',
            style: TextStyle(fontSize: 16,color: Colors.white),
          ),
         10.hBox,
          const Text(
            '2. Information We Collect\n\nWe collect information about you in the following ways:\n\n- Personal Information: When you create an account, book a seat, or contact us, we may collect personal information such as your name, email address, phone number, and payment information.\n- Usage Information: We may collect information about your use of the app, such as your booking history, preferences, and interactions with our services.\n- Device Information: We may collect information about the device you use to access our app, including the device model, operating system, IP address, and unique device identifiers.',
            style: TextStyle(fontSize: 16,color: Colors.white),
          ),
          10.hBox,
          // Continue with other sections in a similar way
          const Text(
            'Terms of Service',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
          ),
           10.hBox,
          const Text(
            'Effective Date: [Date]',
            style: TextStyle(fontSize: 16,color: Colors.white,),
          ),
          const SizedBox(height: 10),
          const Text(
            '1. Acceptance of Terms\n\nBy accessing or using the [Restaurant Name] Seat Booking App (the "App"), you agree to be bound by these Terms of Service ("Terms"). If you do not agree to these Terms, you may not use the App.',
            style: TextStyle(fontSize: 16,color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text(
            '2. Use of the App\n\nYou agree to use the App in accordance with these Terms and all applicable laws. You must be at least 18 years old to use the App. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.',
            style: TextStyle(fontSize: 16,color: Colors.white),
          ),
          const SizedBox(height: 10),
          // Continue with other sections in a similar way
        ],
      ),
    );
  }
}


// Sure! Below is a sample privacy policy and terms of service for your restaurant seat booking app. Make sure to customize these documents to fit the specific legal requirements and practices of your business and consult with a legal professional to ensure compliance with relevant laws and regulations.

// ---

// **Privacy Policy**

// **Effective Date:** [Date]

// **1. Introduction**

// Welcome to [Restaurant Name]'s Seat Booking App ("we", "our", "us"). We are committed to protecting and respecting your privacy. This Privacy Policy explains how we collect, use, and disclose information about you when you use our app.

// **2. Information We Collect**

// We collect information about you in the following ways:

// - **Personal Information:** When you create an account, book a seat, or contact us, we may collect personal information such as your name, email address, phone number, and payment information.
// - **Usage Information:** We may collect information about your use of the app, such as your booking history, preferences, and interactions with our services.
// - **Device Information:** We may collect information about the device you use to access our app, including the device model, operating system, IP address, and unique device identifiers.

// **3. How We Use Your Information**

// We use the information we collect to:

// - Provide and improve our services.
// - Process your bookings and payments.
// - Communicate with you about your bookings and our services.
// - Personalize your experience.
// - Analyze usage and trends to improve our app.
// - Protect against fraud and ensure the security of our app.

// **4. Sharing Your Information**

// We may share your information with:

// - **Service Providers:** We may share your information with third-party service providers who assist us in providing our services.
// - **Legal Requirements:** We may disclose your information if required to do so by law or in response to a valid request from a law enforcement or government agency.
// - **Business Transfers:** In the event of a merger, acquisition, or sale of our business, your information may be transferred as part of the transaction.

// **5. Security**

// We take reasonable measures to protect your information from unauthorized access, loss, misuse, or alteration. However, no method of transmission over the internet or electronic storage is completely secure.

// **6. Your Choices**

// You may update your account information or delete your account by contacting us. You may also opt out of receiving promotional communications from us by following the instructions in those communications.

// **7. Changes to This Privacy Policy**

// We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on our app. You are advised to review this Privacy Policy periodically for any changes.

// **8. Contact Us**

// If you have any questions about this Privacy Policy, please contact us at:

// [Restaurant Name]  
// [Address]  
// [Email Address]  
// [Phone Number]  

// ---

// **Terms of Service**

// **Effective Date:** [Date]

// **1. Acceptance of Terms**

// By accessing or using the [Restaurant Name] Seat Booking App (the "App"), you agree to be bound by these Terms of Service ("Terms"). If you do not agree to these Terms, you may not use the App.

// **2. Use of the App**

// You agree to use the App in accordance with these Terms and all applicable laws. You must be at least 18 years old to use the App. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.

// **3. Booking and Payments**

// When you book a seat through the App, you agree to provide accurate and complete information. You authorize us to charge your payment method for the total amount of your booking. All bookings are subject to availability and our cancellation policy.

// **4. User Conduct**

// You agree not to:

// - Use the App for any unlawful purpose.
// - Interfere with or disrupt the operation of the App.
// - Attempt to gain unauthorized access to the App or other users' accounts.
// - Use the App to transmit any harmful or disruptive code.

// **5. Intellectual Property**

// The App and its content, including text, graphics, logos, and software, are the property of [Restaurant Name] or its licensors and are protected by intellectual property laws. You may not reproduce, distribute, or create derivative works from the App or its content without our prior written permission.

// **6. Limitation of Liability**

// To the fullest extent permitted by law, [Restaurant Name] and its affiliates will not be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with your use of the App.

// **7. Indemnification**

// You agree to indemnify and hold harmless [Restaurant Name] and its affiliates from any claims, losses, liabilities, damages, costs, and expenses arising out of or in connection with your use of the App or your violation of these Terms.

// **8. Governing Law**

// These Terms are governed by and construed in accordance with the laws of [State/Country], without regard to its conflict of law principles.

// **9. Changes to These Terms**

// We may update these Terms from time to time. We will notify you of any changes by posting the new Terms on our App. Your continued use of the App after the changes become effective constitutes your acceptance of the new Terms.

// **10. Contact Us**

// If you have any questions about these Terms, please contact us at:

// [Restaurant Name]  
// [Address]  
// [Email Address]  
// [Phone Number]  

// ---

// Make sure to replace placeholders like "[Restaurant Name]" and "[Date]" with your actual information.
