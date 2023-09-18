<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Laporan extends CI_Controller
{
	public function __construct()
	{
		parent::__construct();
		is_logged_in();
		$this->load->model([
			'Master_model' => 'master',
			'Guru_model'   => 'guru'
		]);
		$this->load->library('fpdf');
		define('FPDF_FONTPATH', $this->config->item('fonts_path'));
	}

	public function datamodul()
	{
		$data = [
			'title' => 'REKAPITULASI DATA MODUL AJAR',
			'user' => $this->admin->sesi(),
			'ajar' => $this->master->getAjar(),
		];


		$this->load->view('report/datamodul', $data);
		// var_dump($data);
	}

	public function dataguru()
	{
		$data = [
			'title' => 'REKAPITULASI DATA GURU',
			'guru'  => $this->master->getGuru()
		];

		$this->load->view('report/dataguru', $data);
	}

	public function datakelas()
	{
		$data = [
			'title' => 'Rekap Data Kelas',
			'user'  => $this->admin->sesi(),
		];

		$this->load->view('templates/header', $data);
		$this->load->view('templates/sidebar', $data);
		$this->load->view('templates/topbar', $data);
		$this->load->view('report/filter-kelas', $data);
		$this->load->view('templates/footer');
	}

	public function reportkelas()
	{
		$Tingkat = $this->uri->segment(3);
		$data    = [
			'title' => 'REKAPITULASI DATA KELAS',
			'tingkat' => $Tingkat,
			'kelas' => $this->master->getKelasByTingkatan($Tingkat)
		];

		$this->load->view('report/datakelas', $data);
	}

	// public function datasiswa()
	// {
	//     $data = [
	//         'title' => 'Rekap Data Siswa',
	//         'user'  => $this->admin->sesi(),
	//         'jurusan' => $this->master->getAllJurusan()
	//     ];

	//     $this->load->view('templates/header', $data);
	//     $this->load->view('templates/sidebar', $data);
	//     $this->load->view('templates/topbar', $data);
	//     $this->load->view('report/filter-siswa', $data);
	//     $this->load->view('templates/footer');
	// }

	public function getkelas()
	{
		echo json_encode($this->master->getDataKelas($_POST['id']));
	}

	public function reportsiswa()
	{
		$Kelas = $this->uri->segment(3);
		$data    = [
			'title' => 'REKAPITULASI DATA SISWA',
			'kelas' => $this->master->getKelasById($Kelas),
			'siswa' => $this->master->getDataSiswa($Kelas)
		];

		$this->load->view('report/datasiswa', $data);
	}

	public function dataampu()
	{
		$data = [
			'title' => 'Rekap Data Ampu',
			'user'  => $this->admin->sesi(),
		];

		$this->load->view('templates/header', $data);
		$this->load->view('templates/sidebar', $data);
		$this->load->view('templates/topbar', $data);
		$this->load->view('report/filter-ampu', $data);
		$this->load->view('templates/footer');
	}

	public function report_ampu()
	{
		$kelas = $this->input->post('tingkatan');
		$semeter = $this->input->post('semester');
		$periode = $this->input->post('periode');

		$data = [
			'title' => 'REKAPITULASI DATA AMPU',
			'kelas' => $kelas,
			'semester' => $semeter,
			'ampu'  => $this->master->getAmpu($kelas, $semeter, $periode)
		];

		$this->load->view('report/dataampu', $data);
	}

	public function dataagenda()
	{
		$data = [
			'title' => 'Rekap Data Agenda',
			'user'  => $this->admin->sesi(),
			'guru'  => $this->master->getAllGuru()
		];

		$this->load->view('templates/header', $data);
		$this->load->view('templates/sidebar', $data);
		$this->load->view('templates/topbar', $data);
		$this->load->view('report/filter-agenda', $data);
		$this->load->view('templates/footer');
	}

	public function reportagenda()
	{
		$nip = $this->uri->segment(3);

		$data = [
			'title' => 'REKAPITULASI AGENDA KEGIATAN',
			'guru'  => $this->master->getGuruById($nip),
			'agenda' => $this->guru->getDataAgenda($nip)
		];

		$this->load->view('report/dataagenda', $data);
	}

	public function dataabsen()
	{
		$data = [
			'title' => 'Rekap Absensi',
			'user'  => $this->admin->sesi(),
			'kelas' => $this->master->getkelas()
		];

		$this->load->view('templates/header', $data);
		$this->load->view('templates/sidebar', $data);
		$this->load->view('templates/topbar', $data);
		$this->load->view('report/filter-absen', $data);
		$this->load->view('templates/footer');
	}

	public function report_absen()
	{
		$kelas = $this->input->post('kelas');
		$semester = $this->input->post('semester');

		$q = $this->db->get_where('tb_kelas', ['kodekelas' => $kelas])->row_array();

		$data = [
			'title'     => 'REKAPITULASI ABSENSI SISWA',
			'kelas'     => $q,
			'semester'  => $semester,
			'absen'     => $this->master->getAbsen($kelas, $semester)->result()
		];

		$this->load->view('report/dataabsen', $data);
	}
}
