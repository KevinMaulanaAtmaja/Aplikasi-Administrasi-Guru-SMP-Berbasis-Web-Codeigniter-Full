<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-4 text-gray-800">
        <span><a href="#"><?= $title; ?></a></span>
        <span> / <?= $subtitle; ?></span>
    </h1>

    <div class="row">
        <div class="col-lg">
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Form Edit </h6>
                </div>
                <div class="card-body">
                    <?= form_open('', ['class' => 'form-horizontal']); ?>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group row">
                                <label for="nip" class="col-sm-3 col-form-label">NIP</label>
                                <div class="col-sm-9">
                                    <input type="hidden" name="idnip" id="idnip" value="<?= $dtguru['nip']; ?>">
                                    <input type="text" class="form-control" name="nip" id="nip" value="<?= $dtguru['nip']; ?>" readonly>
                                    <?= form_error('nip', '<small class="text-danger">', '</small>'); ?>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="namaguru" class="col-sm-3 col-form-label">Nama Guru</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="namaguru" id="namaguru" value="<?= $dtguru['namaguru']; ?>">
                                    <?= form_error('namaguru', '<small class="text-danger">', '</small>'); ?>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="kode" class="col-sm-3 col-form-label">Kode Guru</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="kode" id="kode" value="<?= $dtguru['kodeguru']; ?>">
                                    <?= form_error('kode', '<small class="text-danger">', '</small>'); ?>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="jenkel" class="col-sm-3 col-form-label">Jenis Kelamin</label>
                                <div class="col-sm-9">
                                    <select name="jenkel" id="jenkel" class="form-control">
                                        <option value="Laki-laki" <?= ($dtguru['jeniskelamin'] == 'Laki-laki') ? 'selected' : ''; ?>>Laki-laki</option>
                                        <option value="Perempuan" <?= ($dtguru['jeniskelamin'] == 'Perempuan') ? 'selected' : ''; ?>>Perempuan</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="alamatguru" class="col-sm-3 col-form-label">Alamat</label>
                                <div class="col-sm-9">
                                    <textarea name="alamatguru" id="alamatguru" cols="30" rows="5" class="form-control"><?= $dtguru['alamatguru']; ?></textarea>
                                    <?= form_error('alamatguru', '<small class="text-danger">', '</small>'); ?>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group row">
                                <label for="tempat" class="col-sm-3 col-form-label">Tempat Lahir</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="tempat" id="tempat" value="<?= $dtguru['tempatlahir']; ?>">
                                    <?= form_error('tempat', '<small class="text-danger">', '</small>'); ?>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="tgl" class="col-sm-3 col-form-label">Tanggal Lahir</label>
                                <div class="col-sm-9">
                                    <input type="date" class="form-control" name="tgl" id="tgl" value="<?= $dtguru['tgllahir']; ?>">
                                    <?= form_error('tgl', '<small class="text-danger">', '</small>'); ?>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="notelp" class="col-sm-3 col-form-label">No. Telp Seluler</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="notelp" id="notelp" value="<?= $dtguru['notelpseluler']; ?>">
                                    <?= form_error('notelp', '<small class="text-danger">', '</small>'); ?>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="emailguru" class="col-sm-3 col-form-label">Email</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="emailguru" id="emailguru" value="<?= $dtguru['emailguru']; ?>">
                                    <?= form_error('emailguru', '<small class="text-danger">', '</small>'); ?>
                                </div>
                            </div>
							<div class="form-group row">
                                <label for="kodekelas" class="col-sm-3 col-form-label">Kode Kelas</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="kodekelas" id="kodekelas" value="<?= $dtguru['kodekelas']; ?>">
                                    <?= form_error('kodekelas', '<small class="text-danger">', '</small>'); ?>
                                </div>
                            </div>
                            
                            <div class="form-group row">
                                <label for="" class="col-sm-3 col-form-label">Status</label>
                                <div class="col-sm-9">
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" value="<?= $dtguru['is_active']; ?>" name="is_active" id="is_active" <?= ($dtguru['is_active'] == '1') ? 'checked' : ''; ?>>
                                        <label for="is_active" class="form-check-label">
                                            Aktif?
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a href="<?= base_url('master/guru'); ?>" class="btn btn-secondary">Batal</a>
                    <button type="submit" class="btn btn-primary float-right">Simpan</button>
                    <?= form_close(); ?>
                </div>
            </div>

        </div>
    </div>

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->
