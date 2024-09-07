import 'package:expense_tracker/constanta.dart';
import 'package:expense_tracker/navigation.dart';
import 'package:expense_tracker/service/auth_service/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> doRegister(
    String username,
    String email,
    String password,
  ) async {
    try {
      Map<String, dynamic> response =
          await AuthService().register(username, email, password);

      if (response['status'] == false && mounted) {
        String errorMsg = "";

        if (response['error']['username'] != null) {
          errorMsg += response['error']['username'][0] + "\n";
        }

        if (response['error']['email'] != null) {
          errorMsg += response['error']['email'][0] + "\n";
        }

        if (response['error']['password'] != null) {
          errorMsg += response['error']['password'][0];
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          errorMsg,
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        )));
        return;
      }

      if (!mounted) {
        return;
      }
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const Navigation();
      }));
    } on Exception catch (_) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Register Page',
                style: GoogleFonts.openSans(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.primary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: "Username",
                  hintStyle: GoogleFonts.openSans(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 151, 151, 151),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: "Email",
                  hintStyle: GoogleFonts.openSans(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 151, 151, 151),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: "Password",
                  hintStyle: GoogleFonts.openSans(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 151, 151, 151),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  doRegister(usernameController.text, emailController.text,
                      passwordController.text);
                },
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: ColorConstant.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Register',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  children: [
                    TextSpan(
                      text: 'Already have an account?',
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: ColorConstant.primary,
                      ),
                    ),
                    TextSpan(
                      text: ' Login here!',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
