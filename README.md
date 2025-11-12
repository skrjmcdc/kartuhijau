# Kartuhijau

**Nama:** Muhammad Ibaadi Ilmi  
**NPM:** 2406357684  
**Kelas:** PBP A

# Tugas 7

## `Navigator.push()` vs. `Navigator.pushReplacement()`

Dalam Flutter, Navigator bekerja sebagai suatu stack, di mana halaman yang baru diakses akan di-push ke atas stack, sedangkan setiap pengguna meng-klik tombol untuk kembali ke halaman "sebelumnya", maka halaman teratas akan di-pop dari stack.

Perbedaan `Navigator.push()` dengan `Navigator.pushReplacement()`, yaitu `push()` bekerja seperti operasi push pada umumnya, sehingga halaman yang baru diakses akan diletakkan di bagian atas stack. Sedangkan `pushReplacement()` justru *mengganti* halaman teratas di stack dengan halaman yang baru diakses, sehingga `pushReplacement()` seolah-olah mem-pop halaman teratas, baru mem-push halaman yang akan diakses.

## Hierarchy widget

Berikut pemanfaatan hierarchy widget dalam aplikasi:
- `Scaffold`: Saya menggunakannya sebagai kerangka dasar untuk setiap halaman. Seluruh widget dalam setiap halaman akan termuat dalam widget ini. Selanjutnya saya tinggal menggunakannya sebagai widget dasar setiap halaman.
- `AppBar`: Saya mengguunakannya untuk membuat header yang akan muncul di bagian atas setiap halaman. Selanjutnya saya tinggal menambahkan bar tersebut pada Scaffold masing-masing halaman.
- `Drawer`: Saya menggunakannya untuk membuat elanjutnya saya tinggal menambahkan drawer tersebut tersebut pada Scaffold masing-masing halaman.

## Layout widget dalam form

Kelebihan menggunakan layout widget saat menampilkan elemen-elemen form yaitu kita dapat mengatur penempatan setiap widget dalam form. Sedangkan jika kita hanya menggunakan widget-widget form secara langsung, maka hasilnya akan terlihat jelek karena kita tidak bisa mengatur layout-nya. Misalnya, saya menggunakan `ListView` sebagai container setiap widget field dalam form agar pengguna bisa men-scroll seluruh widget jika tidak muat di layar.

## Warna tema

Sesuai dengan nama aplikasi, saya menggunakan warna tema hijau (`Colors.green`).

# Tugas 6

## Apa itu widget tree?

Widget tree merupakan representasi logical dari setiap widget dalam user interface.
Dalam Flutter, children dari suatu widget yaitu widget-widget yang muncul dalam method `build` widget tersebut. Widget parent bertugas mengatur layout dan positioning setiap anaknya.

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
