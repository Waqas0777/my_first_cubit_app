import 'package:flutter/material.dart';
import 'package:my_first_cubit_app/main.dart';
import 'package:my_first_cubit_app/model/sharedPreferencesModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences prefs;
  late String? name;
  late String? email;
  late bool? status;

  @override
  void initState() {
    super.initState();
    getPres();
  }

  void getPres() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name");
      email = prefs.getString("email");
      status = prefs.getBool("status");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: ()async{
         return false;
       },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Profile"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Show Snack bar',
              onPressed: () {
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return logout();
                //     });
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                     "Welcome to Profile Screen ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Name :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        getIt<SharedPreferencesModel>().getUserName(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Email :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        getIt<SharedPreferencesModel>().getUserEmail(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
