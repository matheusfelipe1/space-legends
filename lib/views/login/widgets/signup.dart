import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              hintText: 'spacelegend227#',
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 191, 191, 191)),
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
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
          'E-mail',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: size.width * 0.025,
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'test@gmail.com',
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 191, 191, 191)),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
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
          height: size.width * 0.06,
        ),
        const Text(
          'Confirm password',
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
        Container(
          height: size.width * .13,
          child: const Center(
            child: Text(
              'Sign up',
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 235, 83, 72),
              borderRadius: BorderRadius.circular(14)),
        ),
        SizedBox(
          height: size.width * 0.045,
        ),
      ],
    );
  }
}
