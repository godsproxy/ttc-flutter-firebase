import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ttc/providers/auth_provider.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

ThemeData themeData = ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.orange,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

FloatingActionButton floatingActionButton = FloatingActionButton(
  onPressed: () {},
  child: const Icon(Icons.add),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAuthProvider()),
      ],
      child: Consumer(
        builder: (BuildContext context, value, Widget? child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Tobacco Club',
          theme: themeData,
          home: const Auth(title: 'The Tobacco Club'),
        ),
      ),
    );
  }
}

class Auth extends StatefulWidget {
  const Auth({super.key, required this.title});

  final String title;

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: MyStatefulWidget(),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _index = 0;
  int _phoneNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          label: const Text('Phone Number'),
          subtitle: const Text('Enter your phone number'),
          title: const Text('Log in or register'),
          content: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const TextField(
              keyboardType: TextInputType.phone,
              smartDashesType: SmartDashesType.enabled,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  icon: Icon(FontAwesomeIcons.phone)),
            ),
          ),
        ),
        const Step(
          title: Text(
              'You should receive a text message shortly. Please enter the code below.'),
          content: TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Code',
            ),
          ),
        ),
      ],
    );
  }
}
