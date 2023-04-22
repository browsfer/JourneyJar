import 'package:flutter/material.dart';
import 'package:my_favorite_places/screens/places_list_screen.dart';

class CountrySelectionScreen extends StatefulWidget {
  static const routeName = '/country-selection';

  @override
  _CountrySelectionScreenState createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  List<String> _europeanCountries = [
    'Albania',
    'Andorra',
    'Austria',
    'Belarus',
    'Belgium',
    'Bosnia and Herzegovina',
    'Bulgaria',
    'Croatia',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Estonia',
    'Finland',
    'France',
    'Germany',
    'Greece',
    'Hungary',
    'Iceland',
    'Ireland',
    'Italy',
    'Kosovo',
    'Latvia',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Malta',
    'Moldova',
    'Monaco',
    'Montenegro',
    'Netherlands',
    'North Macedonia',
    'Norway',
    'Poland',
    'Portugal',
    'Romania',
    'Russia',
    'San Marino',
    'Serbia',
    'Slovakia',
    'Slovenia',
    'Spain',
    'Sweden',
    'Switzerland',
    'Ukraine',
    'United Kingdom',
    'Vatican City'
  ];

  List<String> _filteredCountries = [];

  void _filterCountries(String query) {
    setState(() {
      _filteredCountries = _europeanCountries
          .where((country) =>
              country.toLowerCase().contains(query.trim().toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a country'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search for a country',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterCountries,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCountries.isEmpty
                  ? _europeanCountries.length
                  : _filteredCountries.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: _filteredCountries.isEmpty
                      ? Text(
                          _europeanCountries[index],
                        )
                      : Text(_filteredCountries[index]),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(PlacesListScreen.routeName);
                    // Later every screen will have places assigned
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
