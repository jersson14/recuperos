<script src="../js/console_obras_sociales.js?rev=<?php echo time();?>"></script>

<!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0"><b>MANTENIMIENTO DE OBRAS SOCIALES</b></h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="../index.php">MENU</a></li>
              <li class="breadcrumb-item active">OBRAS SOCIALES</li>
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
                <h3 class="card-title"><i class="nav-icon fas fa-th"></i>&nbsp;&nbsp;<b>Listado de Obras Sociales</b></h3>
                <button class="btn btn-success float-right" onclick="AbrirRegistro()"><i class="fas fa-plus"></i> Nuevo Registro</button>
              </div>
              <div class="table-responsive" style="text-align:center">
              <div class="card-body">
              <table id="tabla_obras_sociales" class="table table-striped table-bordered" style="width:100%">
                  <thead style="background-color:#023D77;color:#FFFFFF;">
                      <tr>
                          <th style="text-align:center">Nro.</th>
                          <th style="text-align:center">CUIT</th>
                          <th style="text-align:center">Nombre</th>
                          <th style="text-align:center">Domicilio</th>
                          <th style="text-align:center">Localidad</th>
                          <th style="text-align:center">Email</th>
                          <th style="text-align:center">Fecha de creación</th>
                          <th style="text-align:center">Estado</th>
                          <th style="text-align:center">Acción</th>
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
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color:#1FA0E0;">
        <h5 class="modal-title" id="exampleModalLabel" style="color:white; text-align:center"><b>REGISTRO DE OBRA SOCIAL</b></h5>
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
            <label for="">Número de CUIT<b style="color:red">(*)</b>:</label>
            <input type="text" autocomplete="on" class="form-control" id="txt_cuit" onkeypress="return soloNumeros(event)" placeholder="Ingrese el N° CUIT">
          </div>
          <div class="col-12 form-group">
            <label for="">Nombre de Obra Social<b style="color:red">(*)</b>:</label>
            <input type="text" autocomplete="on" class="form-control" id="tct_nombre" onkeypress="return sololetras(event)" placeholder="Ingrese el nombre">
          </div>
          <div class="col-12 form-group">
            <label for="">Domicilio<b style="color:red">(*)</b>:</label>
            <textarea name="" id="txt_domicilio" rows="3" class="form-control" style="resize:none;" placeholder="Ingrese el domicilio"></textarea>
          </div>
          <div class="col-12 form-group">
            <label for="">Localidad<b style="color:red">(*)</b>:</label>
            <input type="text" autocomplete="on" class="form-control" id="tct_localidad" placeholder="Ingrese la localidad">
          </div>
          <div class="col-12 form-group">
            <label for="">Email<b style="color:red">(*)</b>:</label>
            <input type="email" autocomplete="on" class="form-control" id="tct_email" placeholder="Ingrese el email">
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
        <button type="button" class="btn btn-success" onclick="Registrar_Obra_Social()"><i class="fas fa-save"></i> Registrar</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="modal_editar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color:#1FA0E0;">
        <h5 class="modal-title" id="exampleModalLabel" style="color:white; text-align:center"><b>MODIFICAR DE OBRA SOCIAL</b></h5>
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
            <label for="">Número de CUIT<b style="color:red">(*)</b>:</label>
            <input type="text" id="id_obra_social" hidden>
            <input type="text" autocomplete="on" class="form-control" id="txt_cuit_editar" onkeypress="return soloNumeros(event)">
          </div>
          <div class="col-12 form-group">
            <label for="">Nombre de Obra Social<b style="color:red">(*)</b>:</label>
            <input type="text" autocomplete="on" class="form-control" id="tct_nombre_editar" onkeypress="return sololetras(event)">
          </div>
          <div class="col-12 form-group">
            <label for="">Domicilio<b style="color:red">(*)</b>:</label>
            <textarea name="" id="txt_domicilio_editar" rows="3" class="form-control" style="resize:none;"></textarea>
          </div>
          <div class="col-12 form-group">
            <label for="">Localidad<b style="color:red">(*)</b>:</label>
            <input type="text" autocomplete="on" class="form-control" id="tct_localidad_editar" >
          </div>
          <div class="col-12 form-group">
            <label for="">Email<b style="color:red">(*)</b>:</label>
            <input type="email" autocomplete="on" class="form-control" id="tct_email_editar">
          </div>
          <div class="col-12 form-group">
            <label for="">Estado<b style="color:red">(*)</b>:</label>
              <select name="" id="txt_estatus" class="form-control">
                <option value="ACTIVO">ACTIVO</option>
                <option value="INACTIVO">INACTIVO</option>
              </select>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
        <button type="button" class="btn btn-success" onclick="Modificar_Obra_Social()"><i class="fas fa-edit"></i> Modificar</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="modal_mostrar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color:#1FA0E0;">
        <h5 class="modal-title" id="exampleModalLabel" style="color:white; text-align:center"><b>DATOS DE OBRA SOCIAL</b></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">

          <div class="col-12 form-group">
            <label for="">Número de CUIT:</label>
            <input type="text" autocomplete="on" class="form-control" id="txt_cuit_mostrar" onkeypress="return soloNumeros(event)" readonly>
          </div>
          <div class="col-12 form-group">
            <label for="">Nombre de Obra Social:</label>
            <input type="text" autocomplete="on" class="form-control" id="tct_nombre_mostrar" onkeypress="return sololetras(event)" readonly>
          </div>
          <div class="col-12 form-group">
            <label for="">Domicilio:</label>
            <textarea name="" id="txt_domicilio_mostrar" rows="2" class="form-control" style="resize:none;" readonly></textarea>
          </div>
          <div class="col-12 form-group">
            <label for="">Localidad:</label>
            <input type="text" autocomplete="on" class="form-control" id="tct_localidad_mostrar" readonly>
          </div>
          <div class="col-12 form-group">
            <label for="">Email:</label>
            <input type="email" autocomplete="on" class="form-control" id="tct_email_mostrar" readonly>
          </div>
          <div class="col-12 form-group">
            <label for="">Fecha de ultima actualización:</label>
            <input type="text" autocomplete="on" class="form-control" id="tct_update_mostrar" readonly>
          </div>
          <div class="col-12 form-group">
            <label for="">Ultimo usuario que actualizo:</label>
            <input type="text" autocomplete="on" class="form-control" id="txt_user_mostrar" readonly>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
      </div>
    </div>
  </div>
</div>


    <script>
    $(document).ready(function () {
      listar_obras_sociales();
      
    });
    $('#modal_registro').on('shown.bs.modal', function () {
      $('#txt_area').trigger('focus')
    })
    </script>