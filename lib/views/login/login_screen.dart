import 'package:flutter/material.dart';
import 'package:space_legends/views/login/widgets/signin.dart';
import 'package:space_legends/views/login/widgets/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  bool init = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(initialIndex: 0, length: 2, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            init = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset('assets/images/f2.jpeg', fit: BoxFit.cover),
          ),
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black])),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1300),
            right: init ? size.width * .1 : (size.width * 0.8) * -1,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2400),
              opacity: init ? 1.0 : 0.0,
              child: Container(
                height: size.width * 1.6,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TabBar(
                            controller: _controller,
                            indicatorColor:
                                const Color.fromARGB(255, 235, 83, 72),
                            // indicator: BoxDecoration(borderRadius: BorderRadius.circular(2), ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: const [
                              Padding(
                                padding: EdgeInsets.only(bottom: 9.0),
                                child: Text('Login'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 9.0),
                                child: Text('Register'),
                              ),
                            ]),
                        SizedBox(
                          height: size.width * 1.38,
                          child: TabBarView(
                            controller: _controller,
                            children: const [SignIn(), SignUp()],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
