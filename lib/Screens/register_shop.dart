import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';

class register_shop extends StatelessWidget {
  const register_shop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          //color:Color(0xFF37474F),
          height: 40,
          //color: Colors.amber[100],
          child: Text(
            "Register Your Shops",
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.black12,
          child: Column(
            children: [
              const Text("Contact Number"),
              const SizedBox(height: 10),
              const Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  const Icon(Icons.contact_phone_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Muhammad Abdullah"),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      FlutterPhoneDirectCaller.callNumber("03062834710");
                    },
                    icon: const Icon(Icons.call_rounded),
                    color: Colors.green,
                    iconSize: 25,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.contact_phone_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Muhammad Javed"),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      FlutterPhoneDirectCaller.callNumber("03024716341");
                    },
                    icon: const Icon(Icons.call_rounded),
                    color: Colors.green,
                    iconSize: 25,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(height: 10),
              const Text("E-mail us"),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.contact_mail_outlined),
                  const SizedBox(width: 10),
                  const Text("chabdullah7650@gmail.com"),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mail),
                    color: Colors.green,
                    iconSize: 25,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.contact_mail_outlined),
                  const SizedBox(width: 10),
                  const Text("javedmughal609@gmail.com"),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mail),
                    color: Colors.green,
                    iconSize: 25,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}
