# Kartuhijau

**Nama:** Muhammad Ibaadi Ilmi  
**NPM:** 2406357684  
**Kelas:** PBP A

# Tugas 6

## Apa itu widget tree?

Widget tree merupakan representasi logical dari setiap widget dalam user interface.

## Penjelasan widget dalam proyek ini
- **`MyApp` (subclass `StatelessWidget`):** Root widget dari aplikasi Kartuhijau.
- **`MaterialApp`:** Melambangkan aplikasi yang menggunakan design language Material Design. Salah satu property-nya yaitu `home`, widget halaman beranda.
- **`MyHomePage` (subclass `StatefulWidget`):** Melambangkan halaman beranda dalam aplikasi Kartuhijau. Widget ini menempati property `home` di root widget.
- **`Scaffold`:** Widget container dalam Material Design.
- **`AppBar`:** Melambangkan *app bar* Material Design.
- **`Center`:** Merupakan widget *layout* yang berfungsi untuk meletakkan child widget-nya di tengah parent widget ini.
- **`Column`:** Widget ini berfungsi untuk menyusun setiap child-nya sejajar secara horizontal.
- **`ElevatedButton`:** Widget *structural* yang melambangkan tombol yang "menonjol" secara visual.
- **`SnackBar`:** Widget ini merepresentasikan sejenis pesan *toast* yang akan muncul di bagian bawah layar.

## Fungsi widget `MaterialApp`


## `StatelessWidget` vs. `StatefulWidget`

## Apa itu `BuildContext`?

## *Hot reload* vs. *hot restart*

Dalam *hot reload*, Flutter akan memuat perubahan kode ke VM dan me-render ulang seluruh widget **tanpa menghilangkan *state* aplikasi**. *Hot restart* mirip dengan *hot reload*, namun Flutter juga me-restart aplikasi seluruhnya, sehingga *state* aplikasi ikut hilang.
