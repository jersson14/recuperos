<script src="../js/console_practicas.js?rev=<?php echo time(); ?>"></script>

<!-- Content Header (Page header) -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0"><b>MANTENIMIENTO DE PRÁCTICAS</b></h1>
      </div><!-- /.col -->
      <div class="col-sm-6">
        <ol class="breadcrumb float-sm-right">
          <li class="breadcrumb-item"><a href="../index.php">MENU</a></li>
          <li class="breadcrumb-item active">PRÁCTICAS</li>
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
            <h3 class="card-title"><i class="fas fa-users"></i>&nbsp;&nbsp;<b>Listado de Prácticas</b></h3>
            <button class="btn btn-success float-right" onclick="AbrirRegistro()"><i class="fas fa-plus"></i> Nuevo Registro</button>
          </div>
          <div class="table-responsive" style="text-align:left">
            <div class="card-body">
              <div class="row">
                <div class="col-3 form-group">
                  <label for="">Fecha inicio</label><b style="color:red">(*)</b>:</label>
                  <input type="date" class="form-control" id="txtfechainicio">

                </div>
                <div class="col-3 form-group">
                  <label for="">Fecha final<b style="color:red">(*)</b>:</label>
                  <input type="date" class="form-control" id="txtfechafin">

                </div>
                <div class="col-12 col-md-3" role="document">
                  <label for="">&nbsp;</label><br>
                  <button onclick="listar_practicas_filtro()" class="btn btn-danger mr-2" style="width:100%" onclick><i class="fas fa-search mr-1"></i>Buscar prácticas</button>
                </div>
                <div class="col-12 col-md-3" role="document">
                  <label for="">&nbsp;</label><br>
                  <button onclick="listar_practicas()" class="btn btn-success mr-2" style="width:100%" onclick><i class="fas fa-search mr-1"></i>Listar todo</button>
                </div>
              </div>
            </div>
          </div>
          <div class="table-responsive" style="text-align:center">
            <div class="card-body">
              <table id="tabla_practicas" class="table table-striped table-bordered" style="width:100%">
                <thead style="background-color:#023D77;color:#FFFFFF;">
                  <tr>
                    <th style="text-align:center">Nro.</th>
                    <th style="text-align:center">Código</th>
                    <th style="text-align:center">Práctica</th>
                    <th style="text-align:center">Fecha de Registro</th>
                    <th style="text-align:center">Fecha de Actualización</th>
                    <th style="text-align:center">Usuario que Actualizo</th>
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
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header" style="background-color:#1FA0E0;">
          <h5 class="modal-title" id="exampleModalLabel" style="color:white; text-align:center"><b>REGISTRO DE PRÁCTICA</b></h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12 form-group" style="color:red">
              <h6><b>Campos Obligatorios (*)</b></h6>
            </div><br>
            <div class="col-6 form-group">
              <label for="">Código<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_code" placeholder="Ingrese el código de la práctica">
            </div>
            <div class="col-6 form-group">
              <label for="">Práctica<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_practica" placeholder="Ingrese el nombre">
            </div>
            <div class="col-4 form-group">
              <label for="">Valor monetario<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_valor" placeholder="Ingrese el valor monetario" onkeypress="return soloNumeros(event)">
            </div>
            <div class="col-8 form-group">
              <label for="">Obra Social<b style="color:red">(*)</b>:</label>
              <select type="text" class="js-example-basic-single" id="txt_obras_sociales" style="width:100%"></select>

              <!-- Checkbox estilizado -->
              <div class="custom-checkbox-container">
                <div class="form-check custom-checkbox">
                  <input class="form-check-input custom-check" type="checkbox" id="chk_todas_obras_sociales" onclick="toggleObrasSociales()">
                  <label class="form-check-label custom-label" for="chk_todas_obras_sociales">
                    <i class="fas fa-check-circle text-success" style="margin-right: 5px;"></i>
                    Todas las Obras Sociales
                  </label>
                </div>
              </div>
            </div>
            <div class="col-12 form-group">
              <button type="button" class="btn btn-success btn-block" onclick="Agregar_practica_obra()">
                <i class="fas fa-plus"></i> <b>Agregar Práctica - Obra social</b>
              </button>
            </div>

            <!-- Tabla con marco -->
            <div class="col-12 table-responsive" style="text-align:center">
              <table id="tabla_practica_obra" style="width:100%" class="table">
                <thead class="thead-dark">
                  <tr>
                    <th>Codigo</th>
                    <th>Practica</th>
                    <th>Valor</th>
                    <th>Id</th>
                    <th>Obra Social</th>
                    <th>Acci&oacute;n</th>
                  </tr>
                </thead>
                <tbody id="tbody_tabla_practica_obra">
                </tbody>
              </table>
              <div class="col-9">
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
          <button type="button" class="btn btn-success" onclick="Registrar_Practicas()"><i class="fas fa-save"></i> Registrar</button>
        </div>
      </div>
    </div>
  </div>



  <div class="modal fade" id="modal_editar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header" style="background-color:#1FA0E0;">
          <h5 class="modal-title" id="exampleModalLabel" style="color:white; text-align:center"><b>MODIFICAR DATOS DE PRÁCTICA</b></h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12 form-group" style="color:red">
              <h6><b>Campos Obligatorios (*)</b></h6>
            </div><br>

            <!-- NUEVO: Indicador de Total de Obras Sociales -->
            <div class="col-12 form-group">
              <div class="alert alert-info" role="alert" style="background-color: #e3f2fd; border-color: #1FA0E0; color: #0d47a1;">
                <div class="d-flex align-items-center">
                  <i class="fas fa-info-circle" style="margin-right: 10px; font-size: 18px;"></i>
                  <div>
                    <strong>Obras Sociales Asociadas: </strong>
                    <span id="total_obras_display" style="font-size: 16px; font-weight: bold; color: #1FA0E0;">0</span>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-6 form-group">
              <input type="text" id="txt_id_practica" hidden>
              <label for="">Código<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_code_editar" placeholder="Ingrese el código de la práctica">
            </div>
            <div class="col-6 form-group">
              <label for="">Práctica<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_practica_editar" placeholder="Ingrese el nombre">
            </div>
            <div class="col-4 form-group">
              <label for="">Valor monetario<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_valor_editar" placeholder="Ingrese el valor monetario" onkeypress="return soloNumeros(event)">
            </div>
            <div class="col-8 form-group">
              <label for="">Obra Social<b style="color:red">(*)</b>:</label>
              <select type="text" class="js-example-basic-single" id="txt_obras_sociales_editar" style="width:100%"></select>

              <!-- Checkbox estilizado -->
              <div class="custom-checkbox-container">
                <div class="form-check custom-checkbox">
                  <input class="form-check-input custom-check" type="checkbox" id="chk_todas_obras_sociales_editar" onclick="toggleObrasSocialesEditar()">
                  <label class="form-check-label custom-label" for="chk_todas_obras_sociales_editar">
                    <i class="fas fa-check-circle text-success" style="margin-right: 5px;"></i>
                    Todas las Obras Sociales
                  </label>
                </div>
              </div>
            </div>
            <div class="col-12 form-group">
              <button type="button" class="btn btn-success btn-block" onclick="Agregar_practica_obraEditar()">
                <i class="fas fa-plus"></i> <b>Agregar Práctica - Obra social</b>
              </button>
            </div>

            <!-- Tabla con marco -->
            <div class="col-12 table-responsive" style="text-align:center">
              <table id="tabla_practica_obra_editar" style="width:100%" class="table">
                <thead class="thead-dark">
                  <tr>
                    <th>Codigo</th>
                    <th>Practica</th>
                    <th>Valor</th>
                    <th>Id</th>
                    <th>Obra Social</th>
                    <th>Acci&oacute;n</th>
                  </tr>
                </thead>
                <tbody id="tbody_tabla_practica_obra_editar">
                </tbody>
              </table>
              <div class="col-9">
              </div>
            </div>
            <div class="col-12 form-group">
              <br>
              <label for="">Rol<b style="color:red">(*)</b>:</label>
              <select class="form-control" id="txt_estatus" style="width:100%">
                <option value="">Seleccione</option>
                <option value="ACTIVO">ACTIVO</option>
                <option value="INACTIVO">INACTIVO</option>
              </select>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
          <button type="button" class="btn btn-success" onclick="Modificar_Practicas()"><i class="fas fa-edit"></i> Modificar</button>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="modal_practicas_obras" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="lb_titulo"></h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">

          <!-- Sección de Modificación Masiva -->
          <div class="card mb-4" style="border-left: 4px solid #0A5D86;">
            <div class="card-header" style="background: linear-gradient(135deg, #0A5D86 0%, #1e7ba8 100%); color: white;">
              <h6 class="mb-0">
                <i class="fas fa-edit mr-2"></i>
                Modificación Masiva
              </h6>
            </div>
            <div class="card-body" style="background-color: #f8f9fc;">
              <div class="row align-items-end">

                <!-- Input Código -->
                <div class="col-md-3">
                  <label for="bulk_codigo" class="form-label fw-bold text-muted">
                    <i class="fas fa-barcode mr-1"></i>
                    <input type="text" id="txt_id_practica2" hidden>
                    Código
                  </label>
                  <input type="text" class="form-control shadow-sm" id="bulk_codigo" placeholder="Nuevo código...">
                </div>

                <!-- Input Práctica -->
                <div class="col-md-3">
                  <label for="bulk_practica" class="form-label fw-bold text-muted">
                    <i class="fas fa-stethoscope mr-1"></i>
                    Práctica
                  </label>
                  <input type="text" class="form-control shadow-sm" id="bulk_practica" placeholder="Nueva práctica...">
                </div>

                <!-- Input Valor -->
                <div class="col-md-3">
                  <label for="bulk_valor" class="form-label fw-bold text-muted">
                    <i class="fas fa-dollar-sign mr-1"></i>
                    Valor ($AR)
                  </label>
                  <div class="input-group shadow-sm">
                    <span class="input-group-text" style="background-color: #e3f2fd; border-color: #90caf9;">$AR</span>
                    <input type="number" class="form-control" id="bulk_valor" placeholder="0.00" step="0.01" min="0">
                  </div>
                </div>

                <!-- Botón Modificar Todo -->
                <div class="col-md-3">
                  <button onclick="Modificacion_masiva()" class="btn btn-primary btn-lg w-100 shadow" id="btn_modificar_todo"
                    style="background: linear-gradient(135deg, #28a745 0%, #20c997 100%); border: none; font-weight: bold;">
                    <i class="fas fa-sync-alt mr-2"></i>
                    Modificar Todo
                  </button>
                </div>

              </div>

              <!-- Información adicional -->
              <div class="row mt-3">
                <div class="col-12">
                  <div class="alert alert-info alert-dismissible fade show mb-0" role="alert" style="background: linear-gradient(135deg, #19292cff 0%, #0b1c1fff 100%); border-color: #b6d4da;">
                    <i class="fas fa-info-circle mr-2"></i>
                    <strong>Instrucciones:</strong> Complete los campos que desea modificar de forma masiva y presione "Modificar Todo".
                    Los campos vacíos no serán modificados.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                  </div>
                </div>
              </div>

            </div>
          </div>

          <!-- Tabla existente -->
          <div class="row">
            <div class="col-12" style="text-align:center">
              <div class="table-responsive" style="text-align:center">
                <div class="card-body">
                  <table id="tabla_practicas_obras_sociales" class="display compact" style="width:100%" style="text-align:center">
                    <thead style="background-color:#0A5D86;color:#FFFFFF;">
                      <tr style="text-align:center">
                        <th style="text-align:center">Nro.</th>
                        <th style="text-align:center">Código</th>
                        <th style="text-align:center">Práctica</th>
                        <th style="text-align:center">Obra social</th>
                        <th style="text-align:center">Precio monetario</th>
                        <th style="text-align:center">Acción</th>
                      </tr>
                    </thead>
                  </table>
                </div>
              </div>
            </div>
          </div>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">
            <i class="fa fa-arrow-right-from-bracket mr-1"></i>Cerrar
          </button>
        </div>
      </div>
    </div>
  </div>
  <div class="modal fade" id="modal_ver_historial" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <div style="display: flex; flex-direction: column;">
            <h5 class="modal-title" id="lb_titulo_historial"></h5>
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
                  <!-- Título general -->
                  <table id="tabla_ver_historial" class="display compact" style="width:100%; text-align:center;">
                    <thead style="background-color:#0252A0;color:#FFFFFF;">
                      <tr>
                        <th colspan="5" style="text-align:center; font-size: 18px; font-weight: bold;">HISTORIAL DE MODIFICACIONES - PRÁCTICAS</th>
                      </tr>
                      <tr style="text-align:center;">
                        <th style="text-align:center;">Nro.</th>
                        <th style="text-align:center;">Usuario que modifico</th>
                        <th style="text-align:center;">Codigo práctica</th>
                        <th style="text-align:center;">Práctica</th>
                        <th style="text-align:center;">Fecha de modificación</th>
                      </tr>
                    </thead>

                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">
            <i class="fa fa-arrow-right-from-bracket"></i> Cerrar
          </button>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="modal_ver_historial_obras_practicas" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <div style="display: flex; flex-direction: column;">
            <h5 class="modal-title" id="lb_titulo_historial_obras_prac"></h5>
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
                  <!-- Título general -->
                  <table id="tabla_ver_historial_obra_practica" class="display compact" style="width:100%; text-align:center;">
                    <thead style="background-color:#0252A0;color:#FFFFFF;">
                      <tr>
                        <th colspan="7" style="text-align:center; font-size: 18px; font-weight: bold;">HISTORIAL DE MODIFICACIONES - PRÁCTICAS - OBRAS SOCIALES</th>
                      </tr>
                      <tr style="text-align:center;">
                        <th style="text-align:center;">Nro.</th>
                        <th style="text-align:center;">Usuario que modifico</th>
                        <th style="text-align:center;">Codigo práctica</th>
                        <th style="text-align:center;">Práctica</th>
                        <th style="text-align:center;">Valor</th>
                        <th style="text-align:center;">Tipo de modificación</th>
                        <th style="text-align:center;">Fecha de modificación</th>
                      </tr>
                    </thead>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">
            <i class="fa fa-arrow-right-from-bracket"></i> Cerrar
          </button>
        </div>
      </div>
    </div>
  </div>




  <script>
    $(document).ready(function() {
      $('.js-example-basic-single').select2({
        placeholder: "Seleccionar Obra Social",
        allowClear: true
      });
      Cargar_Select_Obras_Sociales();
      listar_practicas();
    });
    $('#modal_registro').on('shown.bs.modal', function() {
      $('#select_obras').trigger('focus')
    })

    function toggleObrasSociales() {
      const checkbox = document.getElementById('chk_todas_obras_sociales');
      const selectObrasSociales = document.getElementById('txt_obras_sociales');

      if (checkbox.checked) {
        selectObrasSociales.disabled = true;
        selectObrasSociales.value = ""; // Limpia la selección
      } else {
        selectObrasSociales.disabled = false;
      }
    }

    //var n = new Date();
    //var y= n.getFullYear();
    //var m= n.getMonth()+1;
    //var d= n.getDate();
    //if(d<10){
    //    d='0' + d;
    //}
    //if(m<10){
    //    m='0' + m;

    //}
    //document.getElementById('txtfechainicio').value = y + "-" + m + "-" + d;
    //document.getElementById('txtfechafin').value = y + "-" + m + "-" + d;
  </script>
  <div class="modal fade" id="modal_registro" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header" style="background-color:#1FA0E0;">
          <h5 class="modal-title" id="exampleModalLabel" style="color:white; text-align:center"><b>REGISTRO DE PRÁCTICA</b></h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col-12 form-group" style="color:red">
              <h6><b>Campos Obligatorios (*)</b></h6>
            </div><br>
            <div class="col-6 form-group">
              <label for="">Código<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_code" placeholder="Ingrese el código de la práctica">
            </div>
            <div class="col-6 form-group">
              <label for="">Práctica<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_practica" placeholder="Ingrese el nombre">
            </div>
            <div class="col-4 form-group">
              <label for="">Valor monetario<b style="color:red">(*)</b>:</label>
              <input type="text" class="form-control" id="txt_valor" placeholder="Ingrese el valor monetario" onkeypress="return soloNumeros(event)">
            </div>
            <div class="col-8 form-group">
              <label for="">Obra Social<b style="color:red">(*)</b>:</label>
              <select type="text" class="js-example-basic-single" id="txt_obras_sociales" style="width:100%"></select>

              <!-- Checkbox estilizado -->
              <div class="custom-checkbox-container">
                <div class="form-check custom-checkbox">
                  <input class="form-check-input custom-check" type="checkbox" id="chk_todas_obras_sociales" onclick="toggleObrasSociales()">
                  <label class="form-check-label custom-label" for="chk_todas_obras_sociales">
                    <i class="fas fa-check-circle text-success" style="margin-right: 5px;"></i>
                    Todas las Obras Sociales
                  </label>
                </div>
              </div>
            </div>
            <div class="col-12 form-group">
              <button type="button" class="btn btn-success btn-block" onclick="Agregar_practica()">
                <i class="fas fa-plus"></i> <b>Agregar Práctica - Obra social</b>
              </button>
            </div>

            <!-- Tabla con marco -->
            <div class="col-12 table-responsive" style="text-align:center">
              <table id="tabla_practica_obra" style="width:100%" class="table">
                <thead class="thead-dark">
                  <tr>
                    <th>Id.</th>
                    <th>Practica</th>
                    <th>Nombre</th>
                    <th>Valor</th>
                    <th>Obra Social</th>
                    <th>Acci&oacute;n</th>
                  </tr>
                </thead>
                <tbody id="tbody_tabla_practica_obra">
                </tbody>
              </table>
              <div class="col-9">
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times ml-1"></i> Cerrar</button>
          <button type="button" class="btn btn-success" onclick="Registrar_Practicas()"><i class="fas fa-save"></i> Registrar</button>
        </div>
      </div>
    </div>
  </div>

  <style>
    /* Estilo personalizado para el checkbox */
    .custom-checkbox-container {
      margin-top: 12px;
    }

    .custom-checkbox {
      display: flex;
      align-items: center;
      padding: 10px 15px;
      background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
      border: 2px solid #dee2e6;
      border-radius: 8px;
      cursor: pointer;
      transition: all 0.3s ease;
      margin-bottom: 0;
    }

    .custom-checkbox:hover {
      background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
      border-color: #1FA0E0;
      transform: translateY(-1px);
      box-shadow: 0 4px 12px rgba(31, 160, 224, 0.2);
    }

    .custom-check {
      width: 18px;
      height: 18px;
      margin-right: 10px;
      cursor: pointer;
      accent-color: #1FA0E0;
      transform: scale(1.2);
    }

    .custom-label {
      margin-bottom: 0;
      font-weight: 600;
      color: #495057;
      cursor: pointer;
      user-select: none;
      display: flex;
      align-items: center;
      font-size: 14px;
    }

    .custom-checkbox.checked {
      background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
      border-color: #28a745;
    }

    .custom-checkbox.checked .custom-label {
      color: #155724;
    }

    /* Animación del ícono cuando está seleccionado */
    .custom-checkbox input:checked+.custom-label .fa-check-circle {
      color: #28a745 !important;
      animation: checkPulse 0.3s ease;
    }

    @keyframes checkPulse {
      0% {
        transform: scale(1);
      }

      50% {
        transform: scale(1.2);
      }

      100% {
        transform: scale(1);
      }
    }
  </style>

  <script>
    // Agregar funcionalidad para cambiar el estilo del checkbox cuando se selecciona
    document.addEventListener('DOMContentLoaded', function() {
      const checkbox = document.getElementById('chk_todas_obras_sociales');
      const container = document.querySelector('.custom-checkbox');

      if (checkbox && container) {
        checkbox.addEventListener('change', function() {
          if (this.checked) {
            container.classList.add('checked');
          } else {
            container.classList.remove('checked');
          }
        });
      }
    });
  </script>


  <style>
    /* Estilos adicionales para mejorar la apariencia */
    .form-label {
      font-size: 0.875rem;
      margin-bottom: 0.25rem;
    }

    .shadow-sm {
      box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075) !important;
    }

    .btn:hover {
      transform: translateY(-1px);
      transition: all 0.2s ease;
    }

    .card {
      border: none;
      box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
    }

    .form-control:focus {
      border-color: #081d27ff;
      box-shadow: 0 0 0 0.2rem rgba(10, 93, 134, 0.25);
    }

    .input-group-text {
      font-weight: bold;
    }

    .alert-info {
      font-size: 0.875rem;
    }

    @media (max-width: 768px) {
      .col-md-3 {
        margin-bottom: 1rem;
      }
    }
  </style>