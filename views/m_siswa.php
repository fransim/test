<html>
<head>
	<title>Data Peserta</title>
	<script src="<?php echo base_url(); ?>../../___/js/jspdf.debug.js"></script>
</head>

<div class="row col-md-12 ini_bodi">
  <div class="panel panel-info">
    <div class="panel-heading">Data Peserta
      <div class="tombol-kanan">
        <a class="btn btn-success btn-sm tombol-kanan" href="#" onclick="return m_siswa_e(0);"><i class="glyphicon glyphicon-plus"></i> &nbsp;&nbsp;Tambah</a>        
        <a class="btn btn-warning btn-sm tombol-kanan" href="<?php echo base_url(); ?>upload/format_import_siswa.xlsx" ><i class="glyphicon glyphicon-download"></i> &nbsp;&nbsp;Download Format Import</a>
        <a class="btn btn-info btn-sm tombol-kanan" href="<?php echo base_url(); ?>adm/m_siswa/import" ><i class="glyphicon glyphicon-upload"></i> &nbsp;&nbsp;Import</a>
      </div>
    </div>
    <div class="panel-body">
      <a href="#" onclick="#" class="btn btn-info" style="margin-bottom: 10px"><i class="fa fa-users"></i> Aktifkan semua peserta</a>
	  <input type="button" class="btn btn-info" style="margin-bottom: 10px" onclick="tableToExcel('datatabel', 'name', 'excel.xls')" value="Export to Excel">
		<!--<input type="button" class="btn btn-info" style="margin-bottom: 10px" onclick="javascript:demoFromHTML()" value="Export to PDF">-->
      <table class="table table-bordered" id="datatabel">
        <thead>
          <tr>
            <th width="5%">No</th>
            <th width="25%" class="sort" onclick="sortTable(0)">Nama Peserta</th>
            <th width="15%" class="sort" onclick="sortTable(1)">NIK / Username</th>
            <th width="20%" class="sort" onclick="sortTable(2)">Status</th>
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

function sortTable(n) {
  var table, rows, switching, i, x, y, z, shouldSwitch, dir, switchcount = 0;
  table = document.getElementById("datatabel");
  switching = true;
  //Set the sorting direction to ascending:
  dir = "asc"; 
  /*Make a loop that will continue until
  no switching has been done:*/
  while (switching) {
    //start by saying: no switching is done:
    switching = false;
    rows = table.rows;
    /*Loop through all table rows (except the
    first, which contains table headers):*/
    for (i = 1; i < (rows.length - 1); i++) {
      //start by saying there should be no switching:
      shouldSwitch = false;
      /*Get the two elements you want to compare,
      one from current row and one from the next:*/
      x = rows[i].getElementsByTagName("TD")[n];
      y = rows[i + 1].getElementsByTagName("TD")[n];
      /*check if the two rows should switch place,
      based on the direction, asc or desc:*/
      if (dir == "asc") {
        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
          //if so, mark as a switch and break the loop:
          shouldSwitch= true;
          break;
        }
      } else if (dir == "desc") {
        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
          //if so, mark as a switch and break the loop:
          shouldSwitch = true;
          break;
        }
      }
    }
    if (shouldSwitch) {
      /*If a switch has been marked, make the switch
      and mark that a switch has been done:*/
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
      //Each time a switch is done, increase this count by 1:
      switchcount ++;      
    } else {
      /*If no switching has been done AND the direction is "asc",
      set the direction to "desc" and run the while loop again.*/
      if (switchcount == 0 && dir == "asc") {
        dir = "desc";
        switching = true;
      }
    }
  }
}
</script>

<div class="modal fade" id="m_siswa" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 id="myModalLabel">Data Peserta</h4>    

      </div>
      <div class="modal-body">
          <form name="f_siswa" id="f_siswa" onsubmit="return m_siswa_s();">
            <input type="hidden" name="id" id="id" value="0">
              <table class="table table-form">
                <tr><td style="width: 25%"> <td class="s_namapeserta">Nama</td><td style="width: 75%"><input type="text" class="form-control" name="nama" id="nama" required></td></tr>
                <tr><td style="width: 25%"> <td class="s_nik">NIK</td><td style="width: 75%"><input type="text" class="form-control" name="nim" id="nim" required></td></tr>
                <tr><td style="width: 25%"> <td class="s_status">Status</td><td style="width: 75%"><input type="text" class="form-control" name="jurusan" id="jurusan" placeholder="Karyawan / Tamu" required></td></tr>
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