<?php 
$uri4 = $this->uri->segment(4);
?>

<div class="row col-md-12 ini_bodi">
  <div class="panel panel-info">
    <div class="panel-heading"><b>Data Soal</b>
      <div class="tombol-kanan">
        <a class="btn btn-success btn-sm" href="<?php echo base_url(); ?>adm/m_soal/edit/0"><i class="glyphicon glyphicon-plus" style="margin-left: 0px; color: #fff"></i> &nbsp;&nbsp;Tambah Data</a>        
        <a class="btn btn-warning btn-sm tombol-kanan" href="<?php echo base_url(); ?>upload/format_soal_download.xlsx" ><i class="glyphicon glyphicon-download"></i> &nbsp;&nbsp;Download Format Import</a>
        <a class="btn btn-info btn-sm tombol-kanan" href="<?php echo base_url(); ?>adm/m_soal/import" ><i class="glyphicon glyphicon-upload"></i> &nbsp;&nbsp;Import</a>
        <!--<a href='<?php echo base_url(); ?>adm/m_soal/cetak/<?php echo $uri4; ?>' class='btn btn-info btn-sm' target='_blank'><i class='glyphicon glyphicon-print'></i> Cetak</a>-->
      </div>
    </div>
    <div class="panel-body">
        <input type="button" class="btn btn-info" style="margin-bottom: 10px" onclick="tableToExcel('datatabel', 'name', 'excel.xls')" value="Export to Excel">
        <?php echo $this->session->flashdata('k'); ?>
        
        <table class="table table-bordered" id="datatabel">
          <thead>
            <tr>
              <td width="5%">No</td>
              <td width="50%">Soal</td>
              <td width="15%">Tipe Soal / Instansi</td>
              <td width="15%">Analisa</td>
              <td width="15%">Aksi</td>
            </tr>
          </thead>

          <tbody>

          </tbody>
        </table>
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
    </div>
  </div>
</div>
</div>
