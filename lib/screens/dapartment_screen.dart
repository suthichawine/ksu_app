import 'package:flutter/material.dart';

class DepartmentScreen extends StatefulWidget {
  final String message;

  DepartmentScreen({Key? key, required this.message}) : super(key: key);

  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  // Mock data for departments
  final List<Map<String, String>> departments = [
    {'department_name': 'Computer Science', 'faculty_id': '001'},
    {'department_name': 'Information Technology', 'faculty_id': '002'},
    {'department_name': 'Mechanical Engineering', 'faculty_id': '003'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.message),
      ),
      body: departments.isEmpty
          ? Center(child: Text('No department found.'))
          : ListView.builder(
              itemCount: departments.length,
              itemBuilder: (context, index) {
                var department = departments[index];
                var departmentName = department['department_name'] ?? 'Unknown Department';

                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4,
                  child: ListTile(
                    title: Text(departmentName),
                    subtitle: Text('Faculty ID: ${department['faculty_id']}'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PLOScreen(departmentName: departmentName),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class PLOScreen extends StatefulWidget {
  final String departmentName;

  PLOScreen({Key? key, required this.departmentName}) : super(key: key);

  @override
  _PLOScreenState createState() => _PLOScreenState();
}

class _PLOScreenState extends State<PLOScreen> {
  final TextEditingController _controllerPLO = TextEditingController();
  // Mock data for PLOs
  final List<String> plos = ['PLO 1', 'PLO 2', 'PLO 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PLOs of ${widget.departmentName}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerPLO,
              decoration: InputDecoration(labelText: 'Enter PLO'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controllerPLO.text.isNotEmpty) {
                setState(() {
                  plos.add(_controllerPLO.text);
                });
                _controllerPLO.clear();
              }
            },
            child: Text('Add PLO'),
          ),
          Expanded(
            child: plos.isEmpty
                ? Center(child: Text('No PLO data found.'))
                : ListView.builder(
                    itemCount: plos.length,
                    itemBuilder: (context, index) {
                      var ploText = plos[index];

                      return ListTile(
                        title: Text(ploText),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(ploText, index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  plos.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(String oldPLO, int index) {
    TextEditingController _editController =
        TextEditingController(text: oldPLO);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit PLO'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(labelText: 'PLO'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  plos[index] = _editController.text;
                });
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
