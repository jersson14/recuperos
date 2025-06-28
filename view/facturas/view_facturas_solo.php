<?php
session_start();
if (!isset($_SESSION['S_ID'])) {
  header('Location: ../index.php');
}
?>
<script src="../js/console_facturas_solo.js?rev=<?php echo time(); ?>"></script>
<link rel="stylesheet" href="../plantilla/plugins/icheck-bootstrap/icheck-bootstrap.min.css">

<!-- Content Header (Page header) -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0"><b>MANTENIMIENTO DE FACTURAS</b></h1>
      </div><!-- /.col -->
      <div class="col-sm-6">
        <ol class="breadcrumb float-sm-right">
          <li class="breadcrumb-item"><a href="../index.php">MENU</a></li>
          <li class="breadcrumb-item active">FACTURAS</li>
        </ol>
      </div><!-- /.col -->
    </div><!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content">
  <div class="container-fluid">
    <div class="row">
      <!-- /.col-md-6 -->
      <div class="col-lg-12">
        <div class="card">
          <div class="card-header">
            <h3 class="card-title"><i class="nav-icon fas fa-th"></i>&nbsp;&nbsp;<b>Listado de Facturas</b></h3>

          </div>
          <div class="table-responsive" style="text-align:left">
            <div class="card-body">
              <div class="row" style="border: 1px solid #ccc; padding: 15px; border-radius: 8px;">
                <div class="col-6 form-group">
                  <label for="">Obras Sociales:</label>
                  <select class="js-example-basic-single" id="select_obras_buscar" style="width:100%">
                  </select>
                </div>
                <div class="col-2 form-group">
                  <label for="">Estado de Factura:</label>
                  <select class="form-control" id="select_estado" style="width:100%">
                    <option value="">Seleccione</option>
                    <option value="FACTURADA">FACTURADA</option>
                    <option value="COBRADA">COBRADA</option>
                    <option value="RECHAZADA">RECHAZADA</option>
                    <option value="PENDIENTE">PENDIENTE</option>

                  </select>
                </div>
                <div class="col-12 col-md-2" role="document">
                  <label for="">&nbsp;</label><br>
                  <button onclick="listar_practica_paciente_obras()" class="btn btn-danger mr-2" style="width:100%" onclick><i class="fas fa-search mr-1"></i>Buscar registros</button>
                </div>
                <div class="col-12 col-md-2" role="document">
                  <label for="">&nbsp;</label><br>
                  <button onclick="listar_facturas()" class="btn btn-success mr-2" style="width:100%" onclick><i class="fas fa-search mr-1"></i>Listar todos</button>
                </div>
              </div>
            </div>
          </div>
          <div class="table-responsive" style="text-align:left">
            <div class="card-body">
              <div class="row" style="border: 1px solid #ccc; padding: 15px; border-radius: 8px;">
                <div class="col-3 form-group">
                  <label for="">Fecha desde:</label>
                  <input type="date" class="form-control" id="txt_fecha_desde">
                </div>
                <div class="col-3 form-group">
                  <label for="">Fecha hasta:</label>
                  <input type="date" class="form-control" id="txt_fecha_hasta">

                </div>
                <div class="col-3 form-group">
                  <label for="">Usuario:</label>
                  <select class="js-example-basic-single" id="select_usuario" style="width:100%">
                  </select>
                </div>
                <div class="col-12 col-md-3" role="document">
                  <label for="">&nbsp;</label><br>
                  <button onclick="listar_practica_paciente_fecha_usu()" class="btn btn-danger mr-2" style="width:100%" onclick><i class="fas fa-search mr-1"></i>Buscar registros</button>
                </div>

              </div>
            </div>
          </div>
          <div class="table-responsive" style="text-align:center">
            <div class="card-body">
              <table id="tabla_facturas" class="table table-striped table-bordered" style="width:100%">
                <thead style="background-color:#023D77;color:#FFFFFF;">
                  <tr>
                    <th style="text-align:center">Nro.</th>
                    <th style="text-align:center">Obra Social</th>
                    <th style="text-align:center">Nro. Factura</th>
                    <th style="text-align:center">Monto Total</th>
                    <th style="text-align:center">Saldo Cobrado</th>
                    <th style="text-align:center">Saldo Pendiente</th>
                    <th style="text-align:center">Ver Factura</th>
                    <th style="text-align:center">Ver Nota de crédito</th>
                    <th style="text-align:center">Fecha Nota de crédito</th>
                    <th style="text-align:center">Fecha registro</th>
                    <th style="text-align:center">Estado</th>
                    <th style="text-align:center">Acciones</th>
                  </tr>
                </thead>
              </table>
            </div>
          </div>

        </div>
        <!-- /.col-md-6 -->
      </div>
      <!-- /.row -->
    </div><!-- /.container-fluid -->
  </div>
  <!-- /.content -->

  <!-- Modal -->


  <div class="modal fade" id="modal_editar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content modal-lg">
        <div class="modal-header" style="background-color:#1FA0E0;">
          <div style="display: flex; flex-direction: column;color:white">
            <h5 class="modal-title" id="lb_tituloesta_pagar"></h5>
            <h5 class="modal-title" id="lb_titulo2esta_pagar" style="margin-top: 10px;"></h5> <!-- Espaciado entre títulos -->
          </div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12 form-group" style="color:red">
              <h6><b>Campos Obligatorios para Editar (*)</b></h6>
            </div>
            <div class="col-8 form-group">
              <label>Archivo de Factura <b style="color:red">(*)</b>:</label>
                <input type="text" id="txt_idfactura" hidden>

              <div class="custom-file position-relative">
                <input type="text" id="facturaactual" hidden>

                <input type="file" class="custom-file-input" id="txt_factura_editar" accept="image/*,application/pdf" onchange="updateFileLabelEditar(event)">
                <label class="custom-file-label" id="label_txt_factura_editar" for="txt_factura_editar">Seleccione Factura...</label>
                <button type="button" class="btn btn-danger btn-sm btn-clear-file" id="btn_clear_factura_editar" onclick="clearFacturaeditar()">X</button>
              </div>
            </div>

            <div class="col-4 form-group">
              <label>Fecha de actualización<b style="color:red">(*)</b>:</label>
              <input type="date" class="form-control" id="txt_fecha_editar" disabled>
            </div>

            <div class="col-8 form-group">
              <label>Archivo de Nota de Crédito (Opcional):</label>
              <div class="custom-file position-relative">
                <input type="text" id="notaactual" hidden>

                <input type="file" class="custom-file-input" id="txt_notacre_editar" accept="image/*,application/pdf" onchange="updateFileLabel2_editar(event)">

                <label class="custom-file-label" id="label_txt_notacre_editar" for="txt_notacre_editar">Seleccione Nota de crédito...</label>
                <button type="button" class="btn btn-danger btn-sm btn-clear-file" id="btn_clear_notacre_editar" onclick="clearNotacreeditar()">X</button>
              </div>
            </div>
            <div class="col-4 form-group">
              <label>Fecha Nota de Crédito (Opcional):</label>
              <input type="date" class="form-control" id="txt_fecha_nota_editar" disabled>
            </div>

          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
          <button type="button" class="btn btn-success" onclick="Modificar_Practica_paciente()"><i class="fas fa-edit"></i> Actualizar</button>
        </div>
      </div>
    </div>
  </div>



  <script>
    $(document).ready(function() {
      // Cargar datos iniciales
      Cargar_Select_Obras_Sociales();
      Cargar_Select_Usuarios();
      Cargar_Select_Areas();
      listar_facturas_diario();
    });
  </script>
 <script>
    function updateFileLabelEditar(event) {
      var input = event.target;
      var label = document.getElementById('label_txt_factura_editar');

      if (input.files && input.files[0]) {
        var fileName = input.files[0].name;
        label.innerHTML = "Subir Factura (" + fileName + ")";
      }
    }

    function clearFacturaeditar() {
      var fileInput = document.getElementById('txt_factura_editar');
      var fileLabel = document.getElementById('label_txt_factura_editar');

      // Limpiar el input de archivo
      fileInput.value = '';

      // Restablecer el texto del label
      fileLabel.innerHTML = "Seleccione Factura...";
    }
  </script>

  <script>
    function updateFileLabel2_editar(event) {
      var input = event.target;
      var label = document.getElementById('label_txt_notacre_editar');

      if (input.files && input.files[0]) {
        var fileName = input.files[0].name;
        label.innerHTML = "Subir Nota de crédito (" + fileName + ")";
      }
    }

    function clearNotacreeditar() {
      var fileInput = document.getElementById('txt_notacre_editar');
      var fileLabel = document.getElementById('label_txt_notacre_editar');

      // Limpiar el input de archivo
      fileInput.value = '';

      // Restablecer el texto del label
      fileLabel.innerHTML = "Seleccione Nota de crédito...";
    }

     //TRAER FECHA ACTUAL
    var n = new Date();
    var y = n.getFullYear();
    var m = n.getMonth() + 1; // Los meses empiezan desde 0, por eso se suma 1
    var d = n.getDate();

    // Si el día o el mes es menor a 10, se le agrega un '0' al inicio
    if (d < 10) {
      d = '0' + d;
    }
    if (m < 10) {
      m = '0' + m;
    }

    // Establece el valor del campo de fecha con el formato YYYY-MM-DD
    document.getElementById('txt_fecha_editar').value = y + "-" + m + "-" + d;
    document.getElementById('txt_fecha_nota_editar').value = y + "-" + m + "-" + d;
  </script>
  <style>
    /* Botón de limpiar archivos */
    .btn-clear-file {
      position: absolute;
      right: 80px;
      top: 50%;
      transform: translateY(-50%);
      z-index: 10;
    }
  </style>