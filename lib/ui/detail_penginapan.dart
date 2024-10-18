import 'package:flutter/material.dart';
import '../bloc/penginapan_bloc.dart'; // Import your bloc for managing penginapan
import '../widget/warning_dialog.dart'; // Import your warning dialog
import '/model/penginapan.dart';
import '/ui/penginapan_form.dart';
import 'penginapan_page.dart'; // Import your main penginapan page

// ignore: must_be_immutable
class PenginapanDetail extends StatefulWidget {
  Penginapan? penginapan;
  PenginapanDetail({Key? key, this.penginapan}) : super(key: key);

  @override
  _PenginapanDetailState createState() => _PenginapanDetailState();
}

class _PenginapanDetailState extends State<PenginapanDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Penginapan'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Accommodation: ${widget.penginapan!.accommodation}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Room: ${widget.penginapan!.room}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Rate: Rp. ${widget.penginapan!.rate}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PenginapanForm(
                  penginapan: widget.penginapan!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.red[400],
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            PenginapanBloc.deletePenginapan(id: widget.penginapan!.id!).then(
                  (value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const PenginapanPage()),
                );
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
