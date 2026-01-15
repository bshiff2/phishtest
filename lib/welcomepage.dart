import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome Heading
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 48.0),
                child: Column(
                  children: [
                    Text(
                      'Hello, and welcome to',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '\nPhishTest',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ],
                ),
              ),

              // How to Play Section
              Text(
                'How to Play',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16.0),

              // Content area for text and images
              Center(
                child: Container(
                  width: 600,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Replace with your text content
                    Text(
                      'This site is designed to help you become more comfortable with identifying potential phishing emails.\nWhen playing, you will be presented with a mock email, and it is your job to deem if it is a phishing attempt by pressing the red "Flag" button, or if you think the email is real and legitimate, press the green "Good" button.\nAt the top will be your streak. If you mark the email correctly, it will increase by one, but be careful, one wrong answer and you\'ll loose it!\nAfter a correct answer, another email will be given, and if you fail to mark a phishing email an explination for why it\'s suspicious will be given.\nPlease remember, this site is to have fun and learn an increasingly important skill in the modern age, so please, have a good time!\nPress the "Play" button below to get started!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16.0),

                    // Replace with your images
                    // Example:
                    // Image.asset('assets/image_name.png'),
                    // const SizedBox(height: 16.0),
                    // Image.asset('assets/another_image.png'),
                  ],
                ),
              ),
              ),

              const SizedBox(height: 48.0),

              // Play Button
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to game page
                      Navigator.of(context).pushNamed('/game');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade200,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      side: BorderSide(
                        color: Colors.green.shade900,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Play',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 16.0,
                            color: Colors.green.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
