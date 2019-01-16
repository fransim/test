<?php 
$uri4 = $this->uri->segment(4);
?>

<div class="row col-md-12 ini_bodi">
  <div class="panel panel-info">
    <div class="panel-heading">Daftar Hasil Tes
     <div class="tombol-kanan">
	 <a href='<?php echo base_url(); ?>adm/hasil_ujian_cetak/<?php echo $uri4; ?>' class='btn btn-info btn-sm' target='_blank'><i class='glyphicon glyphicon-print'></i> Cetak</a>
      </div>
    </div>

<script>	
function tableToExcel(table, name, filename) {
        let uri = 'data:application/vnd.ms-excel;base64,', 
        template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><title></title><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table>{table}</table></body></html>', 
        base64 = function(s) { return window.btoa(decodeURIComponent(encodeURIComponent(s))) },         format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; })}
        
        if (!table.nodeType) table = document.getElementById(table)
        var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}

        var link = document.createElement('a');
        link.download = filename;
        link.href = uri + base64(format(template, ctx));
        link.click();
}
</script>

    <div class="panel-body">
	<input type="button" class="btn btn-info" style="margin-bottom: 10px" onclick="tableToExcel('datatabel', 'name', 'excel.xls')" value="Export to Excel">
      <!--<div class="col-lg-12 alert alert-warning" style="margin-bottom: 20px">
        <div class="col-md-6">
            <table class="table table-bordered" style="margin-bottom: 0px">
              <tr><td>Jenis Soal</td><td><?php echo $detil_tes->namaMapel; ?></td></tr>
              <tr><td>Departemen</td><td><?php echo $detil_tes->nama_guru; ?></td></tr>
              <tr><td width="30%">Nama Ujian</td><td width="70%"><?php echo $detil_tes->nama_ujian; ?></td></tr>
              <tr><td>Waktu</td><td><?php echo $detil_tes->waktu; ?> menit</td></tr>
            </table>
        </div>-->
        <!--<div class="col-md-2"></div>-->
      </div>


      <table class="table table-bordered" id="datatabel">
	  <caption> 
	  <h4>Jenis Soal : <?php echo $detil_tes->namaMapel; ?>
	  <br>Departemen : <?php echo $detil_tes->nama_guru; ?>
	  <br>Nama Ujian : <?php echo $detil_tes->nama_ujian; ?>
	  <br>Waktu : <?php echo $detil_tes->waktu; ?> </h4>
	  </caption>
        <thead>
          <tr>
            <th width="5%">No</th>
            <th width="100%">Nama Peserta</th>
            <th width="15%">Jumlah Benar</th>
            <th width="15%">Nilai</th>
            <th width="15%">Nilai Bobot</th>
            <th width="10%">Aksi</th>
          </tr>
        </thead>

        <tbody>
        </tbody>
      </table>
    
      </div>
    </div>
  </div>
  
	<div id="hasilujian" class="collapse in">
		<table class="table-bordered">
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
	</div>

<script>
	$(document).ready(function(){
		var table = $('#datatabel').DataTable({
			"ajax": "array.json",
			"colomns": [
			{
				"className": 'details-control',
				"orderable": false,
				"data": null,
				"defaultContent": ''
			},
			{"data": "name"},
			{"data": "position"},
			{"data": "office"},
			{"data": "salary"}
			],
			"order": ([1, 'asc'])
		});
		
		// Add event listener for opening and closing details-control
		$('#example tbody').on('click', 'td.details-control', function (){
			var tr = $(this).closest('tr');
			var row = table.row(tr);
			
			if ( row.child.isShown() ) {
				// This row is already open - close it
				row.child.hide();
				tr.removeClass('shown');
			}
			else{
				// Open his row
				row.child(format(row.data()) ).show();
				tr.addClass('shown');
			}
		});
	});
</script>

