import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SendEmail extends StatefulWidget {
  Map admin;
  var adminkey;
  SendEmail(this.adminkey, this.admin, {Key? key}) : super(key: key);

  @override
  State<SendEmail> createState() => _SendEmailState(this.adminkey, this.admin);
}

class _SendEmailState extends State<SendEmail> {
  _SendEmailState(this.adminkey, this.singleadmin) {}
  Map singleadmin;
  var adminkey;
  final _formKey = GlobalKey<FormState>();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  Future SendMail({
    required String toEmail,
    required String subject,
    required String message,
  }) async {
    final Uri mail = Uri.parse(toEmail);

    final Uri subdata = Uri.parse(subject);
    final Uri messagedata = Uri.parse(message);

    final url = 'mailto: $mail?subject=$subdata&body=$messagedata';
    final Uri link = Uri.parse(url);

    if (await canLaunchUrl(link)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 145, 170),
        title: const Text(
          "Send Email",
          textAlign: TextAlign.center,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 10, 0),
              child: TextFormField(
                initialValue: '${singleadmin["admin_email"]}',
                decoration: const InputDecoration(
                  labelText: 'To',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.person),
                ),
                readOnly: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 10, 0),
              child: TextFormField(
                controller: subject,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.subject),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Subject';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 10, 0),
              child: TextFormField(
                controller: message,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  hintText: 'detail of your shop',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.message),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Message detail';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 2, 145, 170),
                    minimumSize: const Size.fromHeight(40),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SendMail(
                        toEmail: singleadmin["admin_email"],
                        subject: subject.text,
                        message: message.text,
                      );
                    }
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
