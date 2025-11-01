import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Image Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String? _generatedImagePath;

  final String _initialPrompt =
      "Hyper-realistic full-body shot of a 35-year-old man (use my face as 100%accurate reference). He has a modern hairstyle, looks stylish and confident, and is dressed in a khakihoodie, black cargo pants, white shoes, and sleek black sunglasses. He is sitting casually on a customized white-and-black DucatiXDiavel V4 motorcycle. A glossy black helmet rests on the tank of the bike, with his hands placed firmly onit. He is looking straight ahead with a calm, focused expression. The outdoor environment is realistic, natural daylight highlighting the details of the bike and outfit, with cinematic tones and high-end clarity. Signature: AmanZaid Creations. keep my face exactly the same as the uploaded photo. Do not change or edit my face.";

  @override
  void initState() {
    super.initState();
    _promptController.text = _initialPrompt;
  }

  void _generateImage() {
    setState(() {
      _isLoading = true;
      _generatedImagePath = null;
    });

    // Simulate network request
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
        // This would be the path to the generated image.
        // I'll use a placeholder from the web for demonstration.
        _generatedImagePath = 'https://picsum.photos/512/512';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Image Generator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image display area
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey[700]!,
                    ),
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : _generatedImagePath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  _generatedImagePath!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.image_outlined,
                                size: 100,
                                color: Colors.grey,
                              ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Prompt text field
              TextField(
                controller: _promptController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Prompt',
                  hintText: 'Enter your image description...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Upload reference image button
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement image picking logic
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Reference Face'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Generate button
              ElevatedButton(
                onPressed: _isLoading ? null : _generateImage,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Generate Image',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
