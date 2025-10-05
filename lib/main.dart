import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const GoldSignApp());
}

class GoldSignApp extends StatelessWidget {
  const GoldSignApp({super.key});

  @override
  Widget build(BuildContext context) {
    const maroon = Color(0xFF6B1F22);
    const gold = Color(0xFFF1D38A);

    return MaterialApp(
      title: 'GOLDSIGN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: maroon),
        textTheme: GoogleFonts.notoSansThaiTextTheme(),
        useMaterial3: true,
      ),
      home: const PriceBoardPage(),
    );
  }
}

class PriceBoardPage extends StatelessWidget {
  const PriceBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            return Center(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade800, width: 2),
                ),
                clipBehavior: Clip.antiAlias,
                child:
                    isWide
                        ? Row(
                          children: const [
                            SizedBox(width: 420, child: LeftPanel()),
                            Expanded(child: RightPhoto()),
                          ],
                        )
                        : const Column(
                          children: [
                            SizedBox(height: 560, child: RightPhoto()),
                            SizedBox(height: 12),
                            LeftPanel(),
                          ],
                        ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    const maroon = Color(0xFF6B1F22);
    const gold = Color(0xFFF1D38A);
    final white = Colors.white;

    return Container(
      color: maroon,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: DefaultTextStyle(
        style: GoogleFonts.notoSansThai(color: white, fontSize: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _BrandHeader(),
            const SizedBox(height: 18),
            Center(
              child: Text(
                'ทองคำแท่ง',
                style: GoogleFonts.notoSansThai(
                  color: white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const PriceRow(label: 'รับซื้อ', value: '30,400'),
            const SizedBox(height: 10),
            const PriceRow(label: 'ขายออก', value: '30,500'),
            const SizedBox(height: 26),
            Center(
              child: Text(
                'ทองคำรูปพรรณ',
                style: GoogleFonts.notoSansThai(
                  color: white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const PriceRow(label: 'รับซื้อ', value: '28,880'),
            const SizedBox(height: 10),
            const PriceRow(label: 'ขายออก', value: '31,000'),
            const Spacer(),
            Center(
              child: Text(
                'ข้อมูลล่าสุด ณ วันที่ 10/05/2565 11:03',
                style: GoogleFonts.notoSansThai(
                  color: white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFF1D38A);
    return Column(
      children: [
        Center(
          child: Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: gold,
            ),
            child: const Center(
              child: Text(
                'G',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Column(
            children: [
              Text(
                'GOLDSIGN',
                style: GoogleFonts.montserrat(
                  color: gold,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'ห้างเพชรทองโกลด์ไซน์',
                style: GoogleFonts.notoSansThai(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PriceRow extends StatelessWidget {
  final String label;
  final String value;
  const PriceRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFF1D38A);
    final white = Colors.white;
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: const BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(18)),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansThai(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 7,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RightPhoto extends StatelessWidget {
  const RightPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with an asset image by adding it to pubspec.yaml as shown below.
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Use AssetImage('assets/model.jpg') after adding asset.
          Image.asset(
            'assets/1.webp',
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) {
              return const Center(
                child: Text(
                  'Place your photo at assets/model.jpg',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
          Positioned(
            left: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'GOLDSIGN',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
