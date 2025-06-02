part of '../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userId;
  late Future<Map<String, dynamic>> userData;
  FirebaseService _auth = FirebaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User? user = _auth.currentUser;

    userId = user!.uid;
    userData = _auth.getUserData(userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      appBar: AppBar(
        title: miniAppname('Organize your tasks.'),
        backgroundColor: baseColor,
        
      ),
      body: Builder(builder: (context) {
        return FutureBuilder<Map<String, dynamic>>(
            future: userData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Fetching data...",
                        style: welcomeTextSyle.copyWith(
                            color: Colors.white, fontSize: 25),
                      )
                    ],
                  ),
                );
              }

              if (snapshot.hasError){
                return Center(child: Text('Error fetching data.'),);
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty){
                return Center(child: Text('No data available.'),);
              }
              return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15,),
                  Text("Hey, ${snapshot.data!['username']}!", style: welcomeTextSyle.copyWith(color: Colors.white, fontSize: 30),),
                  SizedBox(height: 5,),
                  Text("What do you wanna check?", style: subWelcomeTextStyle.copyWith(color: Colors.white),),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(

                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                                children: [Iconify(Zondicons.globe, size: 140, color: Colors.black12.withAlpha(46)),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Global Chat', style: GoogleFonts.poppins(
                                              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black, height: 1.0)),
                                          Text('Open discussion', style: GoogleFonts.poppins(
                                              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: GestureDetector(
                          onTap:() {
                              Navigator.pushReplacementNamed(
                                  context, '/todo-home');
                            },
                          child: Container(

                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                Icon(Icons.verified, size: 140, color: Colors.black12.withAlpha(36),),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Todo', style: GoogleFonts.poppins(
                                              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
                                        Text('Check your tasks', style: GoogleFonts.poppins(
                                              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                )
                                ]
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
            });
      }),
    );
  }
}
