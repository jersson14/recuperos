<?php
session_start();
if (!isset($_SESSION['S_ID'])) {
  header('Location: ../index.php');
}
?>
<script src="../js/console_practicas_paciente_medico.js?rev=<?php echo time(); ?>"></script>
<link rel="stylesheet" href="../plantilla/plugins/icheck-bootstrap/icheck-bootstrap.min.css">

<!-- Content Header (Page header) -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0"><b>MANTENIMIENTO DE PRÁCTICAS - PACIENTE</b></h1>
      </div><!-- /.col -->
      <div class="col-sm-6">
        <ol class="breadcrumb float-sm-right">
          <li class="breadcrumb-item"><a href="../index.php">MENU</a></li>
          <li class="breadcrumb-item active">PRÁCTICAS - PACIENTE</li>
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
            <h3 class="card-title"><i class="nav-icon fas fa-th"></i>&nbsp;&nbsp;<b>Listado de Prácticas - Paciente</b></h3>
            <button class="btn btn-success float-right" onclick="AbrirRegistro()"><i class="fas fa-plus"></i> Nuevo Registro</button>

          </div>
          <div class="table-responsive" style="text-align:left">
            <div class="card-body">
              <div class="row" style="border: 1px solid #ccc; padding: 15px; border-radius: 8px;">
                <div class="col-6 form-group">
                  <label for="">Obras Sociales:</label>
                  <select class="js-example-basic-single" id="select_obras_buscar" style="width:100%">
                  </select>
                </div>
               
                <div class="col-12 col-md-3" role="document">
                  <label for="">&nbsp;</label><br>
                  <button onclick="listar_practica_paciente_obras()" class="btn btn-danger mr-2" style="width:100%" onclick><i class="fas fa-search mr-1"></i>Buscar registros</button>
                </div>
                <div class="col-12 col-md-3" role="document">
                  <label for="">&nbsp;</label><br>
                  <button onclick="listar_practica_paciente()" class="btn btn-success mr-2" style="width:100%" onclick><i class="fas fa-search mr-1"></i>Listar todos</button>
                </div>
              </div>
            </div>
          </div>
          <div class="table-responsive" style="text-align:left">
            <div class="card-body">
              <div class="row" style="border: 1px solid #ccc; padding: 15px; border-radius: 8px;">
                <div class="col-4 form-group">
                  <label for="">Fecha desde:</label>
                  <input type="date" class="form-control" id="txt_fecha_desde">
                </div>
                <div class="col-4 form-group">
                  <label for="">Fecha hasta:</label>
                  <input type="date" class="form-control" id="txt_fecha_hasta">

                </div>

                <div class="col-12 col-md-4" role="document">
                  <label for="">&nbsp;</label><br>
                  <button onclick="listar_practica_paciente_fecha_usu()" class="btn btn-danger mr-2" style="width:100%" onclick><i class="fas fa-search mr-1"></i>Buscar registros</button>
                </div>

              </div>
            </div>
          </div>
          <div class="table-responsive" style="text-align:center">
            <div class="card-body">
              <table id="tabla_paciente_practica" class="table table-striped table-bordered" style="width:100%">
                <thead style="background-color:#023D77;color:#FFFFFF;">
                  <tr>
                    <th style="text-align:center">Nro.</th>
                    <th style="text-align:center">Obra Social</th>
                    <th style="text-align:center">DNI</th>
                    <th style="text-align:center">Paciente</th>
                    <th style="text-align:center">Total</th>
                    <th style="text-align:center">Fecha registro</th>
                    <th style="text-align:center">Fecha actualización</th>
                    <th style="text-align:center">Usuario que registro</th>
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
  <div class="modal fade" id="modal_registro" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header" style="background-color:#1FA0E0;">
          <h5 class="modal-title" id="exampleModalLabel" style="color:white; text-align:center"><b>REGISTRO DE PRÁCTICAS - PACIENTE</b></h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">

          <div class="row">
            <div class="col-12 form-group" style="color:red">
              <h6><b>Campos Obligatorios (*)</b></h6>
            </div>
            <div class="col-12 form-group">
                  <label for="">Obra Social<b style="color:red">(*)</b>:</label>
                  <select class="js-example-basic-single" id="select_obras" style="width:100%">
                  </select>
                </div>
            <div class="col-6 form-group">
              <label for="">Área<b style="color:red">(*)</b>:</label>
              <select class="js-example-basic-single" id="select_area" style="width:100%">
              </select>
            </div>
            <div class="col-6 form-group">
              <label for="">Paciente<b style="color:red">(*)</b>:</label>
              <select class="js-example-basic-single" id="select_paciente" style="width:100%">
              </select>
            </div>
            <div class="col-6 form-group">
              <label for="">Tipo de Práctica<b style="color:red">(*)</b>:</label>
              <select class="js-example-basic-single" id="select_practica" style="width:100%">
              </select>
            </div>
            <div class="col-6 form-group">
              <label for="">Precio de Práctica<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_precio">
            </div>
            <div class="col-6 form-group">
              <label for="">Profesional Responsable<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_profesional" value="<?php echo $_SESSION['S_COMPLETOS']; ?>" disabled>
            </div>
            <div class="col-6 form-group">
              <label for="">Fecha registro<b style="color:red">(*)</b>:</label>
              <input type="date" class="form-control" id="txt_fecha" disabled>
            </div>
            <div class="col-12 form-group">
              <button type="button" class="btn btn-success btn-block" onclick="Agregar_practica()">
                <i class="fas fa-plus"></i> <b>Agregar Práctica</b>
              </button>
            </div>
            <div class="col-12 table-responsive" style="text-align:center">
              <table id="tabla_practica" style="width:100%" class="table">
                <thead class="thead-dark">
                  <tr>
                    <th>Id.</th>
                    <th>Practica</th>
                    <th>Subtotal</th>
                    <th>Acci&oacute;n</th>
                  </tr>
                </thead>
                <tbody id="tbody_tabla_practica">
                </tbody>
              </table>
              <div class="col-9">
              </div>
              <div class="col-3">
                <h3 for="" id="lbl_totalneto" style="display: inline-block;white-space: nowrap;"></h3>
              </div>
            </div>

          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
          <button type="button" class="btn btn-success" onclick="Registrar_Practica()"><i class="fas fa-save"></i> Registrar</button>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="modal_ver_practicas" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
            <div style="display: flex; flex-direction: column;">
            <h5 class="modal-title" id="lb_titulo"></h5>
            <h5 class="modal-title" id="lb_titulo2" style="margin-top: 10px;"></h5> <!-- Espaciado entre títulos -->
        </div>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12" style="text-align:center">
              <div class="table-responsive" style="text-align:center">
                <div class="card-body">
                  <table id="tabla_ver_practicas" class="display compact" style="width:100%; text-align:center;">
                    <thead style="background-color:#0A5D86;color:#FFFFFF;">
                      <tr style="text-align:center;">
                        <th style="text-align:center;">Nro.</th>
                        <th style="text-align:center;">Código</th>
                        <th style="text-align:center;">Práctica</th>
                        <th style="text-align:center;">Subtotal</th>
                      </tr>
                    </thead>
                    <tfoot>
                      <tr>
                        <th colspan="2" style="text-align:right;">Total:</th>
                        <th style="text-align:center;" id="total_sub_total">S/. 0.00</th>
                        <th></th>
                      </tr>
                    </tfoot>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-arrow-right-from-bracket"></i>Cerrar</button>
        </div>
      </div>
    </div>
  </div>



  <div class="modal fade" id="modal_editar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header" style="background-color:#1FA0E0;">
          <h5 class="modal-title" id="exampleModalLabel" style="color:white; text-align:center"><b>MODIFICAR DATOS DE PRÁCTICAS - PACIENTE</b></h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">

          <div class="row">
            <div class="col-12 form-group" style="color:red">
              <h6><b>Campos Obligatorios (*)</b></h6>
            </div>
            <div class="col-12 form-group">
                  <label for="">Obra Social<b style="color:red">(*)</b>:</label>
                  <input type="text" id="txt_id_detalle" hidden>
                  <select class="js-example-basic-single" id="select_obras_editar" style="width:100%" disabled>
                  </select>
                </div>
            <div class="col-6 form-group">
              <label for="">Área<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_area" disabled>
              </select>
            </div>
            <div class="col-6 form-group">
              <label for="">Paciente<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_paciente" disabled>

            </div>
            <div class="col-6 form-group">
              <label for="">Tipo de Práctica<b style="color:red">(*)</b>:</label>
              <select class="js-example-basic-single" id="select_practica_editar" style="width:100%">
              </select>
            </div>
            <div class="col-6 form-group">
              <label for="">Precio de Práctica<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_precio_editar">
            </div>
            <div class="col-6 form-group">
              <label for="">Profesional Responsable<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_profesional_editar" value="<?php echo $_SESSION['S_COMPLETOS']; ?>" disabled>
            </div>
            <div class="col-6 form-group">
              <label for="">Fecha registro<b style="color:red">(*)</b>:</label>
              <input type="datetime" class="form-control" id="txt_fecha_editar" disabled>
            </div>
            <div class="col-12 form-group">
              <button type="button" class="btn btn-success btn-block" onclick="Agregar_practica_editar()">
                <i class="fas fa-plus"></i> <b>Agregar Práctica</b>
              </button>
            </div>
            <div class="col-12 table-responsive" style="text-align:center">
              <table id="tabla_practica_editar" style="width:100%" class="table">
                <thead class="thead-dark">
                  <tr>
                  <th style="text-align:center">Id principal</th>
                    <th style="text-align:center">Id.</th>
                    <th style="text-align:center">Practica</th>
                    <th style="text-align:center">Subtotal</th>
                    <th style="text-align:center">Acci&oacute;n</th>
                  </tr>
                </thead>
                <tbody id="tbody_tabla_practica_editar">
                </tbody>
              </table>
              <div class="col-9">
              </div>
              <div class="col-3">
                <h3 for="" id="lbl_totalneto_editar" style="display: inline-block;white-space: nowrap;"></h3>
              </div>
            </div>

          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
          <button type="button" class="btn btn-success" onclick="Modificar_detalle_practicas()"><i class="fas fa-edit"></i> Modificar</button>
        </div>
      </div>
    </div>
  </div>


  <style>
    .hidden {
      display: none;
    }
  </style>

  <script>
$(document).ready(function () {
  $('.js-example-basic-single').select2({

  });
  Cargar_Select_Obras_Sociales();
  Cargar_Select_Obras_Sociales2();
  Cargar_Select_Usuarios();
  Cargar_Select_Areas();
  listar_practica_paciente_diario();
});

//TRAER DATOS DE PACIENTE


$("#select_obras").change(function(){
var id=$("#select_obras").val();
Cargar_Select_Paciente(id);
});



//TRAER DATOS DE PRACTICA
$("#select_obras").change(function(){
var id=$("#select_obras").val();
Cargar_Select_Practica(id);
});

$("#select_obras_editar").change(function(){
var id=$("#select_obras_editar").val();
Cargar_Select_Practica(id);
});


//TRAER MONTO DE PRACTICA
$("#select_practica").change(function() {
  var id = $("#select_practica").val();
  Traerprecio(id);
});

$("#select_practica_editar").change(function() {
  var id = $("#select_practica_editar").val();
  Traerprecio(id);
});

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
    document.getElementById('txt_fecha').value = y + "-" + m + "-" + d;


  </script>