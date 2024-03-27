import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final Function(BuildContext context) onSelected;

  MenuItem({required this.title, required this.onSelected});
}

class HelpMenu extends StatefulWidget {
  final List<MenuItem> items;
final Function(MenuItem) onItemSelected;
  HelpMenu({required this.items, required this.onItemSelected});

  @override
  _HelpMenuState createState() => _HelpMenuState();
}

class _HelpMenuState extends State<HelpMenu> {
  bool _showForm = false;

  @override
  Widget build(BuildContext context) {
    return _showForm
        ? Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                // Your form widgets here
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('FAQ Form'),
                    // Your form fields here
                  ],
                ),
              ),
            ),
          )
        : ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.items[index].title),
                onTap: () {
                  setState(() {
                  //  widget.items[index].onSelected(context);
                  widget.onItemSelected(widget.items[index]);
                  });
                },
              );
            },
          );
  }
}

// class HomePage extends StatelessWidget {
//   final List<MenuItem> _helpMenuItems = [
//     MenuItem(
//         title: 'FAQs',
//         onSelected: (BuildContext context) {
//           print('FAQs clicked');
//           // Set _showForm to true to show the form
//           // setState(() {
//           //   _showForm = true;
//           // });
//         }),
//     MenuItem(
//         title: 'Contact Us',
//         onSelected: (BuildContext context) => print('Contact Us clicked')),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: HelpMenu(items: _helpMenuItems),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HomePage(),
//   ));
// }