# Panduan Pengembang MATLAB-004

Panduan ini akan membantu Anda memahami kode sumber MATLAB-004 dan bagaimana mengubah atau memperluas fungsionalitasnya.

## Struktur Kode

Kode MATLAB-004 terdiri dari skrip utama `main.m` yang menjalankan algoritma optimasi, dan beberapa fungsi tambahan yang mendukung algoritma tersebut.

### Fungsi Utama

- `main.m`: Skrip utama yang menginisialisasi parameter algoritma, menjalankan algoritma, dan menampilkan hasil.

### Fungsi Pendukung

- `init_populasi.m`: Membuat populasi awal untuk algoritma genetika.
- `init_pso.m`: Menginisialisasi partikel untuk algoritma optimasi swarm partikel.
- `seleksi_roulette_wheel.m`: Melakukan seleksi orang tua menggunakan metode roda roulette.
- `crossover.m`: Melakukan crossover antara orang tua untuk menghasilkan keturunan.
- `mutasi.m`: Melakukan mutasi pada keturunan.
- `eval_fitness.m`: Menghitung nilai fitness untuk setiap partikel.
- `update_pso.m`: Memperbarui posisi dan kecepatan partikel dalam algoritma PSO.

## Cara Mengubah Parameter Algoritma

Untuk mengubah parameter algoritma seperti jumlah iterasi, ukuran populasi, atau batasan variabel, Anda dapat mengedit nilai-nilai berikut dalam skrip `main.m`:

- `max_iterasi`: Jumlah iterasi maksimum.
- `popsize`: Ukuran populasi.
- `pc`: Probabilitas crossover.
- `pm`: Probabilitas mutasi.
- `lb_a`, `ub_a`, `lb_q`, `ub_q`, `lb_l`, `ub_l`: Batasan untuk variabel a, q, dan l.

## Cara Menambahkan Fungsi Tambahan

Untuk menambahkan fungsionalitas baru ke kode, Anda dapat membuat fungsi tambahan dalam file `.m` terpisah dan memanggilnya dari `main.m` atau fungsi lain yang relevan. Pastikan untuk menambahkan dokumentasi singkat dalam kode baru yang menjelaskan apa yang dilakukan oleh fungsi tersebut.
