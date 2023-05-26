import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NftDetailsScreen extends StatefulWidget {
  const NftDetailsScreen({super.key, required this.id});

  final String id;

  @override
  State<NftDetailsScreen> createState() => _NftDetailsScreenState();
}

class _NftDetailsScreenState extends State<NftDetailsScreen> {
  var nft = {};

  void loadNftDetails() async {
    final url = Uri.https("api.coingecko.com", "/api/v3/nfts/${widget.id}");
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        nft = json.decode(response.body);
      });
    }
    print(nft);
  }

  @override
  void initState() {
    super.initState();
    loadNftDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
      ),
      body: nft.isNotEmpty
          ? SingleChildScrollView(
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nft['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Symbol: ${nft['symbol']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Image.network(
                        nft['image']['small'],
                        height: 200,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        nft['description'],
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Contract Address:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        nft['contract_address'],
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Asset Platform ID:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        nft['asset_platform_id'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
