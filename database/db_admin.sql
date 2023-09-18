-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Sep 2023 pada 07.11
-- Versi server: 10.4.25-MariaDB
-- Versi PHP: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_admin`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_absensi`
--

CREATE TABLE `tb_absensi` (
  `kodeabsen` varchar(20) NOT NULL,
  `tglabsen` date NOT NULL,
  `nis` int(11) NOT NULL,
  `keterangan` varchar(10) NOT NULL,
  `semester` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_absensi`
--

INSERT INTO `tb_absensi` (`kodeabsen`, `tglabsen`, `nis`, `keterangan`, `semester`) VALUES
('ABN001', '2023-09-13', 123456789, 'A', 1),
('ABN002', '2023-09-13', 123456789, 'A', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_agenda`
--

CREATE TABLE `tb_agenda` (
  `idagenda` int(11) NOT NULL,
  `idmengajar` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jam_ke` int(2) NOT NULL,
  `idkd` int(11) NOT NULL,
  `keterangan` varchar(30) NOT NULL,
  `status_tgs` int(2) DEFAULT NULL,
  `status_absen` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_agenda`
--

INSERT INTO `tb_agenda` (`idagenda`, `idmengajar`, `tanggal`, `jam_ke`, `idkd`, `keterangan`, `status_tgs`, `status_absen`) VALUES
(4, 13, '2020-12-29', 1, 8, 'Merangkum', 0, ''),
(5, 13, '2020-12-30', 3, 8, 'Tugas', 0, ''),
(6, 23, '2021-01-11', 2, 16, 'mengulas K3LH', 0, ''),
(7, 31, '2023-09-11', 1, 18, 'Test', 0, '1'),
(8, 27, '2023-09-11', 2, 2, 'test2', 0, ''),
(9, 33, '2023-09-13', 2, 21, 'test2', 0, '1'),
(10, 33, '2023-09-12', 5, 23, 'test3', 0, '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_guru`
--

CREATE TABLE `tb_guru` (
  `nip` varchar(30) NOT NULL,
  `kodeguru` varchar(10) DEFAULT NULL,
  `namaguru` varchar(50) NOT NULL,
  `jeniskelamin` varchar(15) NOT NULL,
  `tempatlahir` varchar(25) DEFAULT NULL,
  `tgllahir` date DEFAULT NULL,
  `alamatguru` varchar(80) DEFAULT NULL,
  `notelpseluler` char(15) DEFAULT NULL,
  `emailguru` varchar(30) DEFAULT NULL,
  `kodejurusan` char(10) NOT NULL,
  `kodekelas` varchar(50) NOT NULL,
  `iduser` varchar(20) DEFAULT NULL,
  `tglperbaharui` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` int(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_guru`
--

INSERT INTO `tb_guru` (`nip`, `kodeguru`, `namaguru`, `jeniskelamin`, `tempatlahir`, `tgllahir`, `alamatguru`, `notelpseluler`, `emailguru`, `kodejurusan`, `kodekelas`, `iduser`, `tglperbaharui`, `is_active`) VALUES
('guru1', 'GR01', 'Amelia1', 'Perempuan', 'BWI', '1990-01-25', 'Alamat123456', '8123456789', 'amelia1@gmail.com', '', 'VIIA', NULL, '2023-09-11 02:35:21', 1),
('guru2', 'GR02', 'Amelia2', 'Perempuan', 'BWI', '1990-01-26', 'Alamat123457', '8123456790', 'amelia2@gmail.com', '', 'VIIB', NULL, '2023-09-11 02:35:21', 1),
('guru3', 'GR03', 'Dina1', 'Perempuan', 'BWI', '1985-01-27', 'Alamat123458', '8123456791', 'dina1@gmail.com', '', 'VIIIA', NULL, '2023-09-11 02:35:21', 1),
('guru4', 'GR04', 'Dina2', 'Perempuan', 'BWI', '1985-01-28', 'Alamat123459', '8123456792', 'dina2@gmail.com', '', 'VIIIB', NULL, '2023-09-11 02:35:21', 1),
('guru5', 'GR05', 'Rafa1', 'Laki-laki', 'BWI', '1994-01-29', 'Alamat123460', '8123456793', 'rafa1@gmail.com', '', 'IXA', NULL, '2023-09-11 02:35:21', 1),
('guru6', 'GR06', 'Rafa2', 'Laki-laki', 'BWI', '1994-01-30', 'Alamat123461', '8123456794', 'rafa2@gmail.com', '', 'IXB', NULL, '2023-09-11 02:35:21', 1);

--
-- Trigger `tb_guru`
--
DELIMITER $$
CREATE TRIGGER `auto_user_guru` AFTER INSERT ON `tb_guru` FOR EACH ROW BEGIN
 DECLARE lastNo varchar(15);
    DECLARE nextNo varchar(15);
    DECLARE formatID varchar(15);

    SET formatID = CONCAT('USR-',DATE_FORMAT(NOW(), '%Y'));
    SELECT MAX(RIGHT(iduser, 5)) into lastNo from user_login WHERE iduser LIKE CONCAT(formatID, '%');
    IF lastNo IS NULL THEN
     BEGIN
      set nextNo = CONCAT(formatID, '00001'); 
     END;
    ELSE
     BEGIN
      set nextNo = CONCAT(formatID, LPAD(lastNo + 1, 5, '0'));
     END;
    END IF;
 INSERT INTO user_login (iduser, namauser, namalengkapuser, passuser, role_id, is_active, kodejurusan,semester_aktif) VALUES (nextNo, new.nip, new.namaguru, md5(new.nip), 2, 1, new.kodejurusan,'-' );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_jurusan`
--

CREATE TABLE `tb_jurusan` (
  `kodejurusan` char(10) NOT NULL,
  `namajurusan` varchar(50) NOT NULL,
  `nip` varchar(30) NOT NULL,
  `iduser` varchar(20) NOT NULL,
  `tglperbaharui` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_kelas`
--

CREATE TABLE `tb_kelas` (
  `kodekelas` char(10) NOT NULL,
  `kodejurusan` char(10) DEFAULT NULL,
  `namakelas` varchar(30) DEFAULT NULL,
  `kelas` char(3) DEFAULT NULL,
  `angkatankelas` int(11) NOT NULL,
  `is_active` int(1) DEFAULT NULL,
  `iduser` varchar(20) DEFAULT NULL,
  `tglperbaharui` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_kelas`
--

INSERT INTO `tb_kelas` (`kodekelas`, `kodejurusan`, `namakelas`, `kelas`, `angkatankelas`, `is_active`, `iduser`, `tglperbaharui`) VALUES
('IXA', NULL, '9 A', '9', 2020, 1, 'USR-202100001', '2023-09-11 02:39:11'),
('IXB', NULL, '9 B', '9', 2020, 1, 'USR-202100001', '2023-09-08 08:52:26'),
('VIIA', NULL, '7 A', '7', 2021, 1, 'USR-202100001', '2023-09-08 08:52:34'),
('VIIB', NULL, '7 B', '7', 2021, 1, 'USR-202100001', '2023-09-08 08:52:42'),
('VIIIA', NULL, '8 A', '8', 2022, 1, 'USR-202100001', '2023-09-08 08:52:53'),
('VIIIB', NULL, '8 B', '8', 2022, 1, 'USR-202100001', '2023-09-08 08:52:59');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_kelas_history`
--

CREATE TABLE `tb_kelas_history` (
  `idhistory` int(11) NOT NULL,
  `kodekelas` varchar(15) NOT NULL,
  `tahunajar` int(11) DEFAULT NULL,
  `semesteraktif` int(11) DEFAULT 1,
  `nip` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_kompdasar`
--

CREATE TABLE `tb_kompdasar` (
  `idkd` int(11) NOT NULL,
  `kodekd` varchar(15) NOT NULL,
  `namakd` varchar(256) NOT NULL,
  `jenis` char(5) DEFAULT NULL,
  `semester` varchar(50) DEFAULT NULL,
  `kodemapel` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_kompdasar`
--

INSERT INTO `tb_kompdasar` (`idkd`, `kodekd`, `namakd`, `jenis`, `semester`, `kodemapel`) VALUES
(19, 'KD1', 'KD1', 'K', '1', 'MP003'),
(20, 'KD01', 'KD MTK - Memahami konsep bilangan bulat ', 'P', '2', 'MP001'),
(21, 'KD02', 'KD MTK - Mengidentifikasi pola bilangan ', 'P', '1', 'MP001'),
(22, 'KD03', 'KD MTK - Menyelesaikan masalah dalam kehidupan sehari-hari yang melibatkan perbandingan dan proporsi.', 'P', '1', 'MP001'),
(23, 'KD01', 'Test KD', 'K', '1', 'MP001'),
(24, 'KD02', 'Test KD02', 'K', '2', 'MP001');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_mapel`
--

CREATE TABLE `tb_mapel` (
  `kodemapel` varchar(20) NOT NULL,
  `namamapel` varchar(256) DEFAULT NULL,
  `tingkatan` varchar(10) NOT NULL,
  `idkelompokmapel` char(5) NOT NULL,
  `kodejurusan` varchar(30) NOT NULL,
  `kodekelas` varchar(50) NOT NULL,
  `kkm` double DEFAULT NULL,
  `iduser` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_mapel`
--

INSERT INTO `tb_mapel` (`kodemapel`, `namamapel`, `tingkatan`, `idkelompokmapel`, `kodejurusan`, `kodekelas`, `kkm`, `iduser`) VALUES
('MP001', 'MTK - Dasar-dasar Algoritma', '', '', '', 'VIIA', 70, 'USR-202100001'),
('MP002', 'MTK - Rumus Aljabar', '', '', '', 'VIIIA', 70, 'USR-202100001'),
('MP003', 'MTK - Barisan Deret Aritmatika', '', '', '', 'IXA', 70, 'USR-202100001'),
('MP004', 'B. Indonesia - Sastra Indonesia', '', '', '', 'VIIA', 75, 'USR-202100001'),
('MP005', 'B. Indonesia - Teks Pidato Persuasif', '', '', '', 'VIIIA', 75, 'USR-202100001'),
('MP006', 'B. Indonesia - Cerpen', '', '', '', 'IXA', 75, 'USR-202100001'),
('MP007', 'B. Inggris - Reading Comprehension in English', '', '', '', 'VIIA', 75, 'USR-202100001'),
('MP008', 'B. Inggris - English Grammar', '', '', '', 'VIIIA', 75, 'USR-202100001'),
('MP009', 'B. Inggris - Conversational English', '', '', '', 'IXA', 75, 'USR-202100001');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_mapel_kelompok`
--

CREATE TABLE `tb_mapel_kelompok` (
  `idkelompokmapel` char(10) NOT NULL,
  `namakelompokmapel` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_mapel_kelompok`
--

INSERT INTO `tb_mapel_kelompok` (`idkelompokmapel`, `namakelompokmapel`) VALUES
('C1', 'C1. Dasar Bidang Keahlian'),
('C2', 'C2. Dasar Program Keahlian'),
('C3', 'C3. Kompetensi Keahlian'),
('MK', 'Muatan Kewilayahan'),
('MN', 'Muatan Nasional');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_mengajar`
--

CREATE TABLE `tb_mengajar` (
  `idmengajar` int(11) NOT NULL,
  `kodemapel` varchar(15) NOT NULL,
  `nip` varchar(30) NOT NULL,
  `semester` int(3) NOT NULL,
  `kodekelas` varchar(15) NOT NULL,
  `periode_mengajar` varchar(15) NOT NULL,
  `modul_ajar` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_mengajar`
--

INSERT INTO `tb_mengajar` (`idmengajar`, `kodemapel`, `nip`, `semester`, `kodekelas`, `periode_mengajar`, `modul_ajar`) VALUES
(33, 'MP001', 'guru1', 1, 'VIIA', '2023', 'CATATAN_PERBAIKAN_2.docx'),
(34, 'MP004', 'guru2', 1, 'VIIIA', '2021', 'CATATAN_PERBAIKAN_21.docx'),
(35, 'MP008', 'guru3', 2, 'IXB', '2021', 'CATATAN_PERBAIKAN_22.docx');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_nilai`
--

CREATE TABLE `tb_nilai` (
  `idnilai` int(11) NOT NULL,
  `jenis` char(5) NOT NULL,
  `idmengajar` int(11) NOT NULL,
  `idkd` int(11) NOT NULL,
  `nis` varchar(20) NOT NULL,
  `nilai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_nilai`
--

INSERT INTO `tb_nilai` (`idnilai`, `jenis`, `idmengajar`, `idkd`, `nis`, `nilai`) VALUES
(1, 'h', 13, 8, '171800010', 76),
(2, 'h', 13, 8, '171800020', 76),
(3, 'h', 13, 8, '171800031', 76),
(4, 'h', 13, 8, '171800018', 76),
(5, 'h', 13, 8, '171800021', 76),
(6, 'h', 13, 8, '171800003', 76),
(7, 'h', 13, 8, '171800004', 76),
(8, 'h', 13, 8, '171800022', 76),
(9, 'h', 13, 8, '171800026', 76),
(10, 'h', 13, 8, '171800027', 76),
(11, 'h', 13, 8, '171800019', 76),
(12, 'h', 13, 8, '171800012', 76),
(13, 'h', 13, 8, '171800015', 76),
(14, 'h', 13, 8, '171800002', 76),
(15, 'h', 13, 8, '171800023', 76),
(16, 'h', 13, 8, '171800014', 76),
(17, 'h', 13, 8, '171800030', 76),
(18, 'h', 13, 8, '171800007', 76),
(19, 'h', 13, 8, '171800001', 76),
(20, 'h', 13, 8, '171800006', 76),
(21, 'h', 13, 8, '171800024', 76),
(22, 'h', 13, 8, '171800025', 76),
(23, 'h', 13, 8, '171800028', 76),
(24, 'h', 13, 8, '171800013', 76),
(25, 'h', 13, 8, '171800017', 76),
(26, 'h', 13, 8, '171800011', 76),
(27, 'h', 13, 8, '171800016', 76),
(28, 'h', 13, 8, '171800005', 76),
(29, 'h', 13, 8, '171800008', 76),
(30, 'h', 13, 8, '171800029', 76),
(31, 'h', 13, 8, '171800009', 76),
(32, 't', 13, 0, '171800010', 80),
(33, 't', 13, 0, '171800020', 80),
(34, 't', 13, 0, '171800031', 80),
(35, 't', 13, 0, '171800018', 80),
(36, 't', 13, 0, '171800021', 80),
(37, 't', 13, 0, '171800003', 80),
(38, 't', 13, 0, '171800004', 80),
(39, 't', 13, 0, '171800022', 80),
(40, 't', 13, 0, '171800026', 80),
(41, 't', 13, 0, '171800027', 80),
(42, 't', 13, 0, '171800019', 80),
(43, 't', 13, 0, '171800012', 80),
(44, 't', 13, 0, '171800015', 80),
(45, 't', 13, 0, '171800002', 80),
(46, 't', 13, 0, '171800023', 80),
(47, 't', 13, 0, '171800014', 80),
(48, 't', 13, 0, '171800030', 80),
(49, 't', 13, 0, '171800007', 80),
(50, 't', 13, 0, '171800001', 80),
(51, 't', 13, 0, '171800006', 80),
(52, 't', 13, 0, '171800024', 80),
(53, 't', 13, 0, '171800025', 80),
(54, 't', 13, 0, '171800028', 80),
(55, 't', 13, 0, '171800013', 80),
(56, 't', 13, 0, '171800017', 80),
(57, 't', 13, 0, '171800011', 80),
(58, 't', 13, 0, '171800016', 80),
(59, 't', 13, 0, '171800005', 80),
(60, 't', 13, 0, '171800008', 80),
(61, 't', 13, 0, '171800029', 80),
(62, 't', 13, 0, '171800009', 80),
(63, 'a', 13, 0, '171800010', 90),
(64, 'a', 13, 0, '171800020', 90),
(65, 'a', 13, 0, '171800031', 90),
(66, 'a', 13, 0, '171800018', 90),
(67, 'a', 13, 0, '171800021', 90),
(68, 'a', 13, 0, '171800003', 90),
(69, 'a', 13, 0, '171800004', 90),
(70, 'a', 13, 0, '171800022', 90),
(71, 'a', 13, 0, '171800026', 90),
(72, 'a', 13, 0, '171800027', 90),
(73, 'a', 13, 0, '171800019', 90),
(74, 'a', 13, 0, '171800012', 90),
(75, 'a', 13, 0, '171800015', 90),
(76, 'a', 13, 0, '171800002', 90),
(77, 'a', 13, 0, '171800023', 90),
(78, 'a', 13, 0, '171800014', 90),
(79, 'a', 13, 0, '171800030', 90),
(80, 'a', 13, 0, '171800007', 90),
(81, 'a', 13, 0, '171800001', 90),
(82, 'a', 13, 0, '171800006', 90),
(83, 'a', 13, 0, '171800024', 90),
(84, 'a', 13, 0, '171800025', 90),
(85, 'a', 13, 0, '171800028', 90),
(86, 'a', 13, 0, '171800013', 90),
(87, 'a', 13, 0, '171800017', 90),
(88, 'a', 13, 0, '171800011', 90),
(89, 'a', 13, 0, '171800016', 90),
(90, 'a', 13, 0, '171800005', 90),
(91, 'a', 13, 0, '171800008', 90),
(92, 'a', 13, 0, '171800029', 90),
(93, 'a', 13, 0, '171800009', 90),
(94, 'h', 23, 16, '192000096', 80),
(95, 'h', 23, 16, '192000285', 80),
(98, 'h', 33, 22, '123456789', 70),
(99, 't', 33, 0, '123456789', 90),
(100, 'a', 33, 0, '123456789', 80);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_nilai_ket`
--

CREATE TABLE `tb_nilai_ket` (
  `id` int(11) NOT NULL,
  `idmengajar` int(11) NOT NULL,
  `idkd` int(11) NOT NULL,
  `nis` varchar(20) NOT NULL,
  `nilai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_nilai_ket`
--

INSERT INTO `tb_nilai_ket` (`id`, `idmengajar`, `idkd`, `nis`, `nilai`) VALUES
(1, 13, 13, '171800010', 78),
(2, 13, 13, '171800020', 78),
(3, 13, 13, '171800031', 78),
(4, 13, 13, '171800018', 78),
(5, 13, 13, '171800021', 78),
(6, 13, 13, '171800003', 78),
(7, 13, 13, '171800004', 78),
(8, 13, 13, '171800022', 78),
(9, 13, 13, '171800026', 78),
(10, 13, 13, '171800027', 78),
(11, 13, 13, '171800019', 78),
(12, 13, 13, '171800012', 78),
(13, 13, 13, '171800015', 78),
(14, 13, 13, '171800002', 78),
(15, 13, 13, '171800023', 78),
(16, 13, 13, '171800014', 78),
(17, 13, 13, '171800030', 78),
(18, 13, 13, '171800007', 78),
(19, 13, 13, '171800001', 78),
(20, 13, 13, '171800006', 78),
(21, 13, 13, '171800024', 78),
(22, 13, 13, '171800025', 78),
(23, 13, 13, '171800028', 78),
(24, 13, 13, '171800013', 78),
(25, 13, 13, '171800017', 78),
(26, 13, 13, '171800011', 78),
(27, 13, 13, '171800016', 78),
(28, 13, 13, '171800005', 78),
(29, 13, 13, '171800008', 78),
(30, 13, 13, '171800029', 78),
(31, 13, 13, '171800009', 78),
(35, 33, 23, '123456789', 80),
(36, 33, 24, '123456789', 90);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_siswa`
--

CREATE TABLE `tb_siswa` (
  `nis` varchar(128) NOT NULL,
  `namasiswa` varchar(70) NOT NULL,
  `nisn` varchar(30) DEFAULT NULL,
  `jeniskelamin` char(15) DEFAULT NULL,
  `tempatlahir` varchar(30) DEFAULT NULL,
  `tgllahir` date DEFAULT NULL,
  `alamatsiswa` varchar(70) DEFAULT NULL,
  `notelpseluler` varchar(15) DEFAULT NULL,
  `emailsiswa` varchar(50) DEFAULT NULL,
  `asalsekolah` varchar(50) DEFAULT NULL,
  `tglmasuk` date DEFAULT NULL,
  `nama_ayah` varchar(50) DEFAULT NULL,
  `nama_ibu` varchar(50) DEFAULT NULL,
  `kodekelas` char(10) DEFAULT NULL,
  `kodejurusan` char(10) DEFAULT NULL,
  `semester_aktif` int(2) NOT NULL,
  `is_active` int(11) DEFAULT 1,
  `iduser` varchar(20) DEFAULT NULL,
  `tglperbaharui` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_siswa`
--

INSERT INTO `tb_siswa` (`nis`, `namasiswa`, `nisn`, `jeniskelamin`, `tempatlahir`, `tgllahir`, `alamatsiswa`, `notelpseluler`, `emailsiswa`, `asalsekolah`, `tglmasuk`, `nama_ayah`, `nama_ibu`, `kodekelas`, `kodejurusan`, `semester_aktif`, `is_active`, `iduser`, `tglperbaharui`) VALUES
('12345', 'Fajar', '123451791', 'Laki-laki', 'SBY', '2009-08-10', 'Alamat9878', '8123456791', 'ibrahim@gmail.com', 'SDN 1 Bangil', '2018-06-27', 'Rahasia', 'Rahasia', 'IXB', NULL, 1, 1, NULL, '2023-09-11 02:50:53'),
('123456789', 'Kevin', '123456789', 'Laki-laki', 'BWI', '2008-08-08', 'Alamat9876', '8123456789', 'kevin@gmail.com', 'SDN 1 Bangil', '2020-06-25', 'Rahasia', 'Rahasia', 'VIIA', NULL, 1, 1, 'USR-202100001', '2023-09-11 03:31:09'),
('98765', 'Ibrahim', '123451790', 'Laki-laki', 'SBY', '2009-08-09', 'Alamat9877', '8123456790', 'ibrahim@gmail.com', 'SDN 1 Bangil', '2019-06-26', 'Rahasia', 'Rahasia', 'VIIIA', NULL, 2, 1, NULL, '2023-09-11 02:50:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_tugas`
--

CREATE TABLE `tb_tugas` (
  `idtugas` int(11) NOT NULL,
  `idagenda` int(11) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `deskripsi` text NOT NULL,
  `fileupload` varchar(100) NOT NULL,
  `keterangan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_tugas`
--

INSERT INTO `tb_tugas` (`idtugas`, `idagenda`, `judul`, `deskripsi`, `fileupload`, `keterangan`) VALUES
(3, 3, 'Merangkum', 'Merangkum buku administrasi jaringan', '', 'Belum Dikerjakan'),
(4, 3, 'Kerjakan Soal', 'Soal essay', 'Tugas-20-12-292.PNG', 'Belum Dikerjakan'),
(7, 1, 'Merangkum', 'Merangkum jaringan komputer', 'Tugas-21-01-05.PNG', 'Belum Dikerjakan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `image` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `role_id` int(11) NOT NULL,
  `is_active` int(1) NOT NULL,
  `date_created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_access_menu`
--

CREATE TABLE `user_access_menu` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user_access_menu`
--

INSERT INTO `user_access_menu` (`id`, `role_id`, `menu_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 2),
(4, 1, 3),
(9, 2, 5),
(10, 3, 2),
(11, 3, 6),
(12, 4, 2),
(15, 1, 4),
(18, 4, 8),
(19, 1, 5),
(24, 1, 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_login`
--

CREATE TABLE `user_login` (
  `iduser` varchar(15) NOT NULL,
  `namauser` varchar(30) DEFAULT NULL,
  `passuser` varchar(256) DEFAULT NULL,
  `namalengkapuser` varchar(100) DEFAULT NULL,
  `avataruser` varchar(256) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_active` int(2) DEFAULT NULL,
  `tglbuat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tglperbaharui` datetime DEFAULT NULL,
  `tgllogakhir` datetime DEFAULT NULL,
  `kodejurusan` char(10) NOT NULL,
  `semester_aktif` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user_login`
--

INSERT INTO `user_login` (`iduser`, `namauser`, `passuser`, `namalengkapuser`, `avataruser`, `role_id`, `is_active`, `tglbuat`, `tglperbaharui`, `tgllogakhir`, `kodejurusan`, `semester_aktif`) VALUES
('USR-202100001', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 'marc-mintel-1iYTusNPlSk-unsplash.jpg', 1, 1, '2021-11-07 04:20:20', NULL, NULL, '-', 0),
('USR-202100005', 'kepsek', '8561863b55faf85b9ad67c52b3b851ac', 'Kepala Sekolah SMPN 1 Inpres', NULL, 3, 1, '2023-09-11 04:50:19', NULL, NULL, '-', 0),
('USR-202300003', 'murid', '21232f297a57a5a743894a0e4a801fc3', 'murid', NULL, 2, 1, '2023-09-07 04:32:41', NULL, NULL, '', 0),
('USR-202300004', '19910810', 'f7cc922771dfd8ddb0966b4e76548216', '19910810', NULL, 2, 1, '2023-09-08 07:50:01', NULL, NULL, '', 0),
('USR-202300005', '12345', '827ccb0eea8a706c4c34a16891f84e7b', 'Amelia', NULL, 4, 1, '2023-09-11 04:52:00', NULL, NULL, '', 0),
('USR-202300006', '1', 'c4ca4238a0b923820dcc509a6f75849b', 'Amelia', NULL, 2, 1, '2023-09-08 08:45:56', NULL, NULL, '', 0),
('USR-202300007', '2', 'c81e728d9d4c2f636f067f89cc14862c', 'Amelia2', NULL, 2, 1, '2023-09-08 08:46:55', NULL, NULL, '', 0),
('USR-202300008', '3', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'Dina Lita2', NULL, 2, 1, '2023-09-08 08:48:18', NULL, NULL, '', 0),
('USR-202300009', '4', 'a87ff679a2f3e71d9181a67b7542122c', 'Dina Lita2', NULL, 2, 1, '2023-09-08 08:49:39', NULL, NULL, '', 0),
('USR-202300010', '5', 'e4da3b7fbbce2345d7772b0674a318d5', 'Rafa', NULL, 2, 1, '2023-09-08 08:50:52', NULL, NULL, '', 0),
('USR-202300011', '6', '1679091c5a880faf6fb5e6087eb1b2dc', 'Rafa2', NULL, 2, 1, '2023-09-08 08:51:43', NULL, NULL, '', 0),
('USR-202300012', '12345678910', '432f45b44c432414d2f97df0e5743818', 'Dina Lita', NULL, 2, 1, '2023-09-11 02:33:53', NULL, NULL, '', 0),
('USR-202300013', 'guru1', '92afb435ceb16630e9827f54330c59c9', 'Amelia1', NULL, 2, 1, '2023-09-11 02:35:21', NULL, NULL, '', 0),
('USR-202300014', 'guru2', '440a21bd2b3a7c686cf3238883dd34e9', 'Amelia2', NULL, 2, 1, '2023-09-11 02:35:21', NULL, NULL, '', 0),
('USR-202300015', 'guru3', 'ba6e3bb0215b631f473dd97cd3de08b2', 'Dina1', NULL, 2, 1, '2023-09-11 02:35:21', NULL, NULL, '', 0),
('USR-202300016', 'guru4', 'aa5c4d9f3bd44b0c8975e93bcf318399', 'Dina2', NULL, 2, 1, '2023-09-11 02:35:21', NULL, NULL, '', 0),
('USR-202300017', 'guru5', 'd0c5563b2d314c3d94959b73c30256a3', 'Rafa1', NULL, 2, 1, '2023-09-11 02:35:21', NULL, NULL, '', 0),
('USR-202300018', 'guru6', '382a97b190cd838177fe39fc3c53e1c3', 'Rafa2', NULL, 2, 1, '2023-09-11 02:35:21', NULL, NULL, '', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_menu`
--

CREATE TABLE `user_menu` (
  `id` int(11) NOT NULL,
  `menu` varchar(128) NOT NULL,
  `urutan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user_menu`
--

INSERT INTO `user_menu` (`id`, `menu`, `urutan`) VALUES
(1, 'Admin', 1),
(2, 'User', 6),
(3, 'Menu', 4),
(4, 'Master', 2),
(5, 'Guru', 3),
(6, 'Laporan', 5),
(8, 'Siswa', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_role`
--

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `role` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user_role`
--

INSERT INTO `user_role` (`id`, `role`) VALUES
(1, 'Superadmin'),
(2, 'Guru'),
(3, 'Kepala Sekolah'),
(4, 'Siswa');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user_sub_menu`
--

CREATE TABLE `user_sub_menu` (
  `id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `url` varchar(128) NOT NULL,
  `icon` varchar(128) NOT NULL,
  `is_active` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user_sub_menu`
--

INSERT INTO `user_sub_menu` (`id`, `menu_id`, `title`, `url`, `icon`, `is_active`) VALUES
(1, 1, 'Dashboard', 'admin', 'fas fa-fw fa-tachometer-alt', 1),
(2, 2, 'My Profile', 'user', 'fas fa-fw fa-user', 1),
(3, 3, 'Menu Management', 'menu', 'fas fa-fw fa-folder', 1),
(4, 3, 'Submenu Management', 'menu/submenu', 'fas fa-fw fa-folder-open', 1),
(5, 2, 'Edit Profile', 'user/edit', 'fas fa-fw fa-user-edit', 1),
(6, 1, 'Role', 'admin/role', 'fas fa-fw fa-user-tie', 1),
(7, 2, 'Change Password', 'user/changepassword', 'fas fa-fw fa-key', 1),
(8, 4, 'Modul Guru', 'master/guru', 'fas fa-fw fa-user-graduate', 1),
(9, 4, 'Modul Jurusan', 'master/jurusan', 'fas fa-fw fa-tags', 0),
(10, 4, 'Modul Kelas', 'master/kelas', 'fas fa-fw fa-chalkboard', 1),
(11, 4, 'Modul Siswa', 'master/siswa', 'fas fa-fw fa-users', 1),
(12, 4, 'Modul Mata Pelajaran', 'master/mapel', 'fas fa-fw fa-book', 1),
(13, 4, 'Modul Mengajar', 'master/mengajar', 'fas fa-fw fa-archive', 1),
(14, 5, 'Mapel Diampu', 'guru/ampu', 'fas fa-fw fa-pencil-alt', 1),
(15, 5, 'Agenda Kegiatan', 'guru', 'fas fa-fw fa-clipboard', 1),
(19, 6, 'Rekap Data Guru', 'laporan/dataguru', 'fas fa-fw fa-database', 1),
(20, 6, 'Rekap Data Kelas', 'laporan/datakelas', 'fas fa-fw fa-database', 1),
(21, 6, 'Rekap Data Siswa', 'laporan/datasiswa', 'fas fa-fw fa-database', 0),
(22, 6, 'Rekap Data Ampu', 'laporan/dataampu', 'fas fa-fw fa-database', 1),
(23, 6, 'Rekap Data Agenda', 'laporan/dataagenda', 'fas fa-fw fa-database', 1),
(24, 5, 'Riwayat Mengajar', 'guru/riwayat', 'fas fa-fw fa-chalkboard-teacher', 1),
(25, 8, 'Lihat Nilai', 'nilai', 'fas fa-fw fa-folder-open', 0),
(26, 6, 'Rekap Absensi', 'laporan/dataabsen', 'fas fa-fw fa-database', 1),
(28, 6, 'Rekap Modul Ajar', 'laporan/datamodul', 'fas fa-fw fa-database', 1);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_absensi`
--
ALTER TABLE `tb_absensi`
  ADD PRIMARY KEY (`kodeabsen`);

--
-- Indeks untuk tabel `tb_agenda`
--
ALTER TABLE `tb_agenda`
  ADD PRIMARY KEY (`idagenda`);

--
-- Indeks untuk tabel `tb_guru`
--
ALTER TABLE `tb_guru`
  ADD PRIMARY KEY (`nip`);

--
-- Indeks untuk tabel `tb_jurusan`
--
ALTER TABLE `tb_jurusan`
  ADD PRIMARY KEY (`kodejurusan`);

--
-- Indeks untuk tabel `tb_kelas`
--
ALTER TABLE `tb_kelas`
  ADD PRIMARY KEY (`kodekelas`);

--
-- Indeks untuk tabel `tb_kelas_history`
--
ALTER TABLE `tb_kelas_history`
  ADD PRIMARY KEY (`idhistory`);

--
-- Indeks untuk tabel `tb_kompdasar`
--
ALTER TABLE `tb_kompdasar`
  ADD PRIMARY KEY (`idkd`);

--
-- Indeks untuk tabel `tb_mapel`
--
ALTER TABLE `tb_mapel`
  ADD PRIMARY KEY (`kodemapel`);

--
-- Indeks untuk tabel `tb_mapel_kelompok`
--
ALTER TABLE `tb_mapel_kelompok`
  ADD PRIMARY KEY (`idkelompokmapel`);

--
-- Indeks untuk tabel `tb_mengajar`
--
ALTER TABLE `tb_mengajar`
  ADD PRIMARY KEY (`idmengajar`);

--
-- Indeks untuk tabel `tb_nilai`
--
ALTER TABLE `tb_nilai`
  ADD PRIMARY KEY (`idnilai`);

--
-- Indeks untuk tabel `tb_nilai_ket`
--
ALTER TABLE `tb_nilai_ket`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tb_siswa`
--
ALTER TABLE `tb_siswa`
  ADD PRIMARY KEY (`nis`);

--
-- Indeks untuk tabel `tb_tugas`
--
ALTER TABLE `tb_tugas`
  ADD PRIMARY KEY (`idtugas`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_access_menu`
--
ALTER TABLE `user_access_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_login`
--
ALTER TABLE `user_login`
  ADD PRIMARY KEY (`iduser`);

--
-- Indeks untuk tabel `user_menu`
--
ALTER TABLE `user_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user_sub_menu`
--
ALTER TABLE `user_sub_menu`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_agenda`
--
ALTER TABLE `tb_agenda`
  MODIFY `idagenda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `tb_kelas_history`
--
ALTER TABLE `tb_kelas_history`
  MODIFY `idhistory` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tb_kompdasar`
--
ALTER TABLE `tb_kompdasar`
  MODIFY `idkd` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT untuk tabel `tb_mengajar`
--
ALTER TABLE `tb_mengajar`
  MODIFY `idmengajar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT untuk tabel `tb_nilai`
--
ALTER TABLE `tb_nilai`
  MODIFY `idnilai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT untuk tabel `tb_nilai_ket`
--
ALTER TABLE `tb_nilai_ket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT untuk tabel `tb_tugas`
--
ALTER TABLE `tb_tugas`
  MODIFY `idtugas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `user_access_menu`
--
ALTER TABLE `user_access_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `user_menu`
--
ALTER TABLE `user_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `user_sub_menu`
--
ALTER TABLE `user_sub_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
