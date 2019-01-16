-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2019 at 09:39 AM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.0.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tespnm`
--

-- --------------------------------------------------------

--
-- Table structure for table `m_admin`
--

CREATE TABLE `m_admin` (
  `id` int(6) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `level` enum('admin','guru','siswa') NOT NULL,
  `kon_id` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `m_admin`
--

INSERT INTO `m_admin` (`id`, `username`, `password`, `level`, `kon_id`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 0),
(28, '40125', '75520ba59230a40bbbf8659160069ea6', 'siswa', 8),
(29, 'PNM123', 'c5b97d338f5aa7f1eb9ed3ed2c457f24', 'guru', 8),
(30, '12090677', 'baaf63831059795a0cedec6d705ad519', 'siswa', 7),
(31, '14012', 'a22ede5d703532f281f393a5459571fd', 'siswa', 10),
(32, '150', '7ef605fc8dba5425d6965fbd4c8fbe1f', 'siswa', 11),
(33, '00', 'b4b147bc522828731f1a016bfa72c073', 'guru', 11),
(34, '11090676', '02522a2b2726fb0a03bb19f2d8d9524d', 'siswa', 6),
(35, 'SDM123', 'b454d494b5a990478b65a22227bbc563', 'guru', 9),
(36, '3', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'siswa', 12),
(37, '4', 'a87ff679a2f3e71d9181a67b7542122c', 'siswa', 13),
(38, 'mb4h', '50ea77d8d9e97eceef4603c472a40dcc', 'siswa', 14),
(39, '5044', '996740de914ced0902e686373e319391', 'siswa', 15);

-- --------------------------------------------------------

--
-- Table structure for table `m_guru`
--

CREATE TABLE `m_guru` (
  `id` int(6) NOT NULL,
  `nip` varchar(30) NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `m_guru`
--

INSERT INTO `m_guru` (`id`, `nip`, `nama`) VALUES
(8, 'PNM123', 'PNM'),
(9, 'SDM123', 'SDM'),
(10, '123', 'MUM'),
(11, '00', 'Mekar');

--
-- Triggers `m_guru`
--
DELIMITER $$
CREATE TRIGGER `hapus_guru` AFTER DELETE ON `m_guru` FOR EACH ROW BEGIN
DELETE FROM m_soal WHERE m_soal.id_guru = OLD.id;
DELETE FROM m_admin WHERE m_admin.level = 'guru' AND m_admin.kon_id = OLD.id;
DELETE FROM tr_guru_mapel WHERE tr_guru_mapel.id_guru = OLD.id;
DELETE FROM tr_guru_tes WHERE tr_guru_tes.id_guru = OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `m_mapel`
--

CREATE TABLE `m_mapel` (
  `id` int(6) NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `m_mapel`
--

INSERT INTO `m_mapel` (`id`, `nama`) VALUES
(5, 'Psikologi 1.0'),
(6, 'Psikologi Preference Inventory'),
(7, 'Psikologi Aritmatika'),
(8, 'Psikologi 2');

--
-- Triggers `m_mapel`
--
DELIMITER $$
CREATE TRIGGER `hapus_mapel` AFTER DELETE ON `m_mapel` FOR EACH ROW BEGIN
DELETE FROM m_soal WHERE m_soal.id_mapel = OLD.id;
DELETE FROM tr_guru_mapel WHERE tr_guru_mapel.id_mapel = OLD.id;
DELETE FROM tr_guru_tes WHERE tr_guru_tes.id_mapel = OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `m_siswa`
--

CREATE TABLE `m_siswa` (
  `id` int(6) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nim` varchar(50) NOT NULL,
  `jurusan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `m_siswa`
--

INSERT INTO `m_siswa` (`id`, `nama`, `nim`, `jurusan`) VALUES
(6, 'Lavin', '134', 'Tamu'),
(7, 'Deny', '2', 'Tamu'),
(8, 'Frans Immanuel', '40125', 'Karyawan'),
(10, 'Ivan', '6', 'Tamu'),
(11, 'Danur', '5', 'Karyawan'),
(12, 'Fikri', '3', 'tamu'),
(13, 'HaiqalF', '4', 'Karyawan'),
(14, 'Mbah', 'mb4h', 'Tamu'),
(15, 'trias', '5044', 'Karyawan');

--
-- Triggers `m_siswa`
--
DELIMITER $$
CREATE TRIGGER `hapus_siswa` AFTER DELETE ON `m_siswa` FOR EACH ROW BEGIN
DELETE FROM tr_ikut_ujian WHERE tr_ikut_ujian.id_user = OLD.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `m_soal`
--

CREATE TABLE `m_soal` (
  `id` int(6) NOT NULL,
  `id_guru` int(6) NOT NULL,
  `id_mapel` int(6) NOT NULL,
  `bobot` int(2) NOT NULL,
  `file` varchar(150) NOT NULL,
  `tipe_file` varchar(50) NOT NULL,
  `soal` longtext NOT NULL,
  `opsi_a` longtext NOT NULL,
  `opsi_b` longtext NOT NULL,
  `opsi_c` longtext NOT NULL,
  `opsi_d` longtext NOT NULL,
  `opsi_e` longtext NOT NULL,
  `jawaban` varchar(5) NOT NULL,
  `tgl_input` datetime NOT NULL,
  `jml_benar` int(6) NOT NULL,
  `jml_salah` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `m_soal`
--

INSERT INTO `m_soal` (`id`, `id_guru`, `id_mapel`, `bobot`, `file`, `tipe_file`, `soal`, `opsi_a`, `opsi_b`, `opsi_c`, `opsi_d`, `opsi_e`, `jawaban`, `tgl_input`, `jml_benar`, `jml_salah`) VALUES
(52, 8, 5, 1, '', '', 'Dalam perusahaan, saya lebih senang bekerja di :', '#####Bidang teknik / mesin-mesin / pecatatan data', '#####Diantaranya', '#####Seleksi calon / pelamar, melakukan wawancara', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(53, 8, 5, 1, '', '', 'Adalah tidak mudah bagi saya untuk mengakui suatu kesalahan', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(54, 8, 5, 1, '', '', 'Bila perlu saya bisa melupakan kekhawatiran dan tanggung jawab', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(55, 8, 5, 1, '', '', 'Saya lebih percaya pada :', '#####Asuransi', '#####Diantaranya', '#####Nasib baik', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(56, 8, 5, 1, '', '', 'Saya rasa adalah kejam menyuntik anak-anak yang masih kecil, walaupun itu demi kesehatan, dan para orang tua berhak menolak anjuran sntik terhadap anak-anak mereka', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(57, 8, 5, 1, '', '', 'Seandainya saya cukup \"ahli\" dalam kedua permainan tersebut dibawah ini, namun saya lebih senang dengan :', '#####Catur', '#####Diantaranya', '#####Bowling', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(58, 8, 5, 1, '', '', 'Menurut pendapat saya adalah bijaksana untuk menghindari perasaan bergembira yang berlebihan, karena bisa meletihkan saya', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(59, 8, 5, 1, '', '', 'Bila dalam suatu tugas saya diberi wewenang, maka instruksi-instruksi saya haruslah dilaksanakan, bila tidak, maka saya akan mengundurkan diri dari tugas tersebut.', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(60, 8, 5, 1, '', '', 'Saya lebih senang menonton film :', '#####Tentang masa perjuangan', '#####Diantaranya', '#####Tentang \"ramalan humoristis / lucu\" dari kehidupan masyarakat di masa mendatang', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(61, 8, 5, 1, '', '', 'Bila seorang tetangga menipu saya secara kecil-kecilan, saya lebih cenderung untuk memperoloknya daripada membuat perkara', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(62, 8, 5, 1, '', '', 'Saya lebih senang menjadi :', '#####Pendeta / Alim Ulama', '#####Diantaranya', '#####Kolonel', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(63, 8, 5, 1, '', '', 'Baik dijalan maupun di toko saya tidak senang dengan cara-cara orang memperhatikan orang lain.', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(64, 8, 5, 1, '', '', 'Saya berpendapat bahwa ', '#####Ada beberapa pekerjaan yang tidak perlu dikerjakan dengan sangat hati-hati seperti pekerjaan lainnya', '#####Diantaranya', '#####Setiap pekerjaan harus dikerjakan seluruhnya, bila memang mau dikerjakan', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(65, 8, 5, 1, '', '', 'Saya senang berkumpul dengan orang banyak, seperti menghadiri pertemuan-pertemuan atau pesta-pesta', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(66, 8, 5, 1, '', '', 'Saya merasa sangat malu bila harus berceritera pada orang-orang bahwa saya pernah tinggal di perkampungan Nudist (perkampungan orang telanjang)', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(67, 8, 5, 1, '', '', 'Sewaktu-waktu dibutuhkan, saya senantiasa banyak tenaga', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(68, 8, 5, 1, '', '', 'Kebalikan dari kebalikan \"Tidak tepat adalah :', '#####Kebetulan ', '#####Tepat', '#####Kira-kira', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(69, 8, 5, 1, '', '', 'Saya bisa senang dengan pekerjaan di mana saya seharian harus mendengarkan keluhan-keluhan yang tidak menyenangkan baik dari para langganan ataupun dari karyawan sendiri', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(70, 8, 5, 1, '', '', 'Terkadang, walaupun sebentar, timbul perasaan benci terhadap orang tua saya.', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(71, 8, 5, 1, '', '', 'Bila saya akan berpergian dengan kereta api atau pesawat terbang, saya cenderung untuk tergesa-gesa dan kuatir terlambat meskipun tahu bahwa saya punya cukup waktu', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(72, 8, 5, 1, '', '', 'Saya tidak senang merenungkan kemungkinan-kemungkinan yang bisa terjadi pada masa lampau karena itu hanya membuang-buang waktu saja', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(73, 8, 5, 1, '', '', 'Bila saya merencanakan sesuatu, maka saya lebih senang mengerjakannya sendiri tanpa bantuan orang lain', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(74, 8, 5, 1, '', '', 'Bila saya mempunyai seorang teman baru, saya akan :', '#####Senang membicarakan pandangannya terhadap politik dan masalah sosial', '#####Diantaranya', '#####Memintanya untuk menceriterakan hal yang lucu-lucu yang belum pernah saya ketahui sebelumnya', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(75, 8, 5, 1, '', '', 'Terhadap orang yang berkelakuan buruk, saya :', '#####Tidak mencampurinya, karena bukan urusan saya', '#####Diantaranya', '#####Memberitahukan, bahwa banyak orang tidak menyukainya', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(76, 8, 5, 1, '', '', 'Bila pendapat baik saya diabaikan buruk, saya :', '#####Mengemukakannya cukup sekali saja', '#####Diantaranya', '#####Mengemukakan sekali lagi supaya bisa didengar oleh orang lain', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(77, 8, 5, 1, '', '', 'Ketika saya kecil, saya merasa sedih bila meninggalkan rumah untuk pergi ke sekolah setiap hari', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(78, 8, 5, 1, '', '', 'Saya tersenyum pada diri sendiri bila melihat orang menampilkan ketidaksesuaian antara perbuatan dan ucapannya', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(79, 8, 5, 1, '', '', 'Saya :', '#####lebih suka berlatih anggar dan menari / dansa', '#####Diantaranya', '#####lebih suka berlatih gulat dan bola basket', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(80, 8, 5, 1, '', '', 'Kebanyakan orang yang saya jumpai di pesta merasa senang bertemu saya', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(81, 8, 5, 1, '', '', 'Bila penghasilan saya melebihi dari yang saya butuhkan sehari-hari, maka saya akan menyumbangkan kelbihan uang tersebut pada organisasi / yayasan sosial', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(82, 8, 5, 1, '', '', 'Dalam suasana pesta, saya membiarkan orang-orang lain yang membuat suasana humor dan bercerita', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(83, 8, 5, 1, '', '', 'Saya jengkel terhadap orang-orang yang merasa dirinya dapat melakukan sesuatu lebih baik daripada orang lain', '#####Ya ', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(84, 8, 5, 1, '', '', 'Terhadap orang yang \"jorok\" dan sembarangan, saya :', '#####Bisa memakluminya', '#####Diantaranya', '#####Merasa jijik dan tak menyenangkan', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(85, 8, 5, 1, '', '', 'Bila dikatakan langit itu \"di bawah\" dan salju itu \"panas\" maka Kriminal itu :', '#####Penjahat', '#####Malaikat', '#####Awan', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(86, 8, 5, 1, '', '', 'Dengan hidup menyendiri, seperti seorang pertapa, saya merasa bahagia', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(87, 8, 5, 1, '', '', 'Saya merasa ingatan saya jauh lebih baik daripada sebelumnya.', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:46', 0, 4),
(88, 8, 5, 1, '', '', 'Saya cenderung bersikap kritis terhadap pekerjaan orang lain', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(89, 8, 5, 1, '', '', 'Kelanjutan dari deret angka : 1, 2, 3 , 5, 6, ………….. Adalah', '#####10', '#####5', '#####7', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(90, 8, 5, 1, '', '', 'Saya senang mewajibkan / menyuruh orang lain membuat janji pada waktu seperti yang mereka inginkan walaupun agak kurang menyenangkan bagi saya', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(91, 8, 5, 1, '', '', 'Pada saat-saat tertentu saya tak dapat berfikir dengan jernih', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(92, 8, 5, 1, '', '', 'Saya mengalami keadaan emosi yang kuat (seperti rasa takut, marah, gembira) tanpa ada sesuatu sebab ang berarti', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(93, 8, 5, 1, '', '', 'Bila saya menghadapi suatu masalah yang sulit, sedangkan masih banyak tugas lain yang harus dikerjakan, maka saya mencoba', '#####Menghadapi masalah lainnya dahulu', '#####Diantaranya', '#####Cara lain untuk mengatasi masalah tersebut', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(94, 8, 5, 1, '', '', 'Saya berusaha untuk tidak melibatkan diri dalam kegiatan-kegiatan sosial dengan berbagai tanggung jawabnya.', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(95, 8, 5, 1, '', '', 'Saya belajar lebih banyak pada waktu sekolah dengan', '#####Rajin masuk kelas', '#####Diantaranya', '#####Membaca buku-buku', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(96, 8, 5, 1, '', '', 'Saya berpendapat bahwa sistem pendidikan modern sekarang tidaklah sebaik sistem pendidikan yang lama, yaitu : \"Bertindaklah keras terhadap anak!\".', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(97, 8, 5, 1, '', '', 'Saya sering kesal terhadap peraturan-peraturan kecil walaupun saya menyadari pentingna peraturan tersebut', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(98, 8, 5, 1, '', '', 'Setiap hari, ada saat-saat tertentu dimana saya ingin menyelami pemikiran-pemikiran saya tanpa diganggu orang lain', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(99, 8, 5, 1, '', '', 'Menurut pendapat saya, banyak negara-negara lain sebenarnya lebih menunjukkan sikap bersahabat daripada yang kita duga semula.', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(100, 8, 5, 1, '', '', 'Halangan-halangan yang saya hadapi dapat membuat saya hampir menangi', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(101, 8, 5, 1, '', '', 'Bila tuduhan yang saya lontarkan itu benar, maka saya akan berbuat sedemikian rupa, sehingga akhirnya keingingan-keinginan saya terpenuhi.', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(102, 8, 5, 1, '', '', 'Saya lebih mengagumi : ', '#####Orang cerdas walaupun kurang dapat dipercaya', '#####Diantaranya', '#####Orang yang biasa-biasa saja namun kuat menahan godaan', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(103, 8, 5, 1, '', '', 'Saya pernah aktif dalam mengorganisir perkumpulan sosial / kegiatan kelompok', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(104, 8, 5, 1, '', '', 'Saya bisa berbohong pada seseorang dengan menatap wajahnya tanpa berkedip (bila untuk tujuan yang benar)', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(105, 8, 5, 1, '', '', 'Saya selalu tidur nyenyak, dan tidak pernah \"berjalan\" atau \"berbicara sewaktu tidur\"', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(106, 8, 5, 1, '', '', 'Bila hitam itu kelabu, maka nyeri itu : ', '#####Luka', '#####Penyakit', '#####Tidak menyenangkan', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(107, 8, 5, 1, '', '', 'Saya lebih senang :', '#####Berada dalam kantor dagang, mengorganisir, dan bertemu dengan orang-orang', '#####Diantaranya', '#####Menjadi arsitek, merencanakan gambar di belakang meja', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(108, 8, 5, 1, '', '', 'Bila saya yakin bahwa saya melakukan yang benar, maka tugas saya akan dirasakan mudah', '#####Ya (sering)', '#####Kadang-kadang', '#####Tidak (jarang)', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(109, 8, 5, 1, '', '', 'Ada waktu-waktu tertentu di mana saya segan bertemu dengan orang lain', '#####Sangat jarang', '#####Diantaranya', '#####Sering sekali', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(110, 8, 5, 1, '', '', 'Secara jujur saya merasa bahwa saya mempunyai ambisi lebih besar, tenaga lebih banyak dan lebih berencana, daripada orang-orang lain yang sama-sama berhasil', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(111, 8, 5, 1, '', '', 'Di dunia sebenarnya terdapat lebih banyak orang-orang tidak disenangi', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(112, 8, 5, 1, '', '', 'Saya lebih senang membaca', '#####Ceritera-ceritera sejarah yang baik', '#####Diantaranya', '#####Karangan ilimah tentang penggunaan sumber alam', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(113, 8, 5, 1, '', '', 'Saya cenderung melewatkan waktu malam dengan ', '#####Bermain suatu permainan kartu yang sukar', '#####Diantaranya', '#####Melihat album foto masa libur yang lalu', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(114, 8, 5, 1, '', '', 'Menurut pendapat saya, sebaiknya negara kita mengutamakan', '#####Persenjataan', '#####Diantaranya', '#####Pendidikan', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(115, 8, 5, 1, '', '', 'Bila saya sedang berfikir, maka lebih baik bagi saya bila saya berjalan hilir mudik', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(116, 8, 5, 1, '', '', 'Menurut pendapat saya, kebanyakan saksi akan berkata yang sebenarnya walaupun itu akan memalukannya', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(117, 8, 5, 1, '', '', 'Saya bila melakukan pekerjaan \"kasar\" tanpa merasa cepat lelah seperti orang-orang lain', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(118, 8, 5, 1, '', '', 'Beberapa hal membuat saya sangat marah, sehingga saya anggap lebih baik untuk \"tidak berbicara\"', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(119, 8, 5, 1, '', '', 'Menurut pendapat saya, orang-orang harus lebih mentaati hukum-hukum moral', '#####Ya ', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(120, 8, 5, 1, '', '', 'Bila saya sedang bersama dengan orang banyak maka saya merasa agak kaku dan tidak bisa menonjolkan diri seperti seharusnya', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(121, 8, 5, 1, '', '', 'Saya merasa senang bila pada waktu-waktu tertentu, saya dilayani oleh pembantu-pembantu pribada', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(122, 8, 5, 1, '', '', 'Kesenangan saya mudah terpengaruh oleh perubahana mendadak, sehingga saya harus mengubah kembali rencana semula', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(123, 8, 5, 1, '', '', 'Pilihlah kata yang tidak termasuk (berbeda) dengan kedua kata lainnya :', '#####Kucing', '#####Dekat ', '#####Matahari', '#####', '#####', 'A', '2018-11-09 10:32:55', 0, 4),
(124, 8, 5, 1, '', '', 'Bila ibunya Maya adalah kakak dari ayahnya Sidin, maka bagaimanakah hubungan antara Sidin dengan ayahnya Maya', '#####Sepupu', '#####Kemenakan', '#####Paman', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(125, 8, 5, 1, '', '', 'Kata manakah yang tidak tergolong dengan dua kata lainnya :', '#####Lari', '#####Melihat', '#####Menentuh', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(126, 8, 5, 1, '', '', 'Bila saya tidak menyukai orang-orang maka saya bisa berpura-pura menyukai mereka :', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(127, 8, 5, 1, '', '', 'Jika ditinggalkan dalam rumah kosong sendirian, saya cenderung merasa takut cemas', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(128, 8, 5, 1, '', '', 'Saya suka mimpi tentang hal-hal yang fantastis dan aneh-aneh', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(129, 8, 5, 1, '', '', 'Agar saya dapat menentukan sikap yang baik terhadap suatu masalah / isu sosial, maka seblumnya saya :', '#####Membaca buku tentang / yang berhubungan dengan masalah tersebut', '#####Diantaranya', '#####mempelajari data statistik dan fakta-fakta lainnya yang berhubungan dengan masalah tersebut', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(130, 8, 5, 1, '', '', 'Dalam melaksanakan suatu tugas dalam kelompok saya lebih senang', '#####Mencoba memajukan organisasi ', '#####Diantaranya', '#####Mengurusi surat-surat dan menjaga agar peraturan-peraturan dipatuhi', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(131, 8, 5, 1, '', '', 'Saya merasa takut yang tak beralasan terhadap hal-hal tertentu, misalnya : pada binatang tertentu, tempat tertentu, benda tertentu dan lain sebagainya.', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 1, 3),
(132, 8, 5, 1, '', '', 'Saya cenderung untuk berbicara agak perlahan', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(133, 8, 5, 1, '', '', 'Saya rasa pengalaman-pengalaman yang sangat dramatis, yang saya alami dalam tahun-tahun ini tidak mempengaruhi kepribadian saya', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(134, 8, 5, 1, '', '', 'Saya curiga bahwa orang yang baik-baik didepan saya, dapat \"berkhianat\" dibelakang saya:', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(135, 8, 5, 1, '', '', 'Saya rasa apa yang dikatakan dalam puisi dapat juga dikatakan dalam kata-kata biasa', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(136, 8, 5, 1, '', '', 'Saya pemalu dan sangat berhati-hati dalam berteman dengan orang-orang yang baru saya kenal', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(137, 8, 5, 1, '', '', 'Waktu luang saya dirumah, saya pergunakan untuk :', '#####Ngobrol dan santai', '#####Diantaranya', '#####Melakukan pekerjaan-pekerjaan tertentu', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(138, 8, 5, 1, '', '', 'Saya biasanya tidak protes bila mendapat alat-alat yang sebenarnya kurang sesuai dengan yang seharusnya untuk melakukan suatu pekerjaan', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(139, 8, 5, 1, '', '', 'Banyak orang mengatakan bahwa saya suka melakukan sesuatu dengan cara saya sendiri', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(140, 8, 5, 1, '', '', 'Saya menjadi tidak sabar, marah, dan gelisah bila orang-orang memperlambat saya tidak pada tempatnya', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(141, 8, 5, 1, '', '', 'Apabila kedua jarum dari sebuah jam saling bertemu setiap 65 menit maka jam tersebut dapat dikatakan ', '#####Terlambat ', '#####Tepat', '#####Terlampau cepat', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(142, 8, 5, 1, '', '', 'Saya agaknya bisa menahan diri dalam mengutarakan perasaan saya dbandingkan dengan orang lain', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 1, 3),
(143, 8, 5, 1, '', '', 'Perhatian saya terhadap orang-orang lain mungkin tidaklah sebesar perhatian mereka terhadap diri saya', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(144, 8, 5, 1, '', '', 'Ingatan saya tidak banyak berubah dari hari ke hari', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(145, 8, 5, 1, '', '', 'Saya tampaknya tidak cocok bila harus berhubungan dengan orang-orang yang kaku terlalu sopan / formil', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(146, 8, 5, 1, '', '', 'Terkadang saya merasa ragu-ragu untuk menggunakan pemikiran / ide-ide sendiri, khawatir kalau ide tersebut tidak praktis.', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(147, 8, 5, 1, '', '', 'Lebih banyak kesulitan ditimbulkan orang-orang oleh karena :', '#####Mereka mengubah dan turut campur terhadap cara yang sudah disetuji / dianggap baik', '#####Diantaranya', '#####Mereka menolak cara-cara baru yang mempunyai harapan baik', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(148, 8, 5, 1, '', '', 'Menurut pendapat saya, setiap ceritera maupun film, harus mengingatkan kita pada suatu moral.', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(149, 8, 5, 1, '', '', 'Saya biasanya tidak pernah menyadari adanya propaganda-propaganda tersembunyi di dalam apa yang saya baca, kecuali bila ada orang lain yang menunjukkannya.', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 1, 3),
(150, 8, 5, 1, '', '', 'Saya merasa bahwa pembicaraan dari tetangga membosankan', '#####Dalam banyak hal', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(151, 8, 5, 1, '', '', 'Saya harus menahan diri untuk tidak terlalu banyak melibatkan diri / mencampuri masalah orang lain', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(152, 8, 5, 1, '', '', 'Saya lebih senang menjadi :', '#####Seorang sarjana teknik bangunan ', '#####Diantaranya', '#####Seorang guru pelaaran sosial dan budi pekerti', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(153, 8, 5, 1, '', '', 'Saya senang membicarakan masalah-masalah setempat dengan orang-orang lain', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(154, 8, 5, 1, '', '', 'Saya pernah hampir pingsan ketika mengalami suatu rasa sakit yang sangat atau bila melihat darah', '#####Ya', '#####Diantaranya', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(155, 8, 5, 1, '', '', 'Saya senang bepergian kapan saja', '#####Ya ', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(156, 8, 5, 1, '', '', 'Lebih baik keinginan tertentu saya dibatalkan daripada akan merepotkan pembantu jika dilaksanakan', '#####Ya', '#####Kadang-kadang', '#####Tidak', '#####', '#####', 'A', '2018-11-09 10:33:03', 0, 4),
(157, 8, 6, 1, '', '', '1', '#####Saya seorang pekerja keras', '#####Saya tidak suka uring-uringan', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(158, 8, 6, 1, '', '', '2', '#####Saya suka menghasilkan pekerjaan yang lebih baik daripada orang lain', '#####Saya akan tetap menangani suatu pekerjaan sampai selesai', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(159, 8, 6, 1, '', '', '3', '#####Saya suka menunjukkan pada orang lain cara melakukan sesuatu', '#####Saya ingin berusaha sebaik mungkin', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(160, 8, 6, 1, '', '', '4', '#####Saya suka melucu', '#####Saya senang memberitahu orang lain hal-hal yang harus dikerjakan', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(161, 8, 6, 1, '', '', '5', '#####Saya suka bergabung dengan kelompok', '#####Saya senang diperhatikan oleh kelompok', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(162, 8, 6, 1, '', '', '6', '#####Saya suka menjalin hubungan pribadi yang akrab', '#####Saya suka berteman dengan kelompok', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(163, 8, 6, 1, '', '', '7', '#####Saya dapat cepat berubah jika merasa perlu', '#####Saya berusaha mejalin hubungan pribadi yang akrab', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(164, 8, 6, 1, '', '', '8', '#####Saya suka menyerang kembali jika benar-benar disakiti', '#####Saya suka melakukan hal-hal yang baru dan berbeda', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(165, 8, 6, 1, '', '', '9', '#####Saya ingin agar atasan saya menyukai saya', '#####Saya suka menegur orang lain jika merasa melakukan kesalahan', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(166, 8, 6, 1, '', '', '10', '#####Saya suka mengikuti petunjuk-petunjuk yang diberikan pada saya', '#####Saya suka menyenangkan orang-orang yang menjadi atasan saya', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(167, 8, 6, 1, '', '', '11', '#####Saya berusaha keras sekali', '#####Saya seorang yang teratur. Saya meletakkan segala sesuatu pada tempatnya', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(168, 8, 6, 1, '', '', '12', '#####Saya dapat membuat orang lain melakukan apa yang saya inginkan ', '#####Saya tidak mudah marah', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(169, 8, 6, 1, '', '', '13', '#####Saya suka memberitahu kelompok, hal-hal yang harus mereka kerjakan', '#####Saya selalu bertahan pada suatu pekerjaan sampai selesai', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(170, 8, 6, 1, '', '', '14', '#####Saya ingin menjadi orang yang penuh gairah dan menarik', '#####Saya ingin menjadi orang yang sangat berhasil', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 0),
(171, 8, 6, 1, '', '', '15', '#####Saya ingin menjadi bagian dalam kelompok', '#####Saya suka membantu orang lain mengambil keputusan', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 0),
(172, 8, 6, 1, '', '', '16', '#####Saya cemas bila seseorang tidak menyukai saya', '#####Saya ingin agar orang lain memperhatikan saya', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(173, 8, 6, 1, '', '', '17', '#####Saya suka mencoba hal-hal baru', '#####Saya lebih suka bekerja bersama orang lain daripada sendiri', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(174, 8, 6, 1, '', '', '18', '#####Kadang-kadang saya menyalahkan orang lain jika ada yang tidak beres', '#####Saya merasa terganggu jika seseorang tidak menyukai saya', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(175, 8, 6, 1, '', '', '19', '#####Saya suka menyenangkan orang yang menjadi atasan saya', '#####Saya senang mencoba pekerjaan yang baru dan berbeda', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(176, 8, 6, 1, '', '', '20', '#####Saya menyukai petunjuk-petunjuk terperinci untuk melaksanakan tugas', '#####Saya suka memberitahu orang lain apabila mereka menjengkelkan', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(177, 8, 6, 1, '', '', '21', '#####Saya selalu berusaha keras', '#####Saya selalu melaksanakan setiap langkah dengan sangat hati-hati', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(178, 8, 6, 1, '', '', '22', '#####Saya seorang pemimpin yang baik', '#####Saya menata pekerjaan dengan baik', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(179, 8, 6, 1, '', '', '23', '#####Saya mudah marah', '#####Saya lambat dalam membuat keputusan', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(180, 8, 6, 1, '', '', '', '#####<p>Saya suka mengerjakan beberapa tugas pada saat yang bersamaan</p>\r\n', '#####<p>Bila berada dalam satu kelompok, saya suka berdiam diri</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(181, 8, 6, 1, '', '', '', '#####<p>Saya senang sekali bila diundang</p>\r\n', '#####<p>Saya ingin melakukan sesuatu lebih baik daripada orang lain</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(182, 8, 6, 1, '', '', '', '#####<p>Saya suka menjalin hubungan pribadi yang akrab</p>\r\n', '#####<p>Saya suka memberi nasihat pada orang lain</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(183, 8, 6, 1, '', '', '', '#####<p>Saya suka melakukan hal-hal yang baru dan berbeda</p>\r\n', '#####<p>Saya suka menceritakan bagaimana saya berhasil dalam melakukan sesuatu</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(184, 8, 6, 1, '', '', '', '#####<p>Apabila pendapat saya benar, saya suka mempertahankannya</p>\r\n', '#####<p>Saa ingin menjadi bagian dari suatu kelompok</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(185, 8, 6, 1, '', '', '', '#####<p>Saya tidak mau berbeda dari orang lain</p>\r\n', '#####<p>Saya berusaha akrab dengan orang lain</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(186, 8, 6, 1, '', '', '', '#####<p>Saya senang dibertahu bagaimana melakukan suatu pekerjaan</p>\r\n', '#####<p>Saya mudah bosan</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(187, 8, 6, 1, '', '', '', '#####<p>Saya bekerja keras</p>\r\n', '#####<p>Saya banyak berpikir dan membuat rencana</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(188, 8, 6, 1, '', '', '', '#####<p>Saya memimpin kelompok</p>\r\n', '#####<p>Detail (hal-hal kecil) menarik buat saya</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(189, 8, 6, 1, '', '', '', '#####<p>Saya membuat keputusan dengan mudah dan cepat</p>\r\n', '#####<p>Saya menyimpan barang-barang secara rapi dan teratur</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 0),
(190, 8, 6, 1, '', '', '', '#####<p>Saya membuat keputusan dengan mudah dan cepat</p>\r\n', '#####<p>Saya jarang marah atau sedih</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(191, 8, 6, 1, '', '', '', '#####<p>Saya ingin menjadi bagian dalam kelompok</p>\r\n', '#####<p>Saya ingin melakukan hanya satu pekerjaan pada satu waktu</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(192, 8, 6, 1, '', '', '', '#####<p>Saya berusaha berteman secara akrab</p>\r\n', '#####<p>Saya berusaha sangat keras untuk menjadi yang terbaik</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(193, 8, 6, 1, '', '', '', '#####<p>Saya suka gaya terbaru dalam hal pakaian dan mobil</p>\r\n', '#####<p>Saya suka bertanggung jawab atas orang lain</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(194, 8, 6, 1, '', '', '', '#####<p>Saya senang berdebat</p>\r\n', '#####<p>Saya suka mendapat perhatian</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 0),
(195, 8, 6, 1, '', '', '', '#####<p>Saya suka menyenangkan orang yang menjadi atasan saya</p>\r\n', '#####<p>Saya tertarik untuk menjadi bagian dari kelompok</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(196, 8, 6, 1, '', '', '', '#####<p>Saya suka mengikuti peraturan dengan hati-hati</p>\r\n', '#####<p>Saya suka orang lain mengenai saya dengan baik</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(197, 8, 6, 1, '', '', '', '#####<p>Saya berusaha keras sekali</p>\r\n', '#####<p>Saya sangat ramah</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(198, 8, 6, 1, '', '', '', '#####<p>Orang lain berpendapat bahwa saya pemimpin yang baik</p>\r\n', '#####<p>Saya berpikir hati-hati dan lama</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(199, 8, 6, 1, '', '', '', '#####<p>Saya sering memanfaatkan kesempatan</p>\r\n', '#####<p>Saya suka cerewet mengenai hal-hal yang kecil</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(200, 8, 6, 1, '', '', '', '#####<p>Orang lain berpendapat bahwa saya bekerja cepat</p>\r\n', '#####<p>Orang lain berpendapat bahwa saya menyimpan segala sesuatu secara teratur dan rapi</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(201, 8, 6, 1, '', '', '', '#####<p>Saya menyukai permainan dan olah raga</p>\r\n', '#####<p>Saya sangat menyenangkan</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(202, 8, 6, 1, '', '', '', '#####<p>Saya senang bila orang lain bersikap akrab dan ramah</p>\r\n', '#####<p>Saya selalu berusaha menyelesaikan sesuatu yang telah saya mulai</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(203, 8, 6, 1, '', '', '', '#####<p>Saya suka bereksperimen dan mencoba hal-hal baru</p>\r\n', '#####<p>Saya suka melaksanakan pekerjaan sulit dengan baik</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(204, 8, 6, 1, '', '', '', '#####<p>Saya suka diperlakukan secara adil</p>\r\n', '#####<p>Saya suka memberitahu orang lain cara mengerjakan sesuatu</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(205, 8, 6, 1, '', '', '', '#####<p>Saya suka melakukan hal-hal yang diharapkan dari saya</p>\r\n', '#####<p>Saya suka mendapat perhatian</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(206, 8, 6, 1, '', '', '', '#####<p>Saya suka petunjuk-petunjuk terperinci untuk melaksanakan suatu tugas</p>\r\n', '#####<p>Saya senang berada bersama orang lain</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(207, 8, 6, 1, '', '', '', '#####<p>Saya selalu berusaha melakukan pekerjaan secara sempurna</p>\r\n', '#####<p>Orang mengatakan bahwa saya hampir tidak pernah lelah</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(208, 8, 6, 1, '', '', '', '#####<p>Saya tipe seorang pemimpin</p>\r\n', '#####<p>Saya mudah berteman</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(209, 8, 6, 1, '', '', '', '#####<p>Saya memanfaatkan kesempatan</p>\r\n', '#####<p>Saya banyak sekali berfikir</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(210, 8, 6, 1, '', '', '', '#####<p>Saya bekerja dengan tempo yang cepat dan mantap</p>\r\n', '#####<p>Saya senang menangani pekerjaan detail</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(211, 8, 6, 1, '', '', '', '#####<p>Saya memilikibanyak tenaga untuk permainan dan olah raga</p>\r\n', '#####<p>Saya menyimpan segala sesuatu secara rapi dan teratur</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(212, 8, 6, 1, '', '', '', '#####<p>Saya bergaul dengan semua orang</p>\r\n', '#####<p>Saya berwatak tenang</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 0),
(213, 8, 6, 1, '', '', '', '#####<p>Saya ingin bertemu orang-orang baru dan melakukan hal-hal baru</p>\r\n', '#####<p>Saya selalu ingin menyelesaikan pekerjaan yang telah saya mulai</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(214, 8, 6, 1, '', '', '', '#####<p>Saya biasanya suka mempertahankan keyakinan saya</p>\r\n', '#####<p>Saya biasanya suka bekerja keras</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(215, 8, 6, 1, '', '', '', '#####<p>Saya menyukai saran-saran dan orang-orang yang saya kagumi</p>\r\n', '#####<p>Saya suka bertanggung jawab terhadap orang lain</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(216, 8, 6, 1, '', '', '', '#####<p>Saya membiarkan orang lain mempengaruhi diri saya secara kuat</p>\r\n', '#####<p>Saya suka mendapat banyak perhatian</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(217, 8, 6, 1, '', '', '', '#####<p>Saya biasanya bekerja keras sekali</p>\r\n', '#####<p>Saya biasanya bekerja cepat</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(218, 8, 6, 1, '', '', '', '#####<p>Apabila saya berbicara, kelompok menyimak</p>\r\n', '#####<p>Saya terampil menggunakan peralatan</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(219, 8, 6, 1, '', '', '', '#####<p>Saya lambat dalam berteman</p>\r\n', '#####<p>Saya lambat dalam mengambil keputusan</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(220, 8, 6, 1, '', '', '', '#####<p>Saya biasanya makan dengan cepat</p>\r\n', '#####<p>Saya senang membaca</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(221, 8, 6, 1, '', '', '', '#####<p>Saya menyukai pekerjaan yang membuat saya banyak bergerak</p>\r\n', '#####<p>Saya menyukai pekerjaan yang harus saya kerjakan secara hati-hati</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 1),
(222, 8, 6, 1, '', '', '', '#####<p>Saya berteman dengan sebanyak mungkin orang</p>\r\n', '#####<p>Saya cepat menemukan sesuatu yang telah saya sisihkan</p>\r\n', '#####', '#####', '#####', 'A', '2018-11-12 09:48:56', 0, 2),
(223, 8, 7, 1, '', '', 'Berapakah jumlah 40 orang dan 9 orang?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(224, 8, 7, 1, '', '', 'Kalau 5 orang harus membagi 55 rupiah, berapa rupiah yang diperoleh masing-masing?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(225, 8, 7, 1, '', '', 'Berapa jam akan ditempuh oleh sebuah kereta api dengan kecepatan 60 kilometer sejam dan panjang jalan itu 300 km?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(226, 8, 7, 1, '', '', 'Kalau saya berjalan ke muka 9 meter dan mundur lagi 4 meter, berapa jauh saya dari titik semula?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(227, 8, 7, 1, '', '', 'Berapa batang rokok dapat saudara beli dengan uang 160 rupiah kalau dengan 40 rupiah saudara mendapat tiga batang?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(228, 8, 7, 1, '', '', 'Kalau saudara mendapat uang Rp. 250,- dalam satu jam, berapa upahnya dalam 9 jam?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(229, 8, 7, 1, '', '', 'Amat mempunyai Rp. 19.000,- ia menerima lagi Rp. 7.500,- dan mengeluarkan Rp. 11.000,- Berapa uang Amat sekarang?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(230, 8, 7, 1, '', '', 'Sebuah bak persegi panjang, panjangnya 4 m dan lebarnya 3 m. Isi bak itu 40 m-kubik, berapakah dalamnya bak itu?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(231, 8, 7, 1, '', '', 'Seorang petani membeli beberapa ekor anak kambing dengan harga Rp. 6.000,-. Ia jual dengan harga Rp.. 7.500,- dan mendapat keuntungan 300 rupiah untuk tiap ekor anak kambing. Berapa ekor anak kambing yang ia beli', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(232, 8, 7, 1, '', '', 'Seorang pengendara motor menempuh jarak 500 km dalam waktu 5 hari. Hari pertama ia menempuh jarak 90 km. Hari kedua, 75 km. Hari ketiga, 120 km. Dn hari keempat 20 km. Berapa kilometer yang ditempuhnya pada hari kelima?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(233, 8, 7, 1, '', '', 'Saya membeli tiga butir telur dengan harga Rp. 15,- sebutirnya. Dan 1 kg gula seharga Rp. 120,-. Berapakah uang kembalinya bila uang saya adalah Rp. 1.000,-?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(234, 8, 7, 1, '', '', 'Empat orang menggali selokan air selama 7 hari. Berapa orang yang diperlukan untuk menggali selokan itu dalam setengah hari?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(235, 8, 7, 1, '', '', 'Kalau tujuh setengah kg gula merah harganya Rp. 900,- Berapa harga gula dua setengah kg gula merah itu?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(236, 8, 7, 1, '', '', 'Seorang membelanjakan sepersembilan dari uangnya untuk membeli kertas tulis dan lima kali dari padanya itu untuk membeli perangko. Sisanya ada Rp. 45,- Berapa uang semula?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(237, 8, 7, 1, '', '', 'Ibu membeli satu setengah kilogram mentega seharga Rp. 1.350,-. Berapa banyak ibu mendapat mentega dengan uang Rp. 3.000,-?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(238, 8, 7, 1, '', '', 'Saya memberikan sepertujuh dari uang saya pada si A dan tiga kali sebanyak itu pada si B. Sisa uang saya sekarang adalah Rp. 900,-. Jadi berapa uang saya semula?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(239, 8, 7, 1, '', '', 'Sebuah mobil berjalan dengan kecepatan rata-rata 30 km/jam, dalam cuaca berkabut. Dan kini hari terang, rata-rata 60 km/jam. Berapa lama waktu yang dibutuhkan untuk jarak sepanjang 210 km, kalau 2/7 dari perjalanan itu ditimpa kabut?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(240, 8, 7, 1, '', '', 'Suatu pintu air di suatu tempat mempunyai 523 cabang saluran. Dalam satu minggu terpakai 8891 liter air. Berapa liter raa-rata yang dipakai oleh keluarga dalam waktu itu?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(241, 8, 7, 1, '', '', 'Seorang tukang untuk membuat jalan harus memasang ubin yang panjangnya 6 dm (desimeter) dan lebarnya 40 cm (centimeter). Ia membutuhkan 600 buah ubin. Berapa meter persegikah luas jalan itu?', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(242, 8, 7, 1, '', '', 'Pada suatu tempat ada 1365 pemuda yang memenuhi syarat untuk dinas militer. Dan sembilan persen yang tidak memenuhi syarat. Berapa orang yang datang dalam pemeriksaan itu>', '#####', '#####', '#####', '#####', '#####', 'A', '2018-11-12 09:49:53', 0, 2),
(243, 11, 8, 1, '', '', '<p>Saya senang belajar</p>\r\n', '#####<p>Ya</p>\r\n', '#####<p>Kadang-kadang</p>\r\n', '#####<p>Tidak</p>\r\n', '', '', 'A', '0000-00-00 00:00:00', 1, 4),
(244, 11, 8, 1, '', '', 'a', '#####11', '#####111', '#####111', '#####', '#####', 'A', '2018-11-14 10:18:38', 2, 3),
(245, 11, 8, 1, '', '', 'b', '#####22', '#####222', '#####222', '#####', '#####', 'B', '2018-11-14 10:18:38', 2, 3),
(246, 11, 8, 1, '', '', '<p>c</p>\r\n', '#####<p>33</p>\r\n', '#####<p>333</p>\r\n', '#####<p>333</p>\r\n', '#####', '#####', 'A', '2018-11-14 10:18:38', 1, 4),
(247, 9, 5, 1, '', '', '1', '#####Saya seorang pekerja keras', '#####Saya tidak suka uring-uringan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(248, 9, 5, 1, '', '', '2', '#####Saya suka menghasilkan pekerjaan yang lebih baik daripada orang lain', '#####Saya akan tetap menangani suatu pekerjaan sampai selesai', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(249, 9, 5, 1, '', '', '3', '#####Saya suka menunjukkan pada orang lain cara melakukan sesuatu', '#####Saya ingin berusaha sebaik mungkin', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(250, 9, 5, 1, '', '', '4', '#####Saya suka melucu', '#####Saya senang memberitahu orang lain hal-hal yang harus dikerjakan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(251, 9, 5, 1, '', '', '5', '#####Saya suka bergabung dengan kelompok', '#####Saya senang diperhatikan oleh kelompok', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(252, 9, 5, 1, '', '', '6', '#####Saya suka menjalin hubungan pribadi yang akrab', '#####Saya suka berteman dengan kelompok', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(253, 9, 5, 1, '', '', '7', '#####Saya dapat cepat berubah jika merasa perlu', '#####Saya berusaha mejalin hubungan pribadi yang akrab', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(254, 9, 5, 1, '', '', '8', '#####Saya suka menyerang kembali jika benar-benar disakiti', '#####Saya suka melakukan hal-hal yang baru dan berbeda', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(255, 9, 5, 1, '', '', '9', '#####Saya ingin agar atasan saya menyukai saya', '#####Saya suka menegur orang lain jika merasa melakukan kesalahan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(256, 9, 5, 1, '', '', '10', '#####Saya suka mengikuti petunjuk-petunjuk yang diberikan pada saya', '#####Saya suka menyenangkan orang-orang yang menjadi atasan saya', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(257, 9, 5, 1, '', '', '11', '#####Saya berusaha keras sekali', '#####Saya seorang yang teratur. Saya meletakkan segala sesuatu pada tempatnya', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(258, 9, 5, 1, '', '', '12', '#####Saya dapat membuat orang lain melakukan apa yang saya inginkan ', '#####Saya tidak mudah marah', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(259, 9, 5, 1, '', '', '13', '#####Saya suka memberitahu kelompok, hal-hal yang harus mereka kerjakan', '#####Saya selalu bertahan pada suatu pekerjaan sampai selesai', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(260, 9, 5, 1, '', '', '14', '#####Saya ingin menjadi orang yang penuh gairah dan menarik', '#####Saya ingin menjadi orang yang sangat berhasil', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(261, 9, 5, 1, '', '', '15', '#####Saya ingin menjadi bagian dalam kelompok', '#####Saya suka membantu orang lain mengambil keputusan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(262, 9, 5, 1, '', '', '16', '#####Saya cemas bila seseorang tidak menyukai saya', '#####Saya ingin agar orang lain memperhatikan saya', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(263, 9, 5, 1, '', '', '17', '#####Saya suka mencoba hal-hal baru', '#####Saya lebih suka bekerja bersama orang lain daripada sendiri', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(264, 9, 5, 1, '', '', '18', '#####Kadang-kadang saya menyalahkan orang lain jika ada yang tidak beres', '#####Saya merasa terganggu jika seseorang tidak menyukai saya', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(265, 9, 5, 1, '', '', '19', '#####Saya suka menyenangkan orang yang menjadi atasan saya', '#####Saya senang mencoba pekerjaan yang baru dan berbeda', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(266, 9, 5, 1, '', '', '20', '#####Saya menyukai petunjuk-petunjuk terperinci untuk melaksanakan tugas', '#####Saya suka memberitahu orang lain apabila mereka menjengkelkan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(267, 9, 5, 1, '', '', '21', '#####Saya selalu berusaha keras', '#####Saya selalu melaksanakan setiap langkah dengan sangat hati-hati', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(268, 9, 5, 1, '', '', '22', '#####Saya seorang pemimpin yang baik', '#####Saya menata pekerjaan dengan baik', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(269, 9, 5, 1, '', '', '23', '#####Saya mudah marah', '#####Saya lambat dalam membuat keputusan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(270, 9, 5, 1, '', '', '24', '#####Saya suka mengerjakan beberapa tugas pada saat yang bersamaan', '#####Bila berada dalam satu kelompok, saya suka berdiam diri', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(271, 9, 5, 1, '', '', '25', '#####Saya senang sekali bila diundang', '#####Saya ingin melakukan sesuatu lebih baik daripada orang lain', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(272, 9, 5, 1, '', '', '26', '#####Saya suka menjalin hubungan pribadi yang akrab', '#####Saya suka memberi nasihat pada orang lain', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(273, 9, 5, 1, '', '', '27', '#####Saya suka melakukan hal-hal yang baru dan berbeda ', '#####Saya suka menceritakan bagaimana saya berhasil dalam melakukan sesuatu', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(274, 9, 5, 1, '', '', '28', '#####Apabila pendapat saya benar, saya suka mempertahankannya', '#####Saa ingin menjadi bagian dari suatu kelompok', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(275, 9, 5, 1, '', '', '29', '#####Saya tidak mau berbeda dari orang lain', '#####Saya berusaha akrab dengan orang lain', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(276, 9, 5, 1, '', '', '30', '#####Saya senang dibertahu bagaimana melakukan suatu pekerjaan', '#####Saya mudah bosan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(277, 9, 5, 1, '', '', '31', '#####Saya bekerja keras', '#####Saya banyak berpikir dan membuat rencana', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(278, 9, 5, 1, '', '', '32', '#####Saya memimpin kelompok', '#####Detail (hal-hal kecil) menarik buat saya', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(279, 9, 5, 1, '', '', '33', '#####Saya membuat keputusan dengan mudah dan cepat', '#####Saya menyimpan barang-barang secara rapi dan teratur', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0);
INSERT INTO `m_soal` (`id`, `id_guru`, `id_mapel`, `bobot`, `file`, `tipe_file`, `soal`, `opsi_a`, `opsi_b`, `opsi_c`, `opsi_d`, `opsi_e`, `jawaban`, `tgl_input`, `jml_benar`, `jml_salah`) VALUES
(280, 9, 5, 1, '', '', '34', '#####Saya membuat keputusan dengan mudah dan cepat', '#####Saya jarang marah atau sedih', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(281, 9, 5, 1, '', '', '35', '#####Saya ingin menjadi bagian dalam kelompok', '#####Saya ingin melakukan hanya satu pekerjaan pada satu waktu', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(282, 9, 5, 1, '', '', '36', '#####Saya berusaha berteman secara akrab', '#####Saya berusaha sangat keras untuk menjadi yang terbaik', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(283, 9, 5, 1, '', '', '37', '#####Saya suka gaya terbaru dalam hal pakaian dan mobil', '#####Saya suka bertanggung jawab atas orang lain', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(284, 9, 5, 1, '', '', '38', '#####Saya senang berdebat', '#####Saya suka mendapat perhatian', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(285, 9, 5, 1, '', '', '39', '#####Saya suka menyenangkan orang yang menjadi atasan saya', '#####Saya tertarik untuk menjadi bagian dari kelompok', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(286, 9, 5, 1, '', '', '40', '#####Saya suka mengikuti peraturan dengan hati-hati', '#####Saya suka orang lain mengenai saya dengan baik', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(287, 9, 5, 1, '', '', '41', '#####Saya berusaha keras sekali', '#####Saya sangat ramah', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(288, 9, 5, 1, '', '', '42', '#####Orang lain berpendapat bahwa saya pemimpin yang baik', '#####Saya berpikir hati-hati dan lama', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(289, 9, 5, 1, '', '', '43', '#####Saya sering memanfaatkan kesempatan', '#####Saya suka cerewet mengenai hal-hal yang kecil', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(290, 9, 5, 1, '', '', '44', '#####Orang lain berpendapat bahwa saya bekerja cepat', '#####Orang lain berpendapat bahwa saya menyimpan segala sesuatu secara teratur dan rapi', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(291, 9, 5, 1, '', '', '45', '#####Saya menyukai permainan dan olah raga', '#####Saya sangat menyenangkan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(292, 9, 5, 1, '', '', '46', '#####Saya senang bila orang lain bersikap akrab dan ramah', '#####Saya selalu berusaha menyelesaikan sesuatu yang telah saya mulai', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(293, 9, 5, 1, '', '', '47', '#####Saya suka bereksperimen dan mencoba hal-hal baru', '#####Saya suka melaksanakan pekerjaan sulit dengan baik', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(294, 9, 5, 1, '', '', '48', '#####Saya suka diperlakukan secara adil', '#####Saya suka memberitahu orang lain cara mengerjakan sesuatu', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(295, 9, 5, 1, '', '', '49', '#####Saya suka melakukan hal-hal yang diharapkan dari saya ', '#####Saya suka mendapat perhatian', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(296, 9, 5, 1, '', '', '50', '#####Saya suka petunjuk-petunjuk terperinci untuk melaksanakan suatu tugas', '#####Saya senang berada bersama orang lain', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(297, 9, 5, 1, '', '', '51', '#####Saya selalu berusaha melakukan pekerjaan secara sempurna', '#####Orang mengatakan bahwa saya hampir tidak pernah lelah', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(298, 9, 5, 1, '', '', '52', '#####Saya tipe seorang pemimpin', '#####Saya mudah berteman', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(299, 9, 5, 1, '', '', '53', '#####Saya memanfaatkan kesempatan', '#####Saya banyak sekali berfikir', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(300, 9, 5, 1, '', '', '54', '#####Saya bekerja dengan tempo yang cepat dan mantap', '#####Saya senang menangani pekerjaan detail', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(301, 9, 5, 1, '', '', '55', '#####Saya memilikibanyak tenaga untuk permainan dan olah raga', '#####Saya menyimpan segala sesuatu secara rapi dan teratur', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(302, 9, 5, 1, '', '', '56', '#####Saya bergaul dengan semua orang', '#####Saya berwatak tenang', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(303, 9, 5, 1, '', '', '57', '#####Saya ingin bertemu orang-orang baru dan melakukan hal-hal baru', '#####Saya selalu ingin menyelesaikan pekerjaan yang telah saya mulai', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(304, 9, 5, 1, '', '', '58', '#####Saya biasanya suka mempertahankan keyakinan saya', '#####Saya biasanya suka bekerja keras', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(305, 9, 5, 1, '', '', '59', '#####Saya menyukai saran-saran dan orang-orang yang saya kagumi', '#####Saya suka bertanggung jawab terhadap orang lain', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(306, 9, 5, 1, '', '', '60', '#####Saya membiarkan orang lain mempengaruhi diri saya secara kuat', '#####Saya suka mendapat banyak perhatian', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(307, 9, 5, 1, '', '', '61', '#####Saya biasanya bekerja keras sekali', '#####Saya biasanya bekerja cepat', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(308, 9, 5, 1, '', '', '62', '#####Apabila saya berbicara, kelompok menyimak', '#####Saya terampil menggunakan peralatan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(309, 9, 5, 1, '', '', '63', '#####Saya lambat dalam berteman', '#####Saya lambat dalam mengambil keputusan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(310, 9, 5, 1, '', '', '64', '#####Saya biasanya makan dengan cepat', '#####Saya senang membaca', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(311, 9, 5, 1, '', '', '65', '#####Saya menyukai pekerjaan yang membuat saya banyak bergerak', '#####Saya menyukai pekerjaan yang harus saya kerjakan secara hati-hati', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0),
(312, 9, 5, 1, '', '', '66', '#####Saya berteman dengan sebanyak mungkin orang', '#####Saya cepat menemukan sesuatu yang telah saya sisihkan', '#####', '#####', '#####', 'A', '2019-01-08 14:44:13', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tr_guru_mapel`
--

CREATE TABLE `tr_guru_mapel` (
  `id` int(6) NOT NULL,
  `id_guru` int(6) NOT NULL,
  `id_mapel` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_guru_mapel`
--

INSERT INTO `tr_guru_mapel` (`id`, `id_guru`, `id_mapel`) VALUES
(23, 8, 5),
(24, 10, 5),
(25, 10, 6),
(26, 11, 5),
(27, 11, 6),
(28, 11, 7),
(29, 11, 8),
(30, 9, 5),
(31, 9, 6),
(32, 9, 7),
(33, 9, 8);

-- --------------------------------------------------------

--
-- Table structure for table `tr_guru_tes`
--

CREATE TABLE `tr_guru_tes` (
  `id` int(6) NOT NULL,
  `id_guru` int(6) NOT NULL,
  `id_mapel` int(6) NOT NULL,
  `nama_ujian` varchar(200) NOT NULL,
  `jumlah_soal` int(6) NOT NULL,
  `waktu` int(6) NOT NULL,
  `jenis` enum('acak','set') NOT NULL,
  `detil_jenis` varchar(500) NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `terlambat` datetime NOT NULL,
  `token` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_guru_tes`
--

INSERT INTO `tr_guru_tes` (`id`, `id_guru`, `id_mapel`, `nama_ujian`, `jumlah_soal`, `waktu`, `jenis`, `detil_jenis`, `tgl_mulai`, `terlambat`, `token`) VALUES
(2, 8, 6, 'Tes Preference Inventory', 50, 60, 'acak', '', '2018-11-12 01:00:00', '2018-11-30 01:00:00', 'PWIXE'),
(3, 8, 7, 'Aritmatika', 20, 60, 'acak', '', '2018-11-12 01:00:00', '2018-11-30 01:00:00', 'QWKBO'),
(4, 11, 8, 'Ujian Mekar', 4, 120, 'acak', '', '2018-11-14 01:00:00', '2018-12-27 01:00:00', 'JOEBF'),
(5, 8, 5, 'Psikologi 2.0', 50, 60, 'set', '', '2019-01-08 01:00:00', '2019-01-31 01:00:00', 'UERVG'),
(6, 8, 5, 'Aritmatika 2.0', 105, 120, 'acak', '', '2019-01-08 01:00:00', '2019-01-28 01:00:00', 'BNVNV'),
(7, 9, 5, 'SDM Psikologi', 50, 120, 'set', '', '2019-01-08 01:00:00', '2019-01-31 01:00:00', 'RTDRH'),
(8, 9, 5, 'Tes Psikologi', 10, 60, 'set', '', '2019-01-16 01:00:00', '2019-01-31 01:00:00', 'EKZGB');

-- --------------------------------------------------------

--
-- Table structure for table `tr_ikut_ujian`
--

CREATE TABLE `tr_ikut_ujian` (
  `id` int(6) NOT NULL,
  `id_tes` int(6) NOT NULL,
  `id_user` int(6) NOT NULL,
  `list_soal` longtext NOT NULL,
  `list_jawaban` longtext NOT NULL,
  `jml_benar` int(6) NOT NULL,
  `nilai` decimal(10,2) NOT NULL,
  `nilai_bobot` decimal(10,2) NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `tgl_selesai` datetime NOT NULL,
  `status` enum('Y','N') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_ikut_ujian`
--

INSERT INTO `tr_ikut_ujian` (`id`, `id_tes`, `id_user`, `list_soal`, `list_jawaban`, `jml_benar`, `nilai`, `nilai_bobot`, `tgl_mulai`, `tgl_selesai`, `status`) VALUES
(1, 3, 8, '239,227,242,238,223,226,241,237,236,229,225,224,234,240,231,232,233,235,230,228', '239::N,227::N,242::N,238::N,223::N,226::N,241::N,237::N,236::N,229::N,225::N,224::N,234::N,240::N,231::N,232::N,233::N,235::N,230::N,228::N', 0, '0.00', '0.00', '2018-11-12 13:09:55', '2018-11-12 14:09:55', 'N'),
(2, 2, 8, '164,186,219,207,178,182,167,222,203,202,211,201,196,179,159,192,204,209,215,198,176,161,162,169,190,175,157,165,213,160,177,185,174,191,216,208,168,172,200,210,183,163,181,173,206,180,184,166,217,205', '164:C:N,186::N,219::N,207::N,178::N,182::N,167::N,222::N,203::N,202::N,211::N,201::N,196::N,179::N,159::N,192::N,204::N,209::N,215::N,198::N,176::N,161::N,162::N,169::N,190::N,175::N,157::N,165::N,213::N,160::N,177::N,185::N,174::N,191::N,216::N,208::N,168::N,172::N,200::N,210::N,183::N,163::N,181::N,173::N,206::N,180::N,184::N,166::N,217::N,205::N', 0, '0.00', '0.00', '2018-11-12 16:07:38', '2018-11-12 17:07:38', 'N'),
(3, 2, 7, '203,222,197,169,174,182,192,221,188,178,181,208,219,184,214,193,211,204,199,205,190,167,175,164,158,172,186,185,191,217,215,210,198,179,195,218,159,162,206,216,220,176,213,202,163,166,173,201,187,160', '203::N,222::N,197::N,169::N,174::N,182::N,192::N,221::N,188::N,178::N,181::N,208::N,219::N,184::N,214::N,193::N,211::N,204::N,199::N,205::N,190::N,167::N,175::N,164::N,158::N,172::N,186::N,185::N,191::N,217::N,215::N,210::N,198::N,179::N,195::N,218::N,159::N,162::N,206::N,216::N,220::N,176::N,213::N,202::N,163::N,166::N,173::N,201::N,187::N,160::N', 0, '0.00', '0.00', '2018-11-13 09:41:03', '2018-11-13 10:41:03', 'N'),
(4, 1, 7, '88,119,114,70,113,76,150,118,112,90,107,71,68,133,57,146,66,85,92,87,156,111,82,117,149,140,155,137,139,104,73,148,84,152,142,67,143,123,128,79,124,81,52,60,53,141,103,134,101,122,65,95,72,61,110,116,89,97,108,145,154,93,69,62,91,153,74,144,136,132,147,98,64,83,63,100,59,129,125,54,99,135,120,130,96,58,77,131,75,55,126,80,94,109,151,86,115,105,56,102,78,121,138,106,127', '88:A:N,119:B:N,114:A:N,70::N,113::N,76::N,150::N,118::N,112::N,90::N,107::N,71::N,68::N,133::N,57::N,146::N,66::N,85::N,92::N,87::N,156::N,111::N,82::N,117::N,149::N,140::N,155::N,137::N,139::N,104::N,73::N,148::N,84::N,152::N,142::N,67::N,143::N,123::N,128::N,79::N,124::N,81::N,52::N,60::N,53::N,141::N,103::N,134::N,101::N,122::N,65::N,95::N,72::N,61::N,110::N,116::N,89::N,97::N,108::N,145::N,154::N,93::N,69::N,62::N,91::N,153::N,74::N,144::N,136::N,132::N,147::N,98::N,64::N,83::N,63::N,100::N,59::N,129::N,125::N,54::N,99::N,135::N,120::N,130::N,96::N,58::N,77::N,131::N,75::N,55::N,126::N,80::N,94::N,109::N,151::N,86::N,115::N,105::N,56::N,102::N,78::N,121::N,138::N,106::N,127::N', 0, '0.00', '0.00', '2018-11-13 09:41:38', '2018-11-13 10:41:38', 'Y'),
(5, 1, 8, '149,105,131,56,106,130,98,67,72,153,150,127,70,107,53,147,146,114,117,143,102,62,135,144,155,118,101,76,63,89,116,139,65,71,148,120,84,103,90,152,93,57,128,111,115,99,112,92,59,126,74,129,133,110,137,75,134,154,124,151,73,94,138,80,145,66,122,68,119,64,108,61,136,97,109,95,100,156,58,81,121,79,140,96,77,85,69,82,141,86,123,113,54,91,132,87,55,142,83,52,60,78,125,88,104', '149:A:N,105:B:N,131::N,56::N,106::N,130::N,98::N,67::N,72::N,153::N,150::N,127::N,70::N,107::N,53::N,147::N,146::N,114::N,117::N,143::N,102::N,62::N,135::N,144::N,155::N,118::N,101::N,76::N,63::N,89::N,116::N,139::N,65::N,71::N,148::N,120::N,84::N,103::N,90::N,152::N,93::N,57::N,128::N,111::N,115::N,99::N,112::N,92::N,59::N,126::N,74::N,129::N,133::N,110::N,137::N,75::N,134::N,154::N,124::N,151::N,73::N,94::N,138::N,80::N,145::N,66::N,122::N,68::N,119::N,64::N,108::N,61::N,136::N,97::N,109::N,95::N,100::N,156::N,58::N,81::N,121::N,79::N,140::N,96::N,77::N,85::N,69::N,82::N,141::N,86::N,123::N,113::N,54::N,91::N,132::N,87::N,55::N,142::N,83::N,52::N,60::N,78::N,125::N,88::N,104::N', 1, '0.95', '0.95', '2018-11-14 10:02:47', '2018-11-14 11:02:47', 'N'),
(6, 3, 7, '229,228,227,223,241,232,224,234,240,238,236,226,233,230,237,225,235,231,242,239', '229::N,228::N,227::N,223::N,241::N,232::N,224::N,234::N,240::N,238::N,236::N,226::N,233::N,230::N,237::N,225::N,235::N,231::N,242::N,239::N', 0, '0.00', '0.00', '2018-11-14 10:03:37', '2018-11-14 11:03:37', 'N'),
(7, 4, 11, '243,246,244,245', '243:A:N,246:B:N,244:A:N,245:B:N', 3, '75.00', '75.00', '2018-11-14 10:23:28', '2018-11-14 11:23:28', 'N'),
(8, 1, 10, '99,52,60,85,56,133,110,107,72,154,139,93,61,115,134,150,54,96,130,113,70,65,128,138,126,92,120,152,122,80,108,137,104,55,91,68,112,153,142,83,59,101,124,95,132,106,102,135,123,57,90,116,84,62,53,155,97,82,78,100,75,111,79,88,148,149,74,121,77,89,69,66,145,67,118,81,105,125,141,87,136,64,114,146,147,143,73,117,144,63,76,119,98,103,71,151,129,58,156,94,127,131,109,86,140', '99::N,52::N,60::N,85::N,56::N,133::N,110::N,107::N,72::N,154::N,139::N,93::N,61::N,115::N,134::N,150::N,54::N,96::N,130::N,113::N,70::N,65::N,128::N,138::N,126::N,92::N,120::N,152::N,122::N,80::N,108::N,137::N,104::N,55::N,91::N,68::N,112::N,153::N,142::N,83::N,59::N,101::N,124::N,95::N,132::N,106::N,102::N,135::N,123::N,57::N,90::N,116::N,84::N,62::N,53::N,155::N,97::N,82::N,78::N,100::N,75::N,111::N,79::N,88::N,148::N,149::N,74::N,121::N,77::N,89::N,69::N,66::N,145::N,67::N,118::N,81::N,105::N,125::N,141::N,87::N,136::N,64::N,114::N,146::N,147::N,143::N,73::N,117::N,144::N,63::N,76::N,119::N,98::N,103::N,71::N,151::N,129::N,58::N,156::N,94::N,127::N,131::N,109::N,86::N,140::N', 0, '0.00', '0.00', '2018-11-14 10:25:05', '2018-11-14 11:25:05', 'N'),
(9, 1, 6, '131,88,142,54,107,146,52,95,59,155,124,67,56,77,74,111,148,133,64,150,126,153,137,92,134,101,61,104,129,110,68,65,105,121,116,127,147,94,103,113,145,109,91,83,102,78,76,152,96,62,140,72,135,115,70,141,81,85,118,125,63,108,144,154,84,100,98,106,79,57,55,114,138,136,87,143,130,156,120,93,82,71,66,58,128,86,69,53,119,132,99,117,80,90,60,73,139,149,112,122,75,97,151,123,89', '131:A:N,88:B:N,142:A:N,54:C:N,107:B:N,146::N,52::N,95::N,59::N,155::N,124::N,67:B:N,56::N,77::N,74::N,111:C:N,148::N,133::N,64::N,150::N,126::N,153::N,137::N,92::N,134::N,101::N,61::N,104::N,129::N,110::N,68::N,65::N,105::N,121::N,116::N,127::N,147::N,94::N,103::N,113::N,145::N,109::N,91::N,83::N,102::N,78::N,76::N,152::N,96::N,62::N,140::N,72::N,135::N,115::N,70::N,141::N,81::N,85::N,118::N,125::N,63::N,108::N,144::N,154::N,84::N,100::N,98::N,106::N,79::N,57::N,55::N,114::N,138::N,136::N,87::N,143::N,130::N,156::N,120::N,93::N,82::N,71::N,66::N,58::N,128::N,86::N,69::N,53::N,119::N,132::N,99::N,117::N,80::N,90::N,60::N,73::N,139::N,149::N,112::N,122::N,75::N,97::N,151::N,123::N,89::N', 2, '1.90', '1.90', '2018-11-14 10:36:59', '2018-11-14 11:36:59', 'N'),
(10, 4, 12, '245,244,243,246', '245::N,244::N,243::N,246::N', 0, '0.00', '0.00', '2018-11-30 11:01:02', '2018-11-30 12:01:02', 'N'),
(11, 4, 13, '243,244,245,246', '243::N,244::N,245::N,246::N', 0, '0.00', '0.00', '2018-11-30 12:01:41', '2018-11-30 13:01:41', 'N'),
(12, 4, 8, '245,244,246,243', '245:B:N,244:A:N,246:C:N,243::N', 2, '50.00', '50.00', '2018-11-30 13:19:52', '2018-11-30 15:19:52', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `tr_ujian`
--

CREATE TABLE `tr_ujian` (
  `id` int(11) NOT NULL,
  `id_tes` int(11) NOT NULL,
  `id_guru` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_soal` int(11) NOT NULL,
  `jawaban` varchar(30) NOT NULL,
  `detail_jawaban` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_ujian`
--

INSERT INTO `tr_ujian` (`id`, `id_tes`, `id_guru`, `id_user`, `id_soal`, `jawaban`, `detail_jawaban`) VALUES
(2, 4, 9, 8, 249, 'B', 'Tidak diantaranya'),
(3, 4, 9, 8, 245, 'B', 'Tidak diantaranya'),
(4, 4, 9, 8, 244, 'A', 'Ya'),
(5, 4, 9, 8, 246, 'B', 'Tidak diantaranya'),
(6, 4, 9, 8, 243, 'A', 'Ya');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `m_admin`
--
ALTER TABLE `m_admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kon_id` (`kon_id`);

--
-- Indexes for table `m_guru`
--
ALTER TABLE `m_guru`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_mapel`
--
ALTER TABLE `m_mapel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_siswa`
--
ALTER TABLE `m_siswa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_soal`
--
ALTER TABLE `m_soal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_guru` (`id_guru`),
  ADD KEY `id_mapel` (`id_mapel`);

--
-- Indexes for table `tr_guru_mapel`
--
ALTER TABLE `tr_guru_mapel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_guru` (`id_guru`),
  ADD KEY `id_mapel` (`id_mapel`);

--
-- Indexes for table `tr_guru_tes`
--
ALTER TABLE `tr_guru_tes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_guru` (`id_guru`),
  ADD KEY `id_mapel` (`id_mapel`);

--
-- Indexes for table `tr_ikut_ujian`
--
ALTER TABLE `tr_ikut_ujian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tes` (`id_tes`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `tr_ujian`
--
ALTER TABLE `tr_ujian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_guru` (`id_guru`,`id_user`,`id_soal`),
  ADD KEY `id_tes` (`id_tes`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `m_admin`
--
ALTER TABLE `m_admin`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `m_guru`
--
ALTER TABLE `m_guru`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `m_mapel`
--
ALTER TABLE `m_mapel`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `m_siswa`
--
ALTER TABLE `m_siswa`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `m_soal`
--
ALTER TABLE `m_soal`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=313;

--
-- AUTO_INCREMENT for table `tr_guru_mapel`
--
ALTER TABLE `tr_guru_mapel`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `tr_guru_tes`
--
ALTER TABLE `tr_guru_tes`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tr_ikut_ujian`
--
ALTER TABLE `tr_ikut_ujian`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tr_ujian`
--
ALTER TABLE `tr_ujian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
