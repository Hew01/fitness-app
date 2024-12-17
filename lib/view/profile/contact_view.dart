import 'package:flutter/material.dart';
import '../../common/colo_extension.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/black_btn.png",
            width: 25,
            height: 25,
          ),
        ),
        title: Text(
          "Contact Us",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  children: [
                    ContactItem(
                      icon: Icons.email_outlined,
                      title: "Email",
                      subtitle: "21522007@gm.uit.edu.com",
                    ),
                    ContactItem(
                      icon: Icons.email_outlined,
                      title: "Email",
                      subtitle: "21522007@gm.uit.edu.com",
                    ),
                    ContactItem(
                      icon: Icons.email_outlined,
                      title: "Email",
                      subtitle: "21522007@gm.uit.edu.com",
                    ),
                    const Divider(),
                    ContactItem(
                      icon: Icons.phone_outlined,
                      title: "Phone",
                      subtitle: "+1 (234) 567-8900",
                    ),
                    const Divider(),
                    ContactItem(
                      icon: Icons.location_on_outlined,
                      title: "Address",
                      subtitle: "123 Fitness Street\nHealth City, FL 12345",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Send us a Message",
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Your Name",
                        hintStyle: TextStyle(color: TColor.gray, fontSize: 14),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: TColor.gray.withOpacity(0.3)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: TColor.gray, fontSize: 14),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: TColor.gray.withOpacity(0.3)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Message",
                        hintStyle: TextStyle(color: TColor.gray, fontSize: 14),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: TColor.gray.withOpacity(0.3)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: TColor.primaryColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "Send Message",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ContactItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: TColor.primaryColor1, size: 24),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
