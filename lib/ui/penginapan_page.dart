import 'package:flutter/material.dart';
import 'package:responsi_uts_pemob/bloc/logout_bloc.dart';
import 'package:responsi_uts_pemob/bloc/penginapan_bloc.dart';
import 'package:responsi_uts_pemob/model/penginapan.dart';
import 'package:responsi_uts_pemob/ui/login_page.dart';
import 'package:responsi_uts_pemob/ui/detail_penginapan.dart';
import 'package:responsi_uts_pemob/ui/penginapan_form.dart';

class PenginapanPage extends StatefulWidget {
  const PenginapanPage({Key? key}) : super(key: key);

  @override
  _PenginapanPageState createState() => _PenginapanPageState();
}

class _PenginapanPageState extends State<PenginapanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Penginapan'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PenginapanForm()), // Removed 'const'
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                  );
                });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Penginapan>>(
        future: PenginapanBloc.getPenginapan(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? ListPenginapan(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListPenginapan extends StatelessWidget {
  final List<Penginapan>? list;

  const ListPenginapan({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return ItemPenginapan(penginapan: list![i]);
      },
    );
  }
}

class ItemPenginapan extends StatelessWidget {
  final Penginapan penginapan;

  const ItemPenginapan({Key? key, required this.penginapan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PenginapanDetail(penginapan: penginapan),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(penginapan.accommodation!), // Corrected property
          subtitle: Text(penginapan.rate.toString()), // Corrected property
          trailing: Text(penginapan.room!), // Corrected property
        ),
      ),
    );
  }
}
