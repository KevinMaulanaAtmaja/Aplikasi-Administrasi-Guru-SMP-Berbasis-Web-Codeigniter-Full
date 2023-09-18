<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-4 text-gray-800">
		<span><a href="#"><?= $title; ?></a></span>
		<span> / <?= $subtitle; ?></span>
	</h1>

	<!-- kalau lolos -->

	<div class="row">
		<div class="col-lg-6">
			<div class="card shadow mb-4">
				<div class="card-body">
					<form action="" method="post">
						<div class="form-group">
							<input type="hidden" name="kode" id="kode" value="<?= $dtkelas['kodekelas']; ?>">
							<label for="kodekls">Kode Kelas</label>
							<input type="text" name="kodekls" id="kodekls" class="form-control" value="<?= $dtkelas['kodekelas']; ?>" readonly>
						</div>
						<div class="form-group">
							<label for="namakls">Nama Kelas</label>
							<input type="text" name="namakls" id="namakls" class="form-control" value="<?= $dtkelas['namakelas']; ?>">
							<?= form_error('namakls', '<small class="text-danger">', '</small>'); ?>
						</div>
						<div class="form-group">
							<label for="kls">Kelas</label>
							<select name="kls" id="kls" class="form-control">
								<option value="7" <?= ($dtkelas['kelas'] == '7') ? 'selected' : ''; ?>>7</option>
								<option value="8" <?= ($dtkelas['kelas'] == '8') ? 'selected' : ''; ?>>8</option>
								<option value="9" <?= ($dtkelas['kelas'] == '9') ? 'selected' : ''; ?>>9</option>
							</select>
						</div>
						<div class="form-group">
							<label for="angkatan">Angkatan Kelas</label>
							<input type="text" name="angkatan" id="angkatan" class="form-control" value="<?= $dtkelas['angkatankelas']; ?>">
							<?= form_error('angkatan', '<small class="text-danger">', '</small>'); ?>
						</div>
						<div class="form-group">
							<label for="">Status</label>
							<div class="form-check">
								<input type="checkbox" class="form-check-input" value="<?= $dtkelas['is_active']; ?>" name="is_active" id="is_active" <?= ($dtkelas['is_active'] == '1') ? 'checked' : ''; ?>>
								<label for="is_active" class="form-check-label">
									Aktif?
								</label>
							</div>
						</div>
						<div class="form-group">
							<a href="<?= base_url('master/kelas'); ?>" class="btn btn-secondary">Batal</a>
							<button type="submit" class="btn btn-info bg-gradient-info float-right">Simpan</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->
