<!DOCTYPE html>
<html>
<head>
  <title>Laporan Hasil Ujian</title>
  <link href='<?php echo base_url(); ?>___/css/style_print.css' rel='stylesheet' media='' type='text/css'/>
</head>
<body>

<h3>Laporan Hasil Ujian</h3>
<hr style="border: solid 1px #000"><br>

<h4>Detail Ujian</h4>
<table class="table-bordered" style="margin-bottom: 0px">
  <tr><td width="30%">Jenis Soal</td><td><b><?php echo $detil_tes->namaMapel; ?></b></td></tr>
  <tr><td>Departemen</td><td width="70%"><b><?php echo $detil_tes->nama_guru; ?></b></td></tr>
  <tr><td>Nama Ujian</td><td width="70%"><b><?php echo $detil_tes->nama_ujian; ?></b></td></tr>
  <tr><td>Jumlah Soal</td><td><b><?php echo $detil_tes->jumlah_soal; ?></b></td></td></tr>
  <tr><td>Waktu</td><td><b><?php echo $detil_tes->waktu; ?> menit</b></td></tr>
  <!--<tr><td>Tertinggi</td><td><b><?php echo $statistik->max_; ?></b></td></tr>
  <tr><td>Terendah</td><td><b><?php echo $statistik->min_; ?></b></td></tr>
  <tr><td>Rata-rata</td><td><b><?php echo number_format($statistik->avg_); ?></b></td></tr>-->
</table>
<br><br>
<h4>Hasil Ujian</h4>

<table class="table-bordered">
	<?php foreach($hasil as $d) { ?>
	<tr>
		<th colspan="5"><?php echo $d->nama; ?></th>
	</tr>
	<tr>
		<td colspan="5">
		<table>
			<tr>
				<th width="2%">No</th>
			    <th width="15%">Soal</th>
			    <th width="15%">Jawaban</th>
			    <th width="15%">Tanggal & Jam Mulai</th>
			    <th width="15%">Tanggal & Jam Selesai</th>
			</tr>
			<?php 
				//$controller->soal_jawaban($d->id);
				$no = 0;
				
				$c = $controller->soal_jawaban($d->id);
				foreach($c['result'] as $hasil)
				{	
				$no = $no + 1;
			?>
			<tr>
				<td class="ctr"><?php echo $no; ?></td>
                <td class="ctr"><?php echo $hasil->list_soal; ?></td>
                <td class="ctr"><?php echo $hasil->list_jawaban; ?></td>
                <td class="ctr"><?php echo $hasil->tgl_mulai; ?></td>
				<td class="ctr"><?php echo $hasil->tgl_selesai; ?></td>
			</tr>
			<?php } ?>
		</table>
		</td>
	</tr>
	<?php } ?>
</table>	
<!--<table class="table-bordered">
  <thead>
    <tr>
      <th width="2%">No</th>
      <th width="20%">Nama Peserta</th>
      <th width="15%">Soal</th>
      <th width="15%">Jawaban</th>
      <th width="15%">Tanggal & Jam Mulai</th>
	  <th width="15%">Tanggal & Jam Selesai</th>
    </tr>
  </thead>

  <tbody>
    <?php 
      if (!empty($hasil)) {
        $no = 1;
        foreach ($hasil as $d) {
          echo '<tr>
                <td class="ctr">'.$no.'</td>
                <td>'.$d->nama.'</td>
                <td class="ctr">'.$d->list_soal.'</td>
                <td class="ctr">'.$d->list_jawaban.'</td>
                <td class="ctr">'.$d->tgl_mulai.'</td>
				<td class="ctr">'.$d->tgl_selesai.'</td>
                </tr>
                ';
        $no++;
        }
      } else {
        echo '<tr><td colspan="5">Belum ada data</td></tr>';
      }
    ?>
  </tbody>
</table>
-->

</body>
</html>
