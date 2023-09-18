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
                            <input type="hidden" name="kode" id="kode" value="<?= $dtmapel['kodemapel']; ?>">
                            <label for="kodemp">Kode Mapel</label>
                            <input type="text" name="kodemp" id="kodemp" class="form-control" value="<?= $dtmapel['kodemapel']; ?>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="namamp">Nama Mapel</label>
                            <input type="text" name="namamp" id="namamp" class="form-control" value="<?= $dtmapel['namamapel']; ?>">
                            <?= form_error('namamp', '<small class="text-danger">', '</small>'); ?>
                        </div>
                        <div class="form-group">
                            <label for="kls">Kelas</label>
                            <select name="kls" id="kls" class="form-control">
                                <?php foreach ($kelas as $k) : ?>
                                    <option value="<?= $k['kodekelas']; ?>" <?= ($dtmapel['kodekelas'] == $k['kodekelas']) ? 'selected' : ''; ?>><?= $k['namakelas']; ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="kkm">KKM</label>
                            <input type="text" name="kkm" id="kkm" class="form-control" value="<?= $dtmapel['kkm']; ?>">
                            <?= form_error('kkm', '<small class="text-danger">', '</small>'); ?>
                        </div>
                        <div class="form-group">
                            <a href="<?= base_url('master/mapel'); ?>" class="btn btn-secondary">Batal</a>
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
