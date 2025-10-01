import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart' show rootBundle;

class Branch {
  final String name;
  final String bank;
  final LatLng location;
  final String address;

  Branch({required this.name, required this.bank, required this.location, required this.address});
}

class SearchBranchScreen extends StatefulWidget {
  const SearchBranchScreen({super.key});

  @override
  State<SearchBranchScreen> createState() => _SearchBranchScreenState();
}

class _SearchBranchScreenState extends State<SearchBranchScreen> {
  GoogleMapController? mapController;
  LatLng? _userLocation;
  String searchQuery = '';
  Set<String> selectedBanks = {};
  bool _isDark = false;

  final List<String> bankNames = [
    'HBL',
    'MCB',
    'UBL',
    'Meezan Bank',
    'Allied Bank'
  ];

  final List<Branch> allBranches = [
    Branch(
      name: 'HBL Gujranwala Main Branch',
      bank: 'HBL',
      location: LatLng(32.1610, 74.1883),
      address: 'GT Road, Gujranwala, Punjab',
    ),
    Branch(
      name: 'MCB Gujranwala Saddar',
      bank: 'MCB',
      location: LatLng(32.1505, 74.1846),
      address: 'Saddar Bazar, Gujranwala, Punjab',
    ),
    Branch(
      name: 'Meezan Bank Gujranwala',
      bank: 'Meezan Bank',
      location: LatLng(32.1569, 74.1940),
      address: 'Model Town, Gujranwala, Punjab',
    ),
    Branch(
      name: 'UBL Gujranwala Main',
      bank: 'UBL',
      location: LatLng(32.1598, 74.1902),
      address: 'Civil Lines, Gujranwala, Punjab',
    ),
    Branch(
      name: 'Allied Bank Gujranwala',
      bank: 'Allied Bank',
      location: LatLng(32.1572, 74.1895),
      address: 'G.T Road, Gujranwala, Punjab',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  Future<void> _setMapStyle(bool dark) async {
    final stylePath = dark
        ? 'assets/map/map_style_dark.json'
        : 'assets/map/map_style_light.json';
    final styleJson = await rootBundle.loadString(stylePath);
    mapController?.setMapStyle(styleJson);
  }

  List<Branch> get filteredBranches {
    return allBranches.where((branch) {
      final matchesSearch = branch.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          branch.bank.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesBank = selectedBanks.isEmpty || selectedBanks.contains(branch.bank);
      return matchesSearch && matchesBank;
    }).toList();
  }

  Set<Marker> get branchMarkers {
    return filteredBranches.map((branch) {
      return Marker(
        markerId: MarkerId(branch.name),
        position: branch.location,
        infoWindow: InfoWindow(title: branch.name, snippet: branch.address),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: _isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isDark ? Icons.light_mode : Icons.dark_mode,
              color: _isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isDark = !_isDark;
                _setMapStyle(_isDark);
              });
            },
          )
        ],
      ),
      body: _userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
              _setMapStyle(_isDark);
            },
            initialCameraPosition: CameraPosition(
                target: _userLocation!, zoom: 13),
            markers: branchMarkers
              ..add(Marker(
                markerId: const MarkerId('user_location'),
                position: _userLocation!,
                infoWindow: const InfoWindow(title: 'You are here'),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
              )),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.15,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(blurRadius: 10, color: Colors.black26)
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search bank or branch',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: bankNames.map((bank) {
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Text(bank),
                              selected: selectedBanks.contains(bank),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedBanks.add(bank);
                                  } else {
                                    selectedBanks.remove(bank);
                                  }
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: filteredBranches.length,
                        itemBuilder: (context, index) {
                          final branch = filteredBranches[index];
                          return ListTile(
                            title: Text(branch.name),
                            subtitle: Text(branch.address),
                            trailing: Text(branch.bank),
                            onTap: () {
                              mapController?.animateCamera(
                                CameraUpdate.newLatLng(branch.location),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
