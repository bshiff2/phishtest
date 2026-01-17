import 'package:flutter/material.dart';
import 'dart:math';

// Email model class
class Email {
  final String sender;
  final String content;
  final bool phish;
  final String reason; 

  Email({
    required this.sender,
    required this.content,
    required this.phish,
    required this.reason,
  });
}

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int currentStreak = 0;
  int currentEmailIndex = 0;
  bool showReason = false;

  // Email List
  final List<Email> emails = [
    Email(
      sender: 'security@paypal.com',
      content:
          'Dear Valued Customer,\n\nWe have detected unusual activity on your account. Please click the link below to verify your identity.\n\nClick here to verify',
      phish: true,
      reason: 'Suspicious link.',
    ),
    Email(
      sender: 'noreply@amazon.com',
      content:
          'Your order #123456 has been shipped! Track your package here: https://amazon.com/orders',
      phish: false,
      reason: 'This is a legitimate email.',
    ),
    Email(
      sender: 'admin@bank.com',
      content:
          'URGENT: Your account has been compromised. Update your password immediately by clicking this link: [link]',
      phish: true,
      reason: 'Suspicious request to change password via link.',
    ),
  ];

  void _handleFlag() {
    setState(() {
      if (emails[currentEmailIndex].phish) {
        // Correct! It is a phishing email
        currentStreak++;
        currentEmailIndex = Random().nextInt(emails.length);
        showReason = false;
      } else {
        // Wrong! It was not a phishing email
        currentStreak = 0;
        showReason = true;
      }
    });
  }

  void _handleGood() {
    setState(() {
      if (!emails[currentEmailIndex].phish) {
        // Correct! It is a legitimate email
        currentStreak++;
        currentEmailIndex = Random().nextInt(emails.length);
        showReason = false;
      } else {
        // Wrong! It was a phishing email
        currentStreak = 0;
        showReason = true;
      }
    });
  }

  void _handleTryAgain() {
    setState(() {
      currentEmailIndex = Random().nextInt(emails.length);
      showReason = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // PhishTest Header
              SizedBox(
                height: 180,
                child: Image.asset('assets/images/PhishTestLogo.png'),
              ),
              const SizedBox(height: 8.0),

              // How to Play Button
              SizedBox(
                width: 150,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  icon: const Icon(Icons.help_outline),
                  label: const Text('How to Play'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // Current Streak
              Text(
                'Current Streak: $currentStreak',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 100.0),

              // Email Display
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    width: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.blue.shade400,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  child: Column(
                    children: [
                      // Email Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From: ${emails[currentEmailIndex].sender}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  'To: You',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(width: 8.0),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Email Content
                      Container(
                        constraints: const BoxConstraints(
                          maxHeight: 300,
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            emails[currentEmailIndex].content,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ),
              ),
              const SizedBox(height: 32.0),

              // Reason Text Box (if user chooses the wrong answer)
              if (showReason)
                Container(
                  width: 600,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    border: Border.all(
                      color: Colors.red.shade400,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    emails[currentEmailIndex].reason,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.red.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),

              if (showReason) const SizedBox(height: 32.0),

              // Action Buttons or Try Again Button
              if (!showReason)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  // Flag Button
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade500,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.shade500.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _handleFlag,
                        borderRadius: BorderRadius.circular(40),
                        child: Center(
                          child: Text(
                            'Flag',
                            style:
                                Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 32.0),

                  // Good Button
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade500,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade500.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _handleGood,
                        borderRadius: BorderRadius.circular(40),
                        child: Center(
                          child: Text(
                            'Good',
                            style:
                                Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //Try Again Button
              if (showReason)
                Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: _handleTryAgain,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Text(
                        'Try Again',
                        style:
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                                  fontSize: 16.0,
                                ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
