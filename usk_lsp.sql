-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 03 Mar 2023 pada 17.55
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `usk_lsp`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id` int(11) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `id_penerbit` int(11) NOT NULL,
  `tahun_terbit` year(4) NOT NULL,
  `isbn` char(20) NOT NULL,
  `j_buku_baik` int(100) NOT NULL,
  `j_buku_rusak` int(100) NOT NULL,
  `pengarang` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id`, `judul`, `id_kategori`, `id_penerbit`, `tahun_terbit`, `isbn`, `j_buku_baik`, `j_buku_rusak`, `pengarang`) VALUES
(1, 'Tate No Yusha', 1, 1, 2019, '232313', 6, 4, 'Bukan Sya'),
(2, 'Maou Demon Kingkong', 1, 1, 2019, '163537573', 10, 2, 'Adi jaya Pura'),
(3, 'Naruto ', 3, 3, 2008, '4234224', 9, 1, 'Masha Kishimoto'),
(4, 'Seven Deadly Sin', 2, 3, 2019, '3552234', 9, 5, 'andrea henata\r\n');

-- --------------------------------------------------------

--
-- Struktur dari tabel `identitas`
--

CREATE TABLE `identitas` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `email` varchar(100) NOT NULL,
  `nomor_hp` char(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `kode` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id`, `kode`, `nama`) VALUES
(1, 'K001', 'Anime'),
(2, 'K002', 'Fantasy\r\n'),
(3, 'K003', 'Action');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemberitahuan`
--

CREATE TABLE `pemberitahuan` (
  `id` int(11) NOT NULL,
  `isi` text NOT NULL,
  `level` enum('admin','user') NOT NULL,
  `status` enum('aktif','nonaktif') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pemberitahuan`
--

INSERT INTO `pemberitahuan` (`id`, `isi`, `level`, `status`) VALUES
(51, 'BUKU Tate No Yusha SEDANG DI PINJAM OLEH Adi (Prime)', 'admin', 'aktif'),
(52, 'BUKU Tate No Yusha SEDANG DI PINJAM OLEH Adi (Prime)', 'admin', 'aktif'),
(53, 'BUKU Tate No Yusha SEDANG DI PINJAM OLEH Adi (Prime)', 'admin', 'aktif'),
(54, 'BUKU Tate No Yusha SEDANG DI PINJAM OLEH Adi (Prime)', 'admin', 'aktif');

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_buku` int(11) NOT NULL,
  `tanggal_peminjaman` datetime NOT NULL,
  `tanggal_pengembalian` datetime DEFAULT NULL,
  `kondisi_buku_saat_dipinjam` enum('baik','rusak') NOT NULL,
  `kondisi_buku_saat_dikembalikan` enum('baik','rusak') DEFAULT NULL,
  `denda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`id`, `id_user`, `id_buku`, `tanggal_peminjaman`, `tanggal_pengembalian`, `kondisi_buku_saat_dipinjam`, `kondisi_buku_saat_dikembalikan`, `denda`) VALUES
(70, 2, 1, '2023-02-13 00:00:00', '2023-02-13 00:00:00', 'baik', '', 0),
(71, 2, 2, '2023-02-13 00:00:00', '2023-02-13 00:00:00', '', 'rusak', 100000),
(72, 2, 1, '2023-02-13 00:00:00', '2023-02-13 00:00:00', 'baik', 'rusak', 100000),
(73, 2, 1, '2023-03-01 00:00:00', NULL, 'baik', NULL, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `penerbit`
--

CREATE TABLE `penerbit` (
  `id` int(11) NOT NULL,
  `kode` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `verif` varchar(100) NOT NULL DEFAULT 'Verified'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `penerbit`
--

INSERT INTO `penerbit` (`id`, `kode`, `nama`, `verif`) VALUES
(1, 'P001', 'Sirver Link\r\n', 'Penerbit Terverifikasi'),
(2, 'P002', 'AnimePlex', 'Penerbit Terverifikasi'),
(3, 'P003', 'TV Tokyo', 'Penerbit Terverifikasi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pesan`
--

CREATE TABLE `pesan` (
  `id` int(11) NOT NULL,
  `id_penerima` int(11) NOT NULL,
  `id_pengirim` int(11) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `isi` text NOT NULL,
  `status` enum('terkirim','dibaca') NOT NULL,
  `tanggal_kirim` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pesan`
--

INSERT INTO `pesan` (`id`, `id_penerima`, `id_pengirim`, `judul`, `isi`, `status`, `tanggal_kirim`) VALUES
(1, 2, 1, 'Congratulations', 'Selamat ada mendapatkan mobil vario 125D', 'dibaca', '2023-02-08 01:16:31'),
(2, 2, 1, 'Peringatan', 'Ada hati yang harus di jaga', 'dibaca', '2023-02-09 02:04:24'),
(13, 2, 1, 'adadad', ' adad', 'dibaca', '2023-02-14 00:52:14'),
(14, 2, 1, 'SASSF', ' SWWWF', 'terkirim', '2023-02-14 00:53:41');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `kode` varchar(100) NOT NULL,
  `nis` char(50) DEFAULT NULL,
  `fullname` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `kelas` varchar(50) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `verif` varchar(100) NOT NULL DEFAULT 'akun terverifikasi',
  `role` enum('admin','user') NOT NULL,
  `foto` text DEFAULT NULL,
  `join_date` datetime NOT NULL,
  `terakhir_login` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `kode`, `nis`, `fullname`, `username`, `password`, `kelas`, `alamat`, `verif`, `role`, `foto`, `join_date`, `terakhir_login`) VALUES
(1, 'A001', '', 'Adi Syahputra', 'Sya', '123', '', '', 'akun terverifikasi', 'admin', '../assets/images20230213131703', '2023-02-13 03:22:34', '2023-02-13 03:22:34'),
(2, 'U002', '0074', 'Adi (Prime)', 'Adi', '123', 'XII', 'Depok', 'akun terverifikasi', 'user', '', '2023-02-13 12:00:00', '2023-02-13 03:22:34'),
(10, '', '0106', 'Sarifah nur Khotimah', ' Fafah', '123', 'xii', 'depok', 'akun terverifikasi\n', 'user', NULL, '2023-02-13 15:43:02', '0000-00-00 00:00:00'),
(11, '', '0075', 'Andre', ' Adr', '123', NULL, NULL, 'unverified', 'user', NULL, '2023-02-14 00:02:03', '0000-00-00 00:00:00'),
(12, '', '0106', 'Dfqqw', ' sdd', '123', NULL, NULL, 'unverified', 'user', NULL, '2023-02-14 00:13:44', '0000-00-00 00:00:00'),
(13, '', '0074', 'Adi Syahputr6', ' Adst', '123', NULL, NULL, 'unverified', 'user', NULL, '2023-02-14 00:17:49', '0000-00-00 00:00:00'),
(14, '', '05780', 'Dimaz', ' Dimas', '1234', NULL, NULL, 'unverified', 'user', NULL, '2023-02-14 00:20:35', '0000-00-00 00:00:00'),
(15, '', '0074', 'syauqi', ' oqi', '123', '', '', 'verified', 'user', NULL, '2023-02-14 07:28:07', '0000-00-00 00:00:00'),
(16, '', '0074', 'Adi Syahputra', 'Adi', '123', NULL, NULL, 'unverified', 'user', NULL, '2023-02-14 08:22:32', '0000-00-00 00:00:00'),
(17, '', '0074', 'Adi jkwjnj', 'Adis', '123', NULL, NULL, 'unverified', 'user', NULL, '2023-02-14 08:23:06', '0000-00-00 00:00:00'),
(18, '', '0074', 'Adi jkwjnj', 'Adis', '123', NULL, NULL, 'unverified', 'user', NULL, '2023-02-14 08:23:11', '0000-00-00 00:00:00'),
(19, '', '111', 'tin', ' tin', 'anj', NULL, NULL, 'unverified', 'user', NULL, '2023-02-14 08:30:58', '0000-00-00 00:00:00'),
(20, '', '0074', 'Fadil pa', ' jra', '123', '', '', 'akun terverifikasi', 'user', '', '2023-02-14 00:00:00', '0000-00-00 00:00:00'),
(21, '8249', '783264', 'Fadil pa', ' Kon', '490', 'X-RPL', 'Depok', 'akun terverifikasi', 'user', '', '2023-02-14 00:00:00', '0000-00-00 00:00:00'),
(22, 'U888', '0074', 'Adi Syahputra', 'Adi Syahputra', 'adst', 'XII-RPL', 'Depok', 'akun terverifikasi', 'user', NULL, '2023-02-14 14:59:39', '2023-02-14 14:59:39');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kategori` (`id_kategori`),
  ADD KEY `id_penerbit` (`id_penerbit`);

--
-- Indeks untuk tabel `identitas`
--
ALTER TABLE `identitas`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pemberitahuan`
--
ALTER TABLE `pemberitahuan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_buku` (`id_buku`);

--
-- Indeks untuk tabel `penerbit`
--
ALTER TABLE `penerbit`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pesan`
--
ALTER TABLE `pesan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_penerima` (`id_penerima`),
  ADD KEY `id_pengirim` (`id_pengirim`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `identitas`
--
ALTER TABLE `identitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `pemberitahuan`
--
ALTER TABLE `pemberitahuan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT untuk tabel `penerbit`
--
ALTER TABLE `penerbit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `pesan`
--
ALTER TABLE `pesan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD CONSTRAINT `buku_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`),
  ADD CONSTRAINT `buku_ibfk_2` FOREIGN KEY (`id_penerbit`) REFERENCES `penerbit` (`id`);

--
-- Ketidakleluasaan untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Ketidakleluasaan untuk tabel `pesan`
--
ALTER TABLE `pesan`
  ADD CONSTRAINT `pesan_ibfk_2` FOREIGN KEY (`id_pengirim`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `pesan_ibfk_3` FOREIGN KEY (`id_penerima`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
