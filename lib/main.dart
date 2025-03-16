import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_index_provider.dart';
import 'dashboard.dart';
import 'port_view.dart';
import 'data_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load flight data once at app startup
  final flightData = await FlightDataLoader.loadCsvData();

  runApp(
    ChangeNotifierProvider(
      create: (context) {
        final provider = DataIndexProvider();
        provider.setFlightData(flightData); // Set the data once
        provider.startIteration(); // Start the iteration loop
        return provider;
      },
      child: const FlightDataApp(),
    ),
  );
}

class FlightDataApp extends StatelessWidget {
  const FlightDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'thrustMIT Plotter | IREC 2025',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // Removed the resetIndex() call to prevent resetting data on screen switch
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    // Stop the data iteration when the app is closed
    Provider.of<DataIndexProvider>(context, listen: false).stopIteration();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('thrustMIT | Vayuvega | Data Plotter'),
        forceMaterialTransparency: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.orangeAccent,
            height: 4.0,
          ),
        ),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        width: 180,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 60,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.orangeAccent),
                child: Text('Navigation', style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.preview),
              title: const Text('Port View'),
              onTap: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0 ? const DashboardScreen() : const PortViewScreen(),
    );
  }
}
