import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  XFile? file;
  ImagePicker _picker = ImagePicker();
  bool upload = false;

  @override
  Widget build(BuildContext context) {
    const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF8F8FF),
        systemNavigationBarColor: Colors.white);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/signup.png"),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sign Up",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter username";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "eg.user_18",
                              label: const Text(
                                "Username",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              prefixIcon: Icon(Icons.person)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: uidController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter UniqueId";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "eg.123",
                              label: const Text(
                                "Unique ID",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              prefixIcon: Icon(Icons.numbers)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter email";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "eg.xyz@gmail.com",
                              label: const Text(
                                "Email ID",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              prefixIcon: Icon(Icons.alternate_email_outlined)),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: branchController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Branch";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "eg.CSE",
                              label: const Text(
                                "Branch",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              prefixIcon: Icon(Icons.account_balance)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            } else if (value.length < 6) {
                              return "Password should be >=6";
                            } else {
                              return null;
                            }
                          },
                          obscureText: passwordVisible == true ? false : true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "length should be >=6",
                              label: Text("Password",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w400)),
                              prefixIcon: Icon(Icons.lock_open),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  child: Icon(passwordVisible == true
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final XFile? photo = await _picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              if (upload == false) {
                                file = photo;
                                upload = true;
                              } else {
                                file = null;
                                upload = false;
                              }
                            });
                          },
                          child: Text("Upload Image"),
                        ),
                        Visibility(
                          visible: file != null,
                          child: file != null
                              ? Image.file(
                                  File(file!.path),
                                  height: 100,
                                  width: 100,
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: SizedBox(
                    height: 55,
                    width: 340,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.deepPurple)),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        )))),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already a member?",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
