import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _nameList = [];
  List<String> _phoneList = [];

  TextEditingController _name_controller = TextEditingController();
  TextEditingController _phone_controller = TextEditingController();

  void addTask() {
    String name = _name_controller.text.trim();
    String phone = _phone_controller.text.trim();

    if (phone.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Maximum 10 digit allowed!!!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } else if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name and Phone cannot be empty!"),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      setState(() {
        _nameList.add(name);
        _phoneList.add("+880 $phone");
        _name_controller.clear();
        _phone_controller.clear();
      });
    }
  }

  void removeTask(int index) {
    setState(() {
      _nameList.removeAt(index);
      _phoneList.removeAt(index);
    });
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Delete Contact"),
            content: Text("Are you sure you want to delete this contact?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Cancel
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  removeTask(index);
                  Navigator.pop(context);
                },
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List"),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
      ),
      backgroundColor: Colors.blue[100],
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: _name_controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Name",
                labelText: "Name",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phone_controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Phone Number",
                labelText: "Phone Number",
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                prefix: Text(
                  "+880 |  ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => addTask(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Square corners
                  ),
                ),
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _nameList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => _confirmDelete(index),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0, top: 5),
                      child: Card(
                        color: Colors.grey[200],
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            _nameList[index],
                            style: TextStyle(color: Colors.red),
                          ),
                          subtitle: Text(_phoneList[index]),
                          trailing: Icon(Icons.call),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
