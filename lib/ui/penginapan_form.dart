import 'package:flutter/material.dart';
import 'package:responsi_uts_pemob/bloc/penginapan_bloc.dart'; // Ensure you have this import
import 'package:responsi_uts_pemob/model/penginapan.dart';
import 'package:responsi_uts_pemob/ui/penginapan_page.dart';
import 'package:responsi_uts_pemob/widget/warning_dialog.dart'; // Import your warning dialog

// ignore: must_be_immutable
class PenginapanForm extends StatefulWidget {
  Penginapan? penginapan;

  PenginapanForm({Key? key, this.penginapan}) : super(key: key);

  @override
  _PenginapanFormState createState() => _PenginapanFormState();
}

class _PenginapanFormState extends State<PenginapanForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PENGINAPAN";
  String tombolSubmit = "SIMPAN";

  final _accommodationTextboxController = TextEditingController();
  final _roomTextboxController = TextEditingController();
  final _rateTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.penginapan != null) {
      setState(() {
        judul = "UBAH PENGINAPAN";
        tombolSubmit = "UBAH";
        _accommodationTextboxController.text = widget.penginapan!.accommodation!;
        _roomTextboxController.text = widget.penginapan!.room!;
        _rateTextboxController.text = widget.penginapan!.rate.toString();
      });
    } else {
      judul = "TAMBAH PENGINAPAN";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _accommodationTextField(),
                _roomTextField(),
                _rateTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Creating Textbox for Accommodation
  Widget _accommodationTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Accommodation"),
      keyboardType: TextInputType.text,
      controller: _accommodationTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Accommodation harus diisi";
        }
        return null;
      },
    );
  }

  // Creating Textbox for Room
  Widget _roomTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Room"),
      keyboardType: TextInputType.text,
      controller: _roomTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Room harus diisi";
        }
        return null;
      },
    );
  }

  // Creating Textbox for Rate
  Widget _rateTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Rate"),
      keyboardType: TextInputType.number,
      controller: _rateTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Rate harus diisi";
        }
        return null;
      },
    );
  }

  // Creating Save/Update Button
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.penginapan != null) {
              // Update penginapan logic
              ubah();
            } else {
              // Add new penginapan logic
              simpan();
            }
          }
        }
      },
    );
  }

  // Method for saving new penginapan
  simpan() {
    setState(() {
      _isLoading = true;
    });

    Penginapan createPenginapan = Penginapan(id: null);
    createPenginapan.accommodation = _accommodationTextboxController.text;
    createPenginapan.room = _roomTextboxController.text;
    createPenginapan.rate = int.parse(_rateTextboxController.text);

    PenginapanBloc.addPenginapan(penginapan: createPenginapan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const PenginapanPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ));
    });

    setState(() {
      _isLoading = false;
    });
  }

  // Method for updating existing penginapan
  ubah() {
    setState(() {
      _isLoading = true;
    });

    // Create an instance of Penginapan for updating
    Penginapan updatePenginapan = Penginapan(id: widget.penginapan!.id!);
    updatePenginapan.accommodation = _accommodationTextboxController.text;
    updatePenginapan.room = _roomTextboxController.text;
    updatePenginapan.rate = int.parse(_rateTextboxController.text); // Ensure this is safely parsed

    // Call the update function in your Bloc
    PenginapanBloc.updatePenginapan(penginapan: updatePenginapan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const PenginapanPage(), // Replace with your destination page
      ));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ));
    });

    setState(() {
      _isLoading = false;
    });
  }
}
