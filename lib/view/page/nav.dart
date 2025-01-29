import 'package:flutter/material.dart';

class AppNavigatorPage extends StatelessWidget {
  final Widget child;
  const AppNavigatorPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text("LLaMa App"),
      ),
      drawer: NavigationDrawer(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Text(
                "LLaMa App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.chat),
            label: Text(
              "Chat",
              style: TextStyle(fontSize: 16),
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.history),
            label: Text(
              "History",
              style: TextStyle(fontSize: 16),
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.storage),
            label: Text(
              "Model",
              style: TextStyle(fontSize: 16),
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.settings),
            label: Text(
              "Setting",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: child,
      ),
    );
  }
}
