<?php
defined('BASEPATH') or exit('No direct script access allowed');

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Reader\Xlsx;
use PhpOffice\PhpSpreadsheet\Reader\Csv;

class Import extends CI_Controller
{
	public function upload()
	{
		$file_mimes = ['application/octet-stream', 'application/vnd.ms-excel', 'application/x-csv', 'text/x-csv', 'text/csv', 'application/csv', 'application/excel', 'application/vnd.msexcel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'];

		if (isset($_FILES['berkas_excel']['name']) && in_array($_FILES['berkas_excel']['type'], $file_mimes)) {
			$arr_file = explode('.', $_FILES['berkas_excel']['name']);
			$extension = end($arr_file);

			if ('csv' == $extension) {
				$reader = new \PhpOffice\PhpSpreadsheet\Reader\Csv();
			} else {
				$reader = new \PhpOffice\PhpSpreadsheet\Reader\Xlsx();
			}

			$spreadsheet = $reader->load($_FILES['berkas_excel']['tmp_name']);

			$sheetData = $spreadsheet->getActiveSheet()->toArray();
			for ($i = 1; $i < count($sheetData); $i++) {
				$row = $sheetData[$i];

				if (empty($row[0])) {
					// Lewati baris yang tidak memiliki kode mapel
					continue;
				}

				$data = [
					'nip' => $row[1],
					'kodeguru' => $row[2],
					'namaguru' => $row[3] ?? '',
					'jeniskelamin'  => $row[4] ?? '',
					'tempatlahir' => $row[5] ?? '',
					'tgllahir' => $row[6] ?? '',
					'alamatguru' => $row[7] ?? '',
					'notelpseluler' => $row[8] ?? '',
					'emailguru' => $row[9] ?? '',
					'kodekelas' => $row[10] ?? '',
				];

				$this->db->insert('tb_guru', $data);
			}
			$this->session->set_flashdata('message', 'data guru berhasil di-import');
			redirect('master/guru');
		}
	}

	public function uploadmapel()
	{
		$file_mimes = ['application/octet-stream', 'application/vnd.ms-excel', 'application/x-csv', 'text/x-csv', 'text/csv', 'application/csv', 'application/excel', 'application/vnd.msexcel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'];

		if (isset($_FILES['berkas_excel']['name']) && in_array($_FILES['berkas_excel']['type'], $file_mimes)) {
			$arr_file = explode('.', $_FILES['berkas_excel']['name']);
			$extension = end($arr_file);

			if ('csv' == $extension) {
				$reader = new \PhpOffice\PhpSpreadsheet\Reader\Csv();
			} else {
				$reader = new \PhpOffice\PhpSpreadsheet\Reader\Xlsx();
			}

			try {
				$spreadsheet = $reader->load($_FILES['berkas_excel']['tmp_name']);
				$sheetData = $spreadsheet->getActiveSheet()->toArray();

				// Mulai dari baris kedua (indeks 1)
				for ($i = 1; $i < count($sheetData); $i++) {
					$row = $sheetData[$i];

					if (empty($row[0])) {
						// Lewati baris yang tidak memiliki kode mapel
						continue;
					}

					$data = [
						'kodemapel' => $row[1],
						'namamapel' => $row[2] ?? '',
						'kkm'  => $row[3] ?? '',
						'kodekelas' => $row[4] ?? '',
					];

					$this->db->insert('tb_mapel', $data);
				}

				$this->session->set_flashdata('message', 'Data mapel berhasil di-import');
				redirect('master/mapel');
			} catch (\PhpOffice\PhpSpreadsheet\Reader\Exception $e) {
				// Tangani kesalahan pembacaan file Excel
				$this->session->set_flashdata('error', 'Terjadi kesalahan dalam membaca file Excel.');
				redirect('master/mapel');
			} catch (\Exception $e) {
				// Tangani kesalahan lainnya
				$this->session->set_flashdata('error', 'Terjadi kesalahan dalam mengimpor data.');
				redirect('master/mapel');
			}
		} else {
			$this->session->set_flashdata('error', 'Tipe file tidak valid. Harap unggah file Excel yang benar.');
			redirect('master/mapel');
		}
	}



	public function uploadsiswa()
	{
		$file_mimes = ['application/octet-stream', 'application/vnd.ms-excel', 'application/x-csv', 'text/x-csv', 'text/csv', 'application/csv', 'application/excel', 'application/vnd.msexcel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'];

		if (isset($_FILES['berkas_excel']['name']) && in_array($_FILES['berkas_excel']['type'], $file_mimes)) {
			$arr_file = explode('.', $_FILES['berkas_excel']['name']);
			$extension = end($arr_file);

			if ('csv' == $extension) {
				$reader = new \PhpOffice\PhpSpreadsheet\Reader\Csv();
			} else {
				$reader = new \PhpOffice\PhpSpreadsheet\Reader\Xlsx();
			}

			try {
				$spreadsheet = $reader->load($_FILES['berkas_excel']['tmp_name']);
				$sheetData = $spreadsheet->getActiveSheet()->toArray();

				// Mulai dari baris kedua (indeks 1)
				for ($i = 1; $i < count($sheetData); $i++) {
					$row = $sheetData[$i];

					if (empty($row[0])) {
						// Lewati baris yang tidak memiliki NIS
						continue;
					}

					$data = [
						'nis'           => $row[1],
						'namasiswa'     => $row[2] ?? '',
						'nisn'           => $row[3] ?? '',
						'jeniskelamin'  => $row[4] ?? '',
						'tempatlahir'  => $row[5] ?? '',
						'tgllahir'      => $row[6] ?? '',
						'alamatsiswa'   => $row[7] ?? '',
						'notelpseluler'  => $row[8] ?? '',
						'emailsiswa'    => $row[9] ?? '',
						'asalsekolah'    => $row[10] ?? '',
						'tglmasuk'    => $row[11] ?? '',
						'nama_ayah'    => $row[12] ?? '',
						'nama_ibu'    => $row[13] ?? '',
						'kodekelas'     => $row[14] ?? '',
						'semester_aktif' => $row[15] ?? ''
					];
					// data tdk boleh kosong
					// var_dump($data);

					$this->db->insert('tb_siswa', $data);
				}

				$this->session->set_flashdata('message', 'Data siswa berhasil di-import');
				redirect('master/siswa');
			} catch (\PhpOffice\PhpSpreadsheet\Reader\Exception $e) {
				// Tangani kesalahan pembacaan file Excel
				$this->session->set_flashdata('error', 'Terjadi kesalahan dalam membaca file Excel.');
				redirect('master/siswa');
			} catch (\Exception $e) {
				// Tangani kesalahan lainnya
				$this->session->set_flashdata('error', 'Terjadi kesalahan dalam mengimpor data.');
				redirect('master/siswa');
			}
		} else {
			$this->session->set_flashdata('error', 'Tipe file tidak valid. Harap unggah file Excel yang benar.');
			redirect('master/siswa');
		}
	}
}
