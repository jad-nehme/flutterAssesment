import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nft_project/screens/nft_details.dart';

class NftListScreen extends StatefulWidget {
  const NftListScreen({super.key});

  @override
  State<NftListScreen> createState() => _NftListScreenState();
}

class _NftListScreenState extends State<NftListScreen> {
  var nfts = [];
  void loadNft() async {
    final url = Uri.https("api.coingecko.com", "/api/v3/nfts/list");

    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        nfts = json.decode(response.body);
      });
    }
  }

  void navigateToDetails(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NftDetailsScreen(id: id),
      ),
    );
  }

  @override
  void initState() {
    loadNft();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NFTs List")),
      body: nfts.isNotEmpty
          ? Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 235, 233, 233)),
              child: ListView.builder(
                itemCount: nfts.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = nfts[index];
                  return InkWell(
                    onTap: () {
                      navigateToDetails(item['id']);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(colors: [
                            Colors.cyan,
                            Color.fromARGB(255, 183, 183, 185)
                          ])),
                      child: ListTile(
                        leading: Text(
                          item['id'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        title: Text(item['name']),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
