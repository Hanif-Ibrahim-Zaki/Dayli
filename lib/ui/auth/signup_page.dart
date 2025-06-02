part of '../pages.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isObscureText = true;

  bool isLoading = false;

  final _auth = FirebaseService();

  final _firebaseStore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordConfirmController = TextEditingController();

  void _signUp() async {
      if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = true;
    });

    try {
      print("Attempting signup with email: ${emailController.text} and password: ${passwordController.text}");

      User? user = await _auth.signUp(emailController.text, passwordController.text);


      if (user == null) {
        throw Exception("Signup failed: User is null.");
      }

      print("User UID: ${user.uid}");

      await _firebaseStore.collection('users').doc(user.uid).set({
        'email': emailController.text,
        'username': userNameController.text,
      });

      print("User data saved to Firestore.");

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print("Error during signup: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[900],
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Appname('Make an account'),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.yellow[700],
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2))),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    enableSuggestions: true,
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  TextFormField(
                    controller: userNameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
        
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.yellow[700],
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2))),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    enableSuggestions: true,
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  TextFormField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.yellow[700],
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    enableSuggestions: true,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  TextFormField(
                    controller: passwordConfirmController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.yellow[700],
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    enableSuggestions: true,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _signUp();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Make Account',
                            style:
                                hintTextStyle.copyWith(color: Colors.yellow[700]),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.yellow[700],
                            size: 19,
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                        side: BorderSide(color: Colors.yellow.shade700, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.3),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Already have an account?',
                    style: hintTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign-in');
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign In',
                            style:
                                hintTextStyle.copyWith(color: Colors.yellow[700]),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.login_outlined,
                            color: Colors.yellow[700],
                            size: 19,
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                        side: BorderSide(color: Colors.yellow.shade700, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
