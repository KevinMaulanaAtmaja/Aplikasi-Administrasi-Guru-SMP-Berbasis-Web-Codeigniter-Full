<?php

class Coba extends FPDF
{

	public function Footer()
	{
		$this->SetY(-40);
		$this->SetLeftMargin(20);
		$this->Ln(1);
		$this->SetLineWidth(1, 5);
		$this->Line(20, 555, 820, 555);
		$this->SetFont('Arial', 'I', 6);
		$this->Cell(400, 10, 'Dicetak pada ' . date('d/m/Y') . ' | &copy;  SMPN 1 Inpres Sukabumi', 0, 0, 'L');
		$this->Cell(400, 10, 'halaman ' . $this->PageNo() . ' dari {nb}', 0, 0, 'R');
	}
}

$pdf = new Coba('L', 'pt', 'A4');
$pdf->SetTitle('Laporan Rekapitulasi Data Ampu');
$pdf->AliasNbPages();
$pdf->SetTopMargin(30);
$pdf->SetLeftMargin(40);
$pdf->SetRightMargin(40);
$pdf->SetAutoPageBreak(true, 50);

$pdf->AddPage();
$pdf->Image('./assets/img/logo.png', 210, 21, 50);
$pdf->SetFont('helvetica', 'B', 16);
$pdf->Cell(70);
$pdf->Cell(650, 10, 'SEKOLAH MENENGAH KEJURUAN', 0, 0, 'C');
$pdf->Ln(14);
$pdf->SetFont('helvetica', '', 14);
$pdf->Cell(70);
$pdf->Cell(650, 10, 'S M K  P A S I M  P L U S  S U K A B U M I', 0, 0, 'C');
$pdf->Ln(14);
$pdf->Cell(70);
$pdf->SetFont('helvetica', 'I', 9);
$pdf->Cell(650, 10, 'Graha Pasim Jalan Prana No. 8A Cikole Kota Sukabumi Telp. (0266) 241000', 0, 0, 'C');
$pdf->SetLineWidth(1);
$pdf->Line(20, 72, 820, 72);
$pdf->SetLineWidth(1, 5);
$pdf->Line(20, 74, 820, 74);

$pdf->SetY(110);
$pdf->SetFont('helvetica', 'BU', 13);
$pdf->Cell(0, 10, $title, 0, 0, 'C');
$pdf->Ln(25);

$pdf->Ln();
$nilaiY = $pdf->GetY();
$pdf->SetX(40);
$pdf->SetFont('helvetica', '', 10);
$pdf->Cell(32, 10, 'Kelas', 0, 0, "C");
$pdf->Cell(45, 10, ':', 0, 0, "C");
$pdf->Cell(10, 10, $kelas, 0, 0, "C");
$pdf->Ln();
$nilaiY = $pdf->GetY();

$pdf->SetX(40);
$pdf->Cell(50, 25, 'Semester', 0, 0, "C");
$pdf->Cell(10, 25, ':', 0, 0, "C");
$pdf->Cell(40, 25, $semester, 0, 0, "C");
$pdf->Ln();
$nilaiY = $pdf->GetY();

$pdf->SetFont('helvetica', 'B', 10);
$pdf->SetLineWidth(1, 5);
$pdf->SetFillColor(0, 191, 255);
$pdf->Cell(20, 15, "No", 1, 0, "C", true);
$pdf->Cell(40, 15, "ID Guru", 1, 0, "C", true);
$pdf->Cell(150, 15, "Nama Guru", 1, 0, "C", true);
$pdf->Cell(200, 15, "Mapel", 1, 0, "C", true); // Hapus kolom mapel
$pdf->Cell(150, 15, "Kelas", 1, 0, "C", true);
$pdf->Cell(100, 15, "Tahun Ajar", 1, 0, "C", true); // Hapus kolom mapel
if (!empty($ampu)) {
	$pdf->SetLeftMargin(40);
	$pdf->Ln();
	$no = 0;
	$curY = $pdf->GetY();
	$curN = 0;
	$akhir = 0;
	foreach ($ampu as $key) {

		$no++;
		$yAwal = $pdf->GetY();
		$xAwal = $pdf->GetX();
		$pdf->SetFont('helvetica', '', 8);
		$pdf->SetXY($pdf->GetX(), $curY);
		$pdf->Cell(20, 15, $no . ".", 'LRT', 0, "C");
		$pdf->SetXY($pdf->GetX(), $curY);
		$pdf->MultiCell(40, 15, $key->kodeguru, 'LRT', 'C');
		$pdf->SetXY($pdf->GetX() + 60, $curY);
		$pdf->MultiCell(150, 15, $key->namaguru, 'LRT', 'L');
		$pdf->SetXY($pdf->GetX() + 210, $curY);
		$pdf->MultiCell(200, 15, $key->namamapel, 'LRT', 'L');
		$curA = $pdf->GetY();
		$pdf->SetXY($pdf->GetX() + 410, $curY);
		$pdf->MultiCell(150, 15, $key->namakelas, 'lRT', "L");
		$curJ = $pdf->GetY();
		$pdf->SetXY($pdf->GetX() + 560, $curY);
		$pdf->MultiCell(100, 15, $key->periode_mengajar, 'LRT', "L");
		$curS = $pdf->GetY();
		// $pdf->SetXY($pdf->GetX() + 660, $curY);
		// $pdf->MultiCell(100, 15, $key->periode_mengajar, 'LRT', "C");
		if (($curA >= $curJ) && ($curA >= $curS)) {
			$curN = $curA;
		} else if (($curJ >= $curA) && ($curJ >= $curS)) {
			$curN = $curJ;
		} else if (($curS >= $curA) && ($curS >= $curJ)) {
			$curN = $curS;
		} else {
			$curN = $curA;
		}
		$pdf->SetLeftMargin(40);
		$pdf->SetLineWidth(1);
		$pdf->Line($xAwal, $yAwal, $xAwal, $curN);
		$pdf->Line($xAwal + 20, $yAwal, $xAwal + 20, $curN);
		$pdf->Line($xAwal + 60, $yAwal, $xAwal + 60, $curN);
		$pdf->Line($xAwal + 210, $yAwal, $xAwal + 210, $curN);
		$pdf->Line($xAwal + 410, $yAwal, $xAwal + 410, $curN);
		$pdf->Line($xAwal + 560, $yAwal, $xAwal + 560, $curN);
		$pdf->Line($xAwal + 660, $yAwal, $xAwal + 660, $curN);
		// $pdf->Line($xAwal + 760, $yAwal, $xAwal + 760, $curN);
		$pdf->Line($xAwal, $curN, $xAwal + 760, $curN);
		if ($curN >= 500) {
			$pdf->AddPage();
			$pdf->SetLeftMargin(40);
			$pdf->SetRightMargin(40);
			$curY = 40;
			$yAwal = 40;
		} else {
			$curY = $curN;
		}
		$pdf->Ln();
	}
} else {
	$pdf->Ln();
	$pdf->MultiCell(760, 20, "Maaf Data Masih Kosong !", 1, 'C');
}

$pdf->Output('Rekapitulasi-Data-Ampu-' . date('dFY') . '.pdf', 'I');

function createPDF($paperSize)
{
	// Periksa nilai ukuran kertas yang dipilih dan buat objek FPDF sesuai
	if ($paperSize === 'A4') {
		$pdf = new Coba('L', 'pt', 'A4');
	} elseif ($paperSize === 'Letter') {
		$pdf = new Coba('L', 'pt', 'Letter');
	} else {
		// Ukuran kertas kustom
		$customSize = array(216, 279); // Ganti dengan ukuran kertas yang diinginkan
		$pdf = new Coba('L', 'pt', $customSize);
	}

	// Sisipkan kode pembuatan PDF Anda di sini
	// ...

	// Outputkan PDF
	$pdf->Output('Rekapitulasi-Data-Ampu-' . date('dFY') . '.pdf', 'I');
}

// Ambil nilai ukuran kertas yang dipilih dari parameter URL atau atur ukuran default
$selectedPaperSize = isset($_GET['paper_size']) ? $_GET['paper_size'] : 'A4';

// Panggil fungsi untuk membuat PDF dengan ukuran yang dipilih
createPDF($selectedPaperSize);
