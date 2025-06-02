part of '.././../pages.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final FirebaseService _firebaseService = FirebaseService();
  bool isImportantAdd = false;
  TextEditingController _titleController = TextEditingController();

  void _addTodo() async {
    if (_titleController.text.isEmpty) {
      return null;
    } else {
      await FirebaseService().addTodo(_titleController.text, isImportantAdd);
    }
  }

  void _deleteTodo(todoId) async {
    await FirebaseService().deleteTodo(todoId);
  }

  void _updateTodo(String todoId, String title, bool isImportant) async {
    _titleController.text = title;
    isImportant = isImportantAdd;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Task',  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.yellow[700])),
              content: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Task Name',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                              BorderSide(color: Colors.amber, width: 2)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                              BorderSide(color: Colors.amber, width: 2))
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          // Add setState here
                          isImportantAdd = !isImportantAdd;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, duration: Duration(seconds: 1),content:
                        Text(isImportantAdd? 'Marked as important' : 'Unmarked as important', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))));
                        print(isImportantAdd);
                      },
                      icon: Iconify(
                        isImportantAdd
                            ? Zondicons.exclamation_solid
                            : Zondicons.exclamation_outline,
                        color: isImportantAdd ? Colors.amber : Colors.white,
                      ))
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.yellow[700])),
                  onPressed: () {
                    Navigator.of(context).pop();
                    isImportantAdd = false;
                  },
                ),
                TextButton(
                  child: Text('Save', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.yellow[700])),
                  onPressed: () {
                    _firebaseService.updateTodo(todoId, _titleController.text, isImportantAdd);
                    _titleController.clear();
                    isImportantAdd = false;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green[800], duration: Duration(seconds: 1),content:
                    Text( 'Plan updated!', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))));
                    Navigator.of(context).pop();
                  },
                ),
              ],
              backgroundColor: baseColor,
            );
          },
        );
      },
    );
  }

  Future<void> _showAddTodoDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: baseColor,
              title: Text('Add New Task', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.yellow[700])),
              content: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Task Title',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            BorderSide(color: Colors.amber, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                            BorderSide(color: Colors.amber, width: 2)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          // Add setState here
                          isImportantAdd = !isImportantAdd;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, duration: Duration(seconds: 1),content:
                        Text(isImportantAdd? 'Marked as important' : 'Unmarked as important', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))));
                        print(isImportantAdd);
                      },
                      icon: Iconify(
                        isImportantAdd
                            ? Zondicons.exclamation_solid
                            : Zondicons.exclamation_outline,
                        color: isImportantAdd ? Colors.amber : Colors.white,
                      ))
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.yellow[700])),
                  onPressed: () {
                    Navigator.of(context).pop();
                    isImportantAdd = false;
                  },
                ),
                TextButton(
                  child: Text('Okay', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.yellow[700])),
                  onPressed: () {
                    _addTodo();
                    _titleController.clear();
                    isImportantAdd = false;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green[800], duration: Duration(seconds: 1),content:
                    Text('Plan added to list', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              "Your awaiting tasks",
              style:
                  welcomeTextSyle.copyWith(color: Colors.white, fontSize: 30),
            ),
            const SizedBox(height: 2.6),
            Text(
              "Your tasks, your commitments.",
              style: subWelcomeTextStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Container(
              height: 580,
              decoration: BoxDecoration(color: Colors.blueAccent.withAlpha(20)),
              child: StreamBuilder<QuerySnapshot>(
                stream: _firebaseService.getTodo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Card(
                      elevation: 9,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(color: baseColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Text(
                                'Your Specific Task',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 150),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.red[700],
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete_forever, size: 15),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 9),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.yellow[700],
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit, size: 15),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Card(
                      elevation: 9,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(color: baseColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.wifi_off,
                                size: 120,
                                color: Colors.yellow[700],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Dayli couldn\'t fetch your notes',
                                style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Check your connection, maybe?',
                                style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white.withAlpha(80)),
                              ),
                            ],
                          )),
                        ),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Card(
                      elevation: 9,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(color: baseColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error,
                                size: 120,
                                color: Colors.yellow[700],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Dayli couldn\'t find your notes!',
                                style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'System\'s Fault?',
                                style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white.withAlpha(80)),
                              ),
                            ],
                          )),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(

                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isDone = false;
                        return StatefulBuilder(
                          builder: (context, setState){
                            return

                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    // Add setState here
                                    isDone = !isDone;
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.amber[500], duration: Duration(seconds: 3),content:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Double tap to complete it', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black)),
                                        Icon(Icons.touch_app, size: 19,)
                                      ],
                                    )));
                                    print(isDone);
                                  });
                                },
                                onDoubleTap: (){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green[800], duration: Duration(seconds: 3),content:
                                  Text('Plan \'${snapshot.data!.docs[index]['title']}\' completed!', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))));
                                  _deleteTodo(
                                      snapshot.data!.docs[index].id);
                                },
                                child: Card(
                                  elevation: 9,
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(color: isDone? Colors.yellow[700]: baseColor),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            isDone?"Complete Task?": snapshot.data!.docs[index]['title'],
                                            style: isDone?GoogleFonts.poppins(
                                                fontSize: 12, fontWeight: FontWeight.w600) : GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: snapshot.data!.docs[index]
                                                ['isImportant']
                                                    ? FontWeight.w500
                                                    : FontWeight.normal,
                                                color: snapshot.data!.docs[index]
                                                ['isImportant']
                                                    ? Colors.red
                                                    : Colors.white),
                                          ),
                                          isDone? Icon(Icons.check, size: 18,): Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, duration: Duration(seconds: 1),content:
                                                  Text(snapshot.data!.docs[index]['isImportant']? 'Important plan deleted!' : 'Plan \'${snapshot.data!.docs[index]['title']}\' deleted!', style: GoogleFonts.poppins(fontWeight: FontWeight.w600))));
                                                  _deleteTodo(
                                                      snapshot.data!.docs[index].id);
                                                },
                                                child: Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[700],
                                                      borderRadius:
                                                      BorderRadius.circular(5)),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.delete_forever,
                                                            size: 15),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 9),
                                              GestureDetector(
                                                onTap: () {
                                                  _updateTodo(
                                                      snapshot.data!.docs[index].id,
                                                      snapshot.data!.docs[index]
                                                      ['title'],
                                                      snapshot.data!.docs[index]
                                                      ['isImportant']);
                                                },
                                                child: Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow[700],
                                                      borderRadius:
                                                      BorderRadius.circular(5)),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.edit, size: 15),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                          }
                        );
                      });
                },
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Cancel',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 9),
                  GestureDetector(
                    onTap: () {
                      _showAddTodoDialog(context);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.add, size: 18),
                            Text(
                              'New Task',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
