-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 29 Agu 2020 pada 10.59
-- Versi Server: 10.1.29-MariaDB
-- PHP Version: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u8885352_absenudacoding`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_absent`
--

CREATE TABLE `tb_absent` (
  `id_absent` int(11) NOT NULL,
  `check_in` datetime DEFAULT NULL,
  `check_out` datetime DEFAULT NULL,
  `date_today` date NOT NULL,
  `place` varchar(125) NOT NULL,
  `check_in_by` int(11) NOT NULL,
  `check_out_by` int(11) NOT NULL,
  `jam_kerja` time NOT NULL DEFAULT '00:00:00',
  `lang_loc` varchar(100) NOT NULL,
  `long_loc` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `status` varchar(120) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_role`
--

CREATE TABLE `tb_role` (
  `id_role` int(11) NOT NULL,
  `name_role` varchar(150) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_role`
--

INSERT INTO `tb_role` (`id_role`, `name_role`) VALUES
(1, 'Web Developer'),
(2, 'CEO'),
(3, 'Admin'),
(4, 'Staff');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `fullname_user` varchar(150) NOT NULL,
  `email_user` varchar(150) NOT NULL,
  `phone_user` varchar(50) NOT NULL,
  `photo_user` text NOT NULL,
  `username_user` varchar(150) NOT NULL,
  `password_user` text NOT NULL,
  `id_role` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `fullname_user`, `email_user`, `phone_user`, `photo_user`, `username_user`, `password_user`, `id_role`) VALUES
(1, 'Sample', 'sample@gmail.com', '082385247593', 'download14.jpeg', 'doragrestya', '4297f44b13955235245b2497399d7a93', 1),
(2, 'Rizki Syaputra', 'rizki@udacoding.com', '0823462781937', 'rizki.jpg', 'rizkisyaputra', '4297f44b13955235245b2497399d7a93', 2),
(3, 'Muhammad Ihsan AlJundi', 'ihsan@udacoding.com', '08238237917491', 'ihsan.jpeg', 'ihsan', '4297f44b13955235245b2497399d7a93', 1),
(4, 'Siddiq', 'siddiq@gmail.com', '08228279189', 'dadik.jpg', 'admin', '4297f44b13955235245b2497399d7a93', 3),
(5, 'Imrotul Nurul Jannah', 'nurul@udacoding.com', '0823823812791', 'sample.png', 'Imrotul', '123123', 1),
(6, 'Yusmi Putra', 'yusmi@gmail.com', '082382381279', 'daput.jpg', 'Yusmi Putra', '123123', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_absent`
--
ALTER TABLE `tb_absent`
  ADD PRIMARY KEY (`id_absent`);

--
-- Indexes for table `tb_role`
--
ALTER TABLE `tb_role`
  ADD PRIMARY KEY (`id_role`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_role` (`id_role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_absent`
--
ALTER TABLE `tb_absent`
  MODIFY `id_absent` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `tb_role`
--
ALTER TABLE `tb_role`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
