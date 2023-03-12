import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Username',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: size.width * 0.025,
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Ex.: spacelegend227#',
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 191, 191, 191)),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(color: Colors.white, width: 0.5))),
        ),
        SizedBox(
          height: size.width * 0.06,
        ),
        const Text(
          'Password',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: size.width * 0.025,
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          decoration: InputDecoration(
              hintText: '********',
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 191, 191, 191)),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon:
                  const Icon(Icons.remove_red_eye_sharp, color: Colors.white),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(color: Colors.white, width: 0.5))),
        ),
        SizedBox(
          height: size.width * 0.07,
        ),
        InkWell(
          onTap: () {
            Modular.to.pushReplacementNamed('/loading/');
          },
          child: Container(
            height: size.width * .13,
            child: const Center(
              child: Text(
                'Sign in',
                style: TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 83, 72),
                borderRadius: BorderRadius.circular(14)),
          ),
        ),
        SizedBox(
          height: size.width * 0.045,
        ),
        const Center(
          child: Text(
            'Forgot password ?',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
