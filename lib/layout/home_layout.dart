import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/modules/auth_view.dart';
import 'package:school/modules/entering_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex=0;
  bool x=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مصنع خرسانة'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap:(index){
          setState(() {
            currentIndex=index;
            if(index==1){
              SystemNavigator.pop();
            }
            }
          );
        },
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.logout),label: 'تسجيل الخروج'),
          BottomNavigationBarItem(icon: Icon(Icons.close),label: 'خروج'),
        ],
      ),
    );

  }
}
