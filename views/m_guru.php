<div class="row col-md-12 ini_bodi">
  <div class="panel panel-info">
    <div class="panel-heading">Data Departemen
      <div class="tombol-kanan">
        <a class="btn btn-success btn-sm tombol-kanan" href="#" onclick="return m_guru_e(0);"><i class="glyphicon glyphicon-plus"></i> &nbsp;&nbsp;Tambah</a>       
        <a class="btn btn-warning btn-sm tombol-kanan" href="<?php echo base_url(); ?>upload/format_import_guru.xlsx" ><i class="glyphicon glyphicon-download"></i> &nbsp;&nbsp;Download Format Import</a>
        <a class="btn btn-info btn-sm tombol-kanan" href="<?php echo base_url(); ?>adm/m_guru/import" ><i class="glyphicon glyphicon-upload"></i> &nbsp;&nbsp;Import</a>
      </div>
    </div>
    <div class="panel-body">
      <a href="#" onclick="return aktifkan_semua_guru();" class="btn btn-info" style="margin-bottom: 10px"><i class="fa fa-users"></i> Aktifkan semua guru</a>
	  <input type="button" class="btn btn-info" style="margin-bottom: 10px" onclick="tableToExcel('datatabel', 'name', 'excel.xls')" value="Export to Excel">
      <table class="table table-bordered" id="datatabel">
        <thead>
          <tr>
            <th width="5%">No</th>
            <th width="40%">Nama Departemen</th>
            <th width="20%">NIK / Username</th>
            <th width="35%">Aksi</th>
          </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    
      </div>
    </div>
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
<div class="modal fade" id="m_guru" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 id="myModalLabel">Data Departemen</h4>
      </div>
      <div class="modal-body">
          <form name="f_guru" id="f_guru" onsubmit="return m_guru_s();">
            <input type="hidden" name="id" id="id" value="0">
              <table class="table table-form">
                <tr><td style="width: 25%">NIK</td><td style="width: 75%"><input type="text" class="form-control" name="nip" id="nip" required></td></tr>
                <tr><td style="width: 25%">Nama</td><td style="width: 75%"><input type="text" class="form-control" name="nama" id="nama" required></td></tr>
              </table>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary"><i class="fa fa-check"></i> Simpan</button>
        <button class="btn" data-dismiss="modal" aria-hidden="true"><i class="fa fa-minus-circle"></i> Tutup</button>
      </div>
        </form>
    </div>
  </div>
</div>
