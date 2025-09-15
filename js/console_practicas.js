var tbl_practicas;
function listar_practicas() {
  Cargar_Select_Obras_Sociales();
  document.getElementById("txtfechainicio").value = "";
  document.getElementById("txtfechafin").value = "";

  tbl_practicas = $("#tabla_practicas").DataTable({
    ordering: false,
    bLengthChange: true,
    searching: { regex: false },
    lengthMenu: [
      [10, 25, 50, 100, -1],
      [10, 25, 50, 100, "All"],
    ],
    pageLength: 10,
    destroy: true,
    async: false,
    pagingType: "full_numbers",
    scrollCollapse: true,
    responsive: true,
    processing: true,
    ajax: {
      url: "../controller/practicas/controlador_listar_practicas.php",
      type: "POST",
    },
    dom: "Bfrtip",
    buttons: [
      {
        extend: "excelHtml5",
        text: '<i class="fas fa-file-excel"></i> Excel',
        titleAttr: "Exportar a Excel",
        filename: "LISTA DE PRÁCTICAS",
        title: "LISTA DE PRÁCTICAS",
        className: "btn btn-excel",
        exportOptions: {
          columns: [1, 2, 3, 4, 5, 6, 7, 8], // Exportar solo hasta la columna 'estado'
        },
      },
      {
        extend: "pdfHtml5",
        text: '<i class="fas fa-file-pdf"></i> PDF',
        titleAttr: "Exportar a PDF",
        filename: "LISTA DE PRÁCTICAS",
        title: "LISTA DE PRÁCTICAS",
        className: "btn btn-pdf",
        orientation: "landscape", // <-- Establece la orientación en horizontal
        pageSize: "A4", // <-- Especifica el tamaño de la página
        exportOptions: {
          columns: [1, 2, 3, 4, 5, 6, 7, 8], // Exportar solo hasta la columna 'estado'
        },
      },
      {
        extend: "print",
        text: '<i class="fa fa-print"></i> Imprimir',
        titleAttr: "Imprimir",
        title: "LISTA DE PRÁCTICAS",
        className: "btn btn-print",
        exportOptions: {
          columns: [1, 2, 3, 4, 5, 6, 7, 8], // Exportar solo hasta la columna 'estado'
        },
      },
    ],

    columns: [
      { defaultContent: "" },
      { data: "cod_practica" },
      { data: "practica" },

      { data: "fecha_formateada" },
      { data: "fecha_formateada2" },
      { data: "USUARIO" },
      {
        data: "estado",
        render: function (data, type, row) {
          if (data == "ACTIVO") {
            return '<span class="badge bg-success">ACTIVO</span>';
          } else {
            return '<span class="badge bg-danger">INACTIVO</span>';
          }
        },
      },
      {
        defaultContent: `
      <button class="ver_todo btn btn-success btn-sm" title="Ver practicas - obras">
        <i class="fa fa-eye"></i> Ver todos
      </button>
      <button class="historial btn btn-warning btn-sm" title="Ver historial de ediciones">
        <i class="fa fa-history"></i> Historial
      </button>
      <button class='editar btn btn-primary btn-sm' title='Editar datos de área'>
        <i class='fa fa-edit'></i> Editar
      </button>
      <button class='eliminar btn btn-danger btn-sm' title='Eliminar datos de área'>
        <i class='fa fa-trash'></i> Eliminar
      </button>
    `,
      },
    ],

    language: idioma_espanol,
    select: true,
  });
  tbl_practicas.on("draw.td", function () {
    var PageInfo = $("#tabla_practicas").DataTable().page.info();
    tbl_practicas
      .column(0, { page: "current" })
      .nodes()
      .each(function (cell, i) {
        cell.innerHTML = i + 1 + PageInfo.start;
      });
  });
}

function listar_practicas_filtro() {
  let fechaini = document.getElementById("txtfechainicio").value;
  let fechafin = document.getElementById("txtfechafin").value;
  tbl_practicas = $("#tabla_practicas").DataTable({
    ordering: false,
    bLengthChange: true,
    searching: { regex: false },
    lengthMenu: [
      [10, 25, 50, 100, -1],
      [10, 25, 50, 100, "All"],
    ],
    pageLength: 10,
    destroy: true,
    async: false,
    pagingType: "full_numbers",
    scrollCollapse: true,
    responsive: true,
    processing: true,
    ajax: {
      url: "../controller/practicas/controlador_listar_practicas_filtro.php",
      type: "POST",
      data: {
        fechaini: fechaini,
        fechafin: fechafin,
      },
    },
    dom: "Bfrtip",
    buttons: [
      {
        extend: "excelHtml5",
        text: '<i class="fas fa-file-excel"></i> Excel',
        titleAttr: "Exportar a Excel",
        filename: "LISTA DE PRÁCTICAS",
        title: "LISTA DE PRÁCTICAS",
        className: "btn btn-excel",
        exportOptions: {
          columns: [1, 2, 3, 4, 5, 6, 7, 8], // Exportar solo hasta la columna 'estado'
        },
      },
      {
        extend: "pdfHtml5",
        text: '<i class="fas fa-file-pdf"></i> PDF',
        titleAttr: "Exportar a PDF",
        filename: "LISTA DE PRÁCTICAS",
        title: "LISTA DE PRÁCTICAS",
        className: "btn btn-pdf",
        orientation: "landscape", // <-- Establece la orientación en horizontal
        pageSize: "A4", // <-- Especifica el tamaño de la página
        exportOptions: {
          columns: [1, 2, 3, 4, 5, 6, 7, 8], // Exportar solo hasta la columna 'estado'
        },
      },
      {
        extend: "print",
        text: '<i class="fa fa-print"></i> Imprimir',
        titleAttr: "Imprimir",
        title: "LISTA DE PRÁCTICAS",
        className: "btn btn-print",
        exportOptions: {
          columns: [1, 2, 3, 4, 5, 6, 7, 8], // Exportar solo hasta la columna 'estado'
        },
      },
    ],
    columns: [
      { defaultContent: "" },
      { data: "cod_practica" },
      { data: "practica" },

      { data: "fecha_formateada" },
      { data: "fecha_formateada2" },
      { data: "USUARIO" },
      {
        data: "estado",
        render: function (data, type, row) {
          if (data == "ACTIVO") {
            return '<span class="badge bg-success">ACTIVO</span>';
          } else {
            return '<span class="badge bg-danger">INACTIVO</span>';
          }
        },
      },
      {
        defaultContent: `
          <button class="ver_todo btn btn-success btn-sm" title="Ver practicas - obras">
            <i class="fa fa-eye"></i> Ver todos
          </button>    
          <button class="historial btn btn-warning btn-sm" title="Ver historial de ediciones">
            <i class="fa fa-history"></i> Historial
          </button>
          <button class='editar btn btn-primary btn-sm' title='Editar datos de área'>
            <i class='fa fa-edit'></i> Editar
          </button>
          <button class='eliminar btn btn-danger btn-sm' title='Eliminar datos de área'>
            <i class='fa fa-trash'></i> Eliminar
          </button>
        `,
      },
    ],

    language: idioma_espanol,
    select: true,
  });
  tbl_practicas.on("draw.td", function () {
    var PageInfo = $("#tabla_practicas").DataTable().page.info();
    tbl_practicas
      .column(0, { page: "current" })
      .nodes()
      .each(function (cell, i) {
        cell.innerHTML = i + 1 + PageInfo.start;
      });
  });
}

//EDITAR
$("#tabla_practicas").on("click", ".editar", function () {
  var data = tbl_practicas.row($(this).parents("tr")).data();

  if (tbl_practicas.row(this).child.isShown()) {
    var data = tbl_practicas.row(this).data();
  }
  
  $("#modal_editar").modal("show");
  document.getElementById("txt_id_practica").value = data.id_practica;
  document.getElementById("txt_code_editar").value = data.cod_practica;
  document.getElementById("txt_practica_editar").value = data.practica;
  
  // NUEVO: Mostrar el total de obras sociales
  document.getElementById("total_obras_display").textContent = data.total_obras || 0;
  
  // Cambiar el color del indicador según la cantidad
  let totalObrasElement = document.getElementById("total_obras_display");
  let alertElement = totalObrasElement.closest('.alert');
  
  if (data.total_obras > 0) {
    totalObrasElement.style.color = "#28a745"; // Verde si tiene obras
    alertElement.style.borderColor = "#28a745";
    alertElement.style.backgroundColor = "#d4edda";
  } else {
    totalObrasElement.style.color = "#dc3545"; // Rojo si no tiene obras
    alertElement.style.borderColor = "#dc3545";
    alertElement.style.backgroundColor = "#f8d7da";
  }
  
  $("#txt_obras_sociales_editar")
    .select2()
    .val(data.id_obras)
    .trigger("change.select2");
  document.getElementById("txt_estatus").value = data.estado;
  
  console.log("Total de obras sociales:", data.total_obras);
});

function AbrirRegistro() {
  $("#modal_registro").modal({ backdrop: "static", keyboard: false });
  $("#modal_registro").modal("show");
}

//CARGAR OBRAS SOCIALES
function Cargar_Select_Obras_Sociales() {
  $.ajax({
    url: "../controller/obras_sociales/controlador_cargar_select_obras_sociales.php",
    type: "POST",
  }).done(function (resp) {
    let data = JSON.parse(resp);
    let cadena = "<option value=''>Seleccionar Obra Social</option>";
    if (data.length > 0) {
      for (let i = 0; i < data.length; i++) {
        cadena +=
          "<option value='" +
          data[i][0] +
          "'>CUIT: " +
          data[i][1] +
          " - Nombre: " +
          data[i][2] +
          "</option>";
      }
    } else {
      cadena += "<option value=''>No hay obras disponibles</option>";
    }
    $("#txt_obras_sociales").html(cadena);
    $("#txt_obras_sociales_editar").html(cadena);
    $("#select_obras").html(cadena);

    // Inicializar Select2 después de cargar opciones
    $("#txt_obras_sociales").select2({
      placeholder: "Seleccionar Obra Social",
      allowClear: true,
      width: "100%", // Asegura que use todo el ancho
    });
  });
}
// Agregar estos event listeners
$("#modal_registro").on("shown.bs.modal", function () {
  $("#txt_obras_sociales").select2({
    placeholder: "Seleccionar Obra Social",
    allowClear: true,
    dropdownParent: $("#modal_registro"),
  });
});

$("#modal_editar").on("shown.bs.modal", function () {
  $("#txt_obras_sociales_editar").select2({
    placeholder: "Seleccionar Obra Social",
    allowClear: true,
    dropdownParent: $("#modal_editar"),
  });
});
function Registrar_Practicas() {
  let code = document.getElementById("txt_code").value;
  let pract = document.getElementById("txt_practica").value;
  let idusu = document.getElementById("txtprincipalid").value;

  if (code.length == 0 || pract.length == 0) {
    return Swal.fire(
      "Mensaje de Advertencia",
      "Tiene campos vacios",
      "warning"
    );
  }

  // Verificar si el checkbox "Todas las obras sociales" está marcado
  let todasObras = document.getElementById("chk_todas_obras_sociales").checked;
  
  if (!todasObras) {
    // Validar que haya al menos una obra social agregada manualmente
    let count = $("#tabla_practica_obra tbody#tbody_tabla_practica_obra tr").length;
    if (count === 0) {
      return Swal.fire(
        "Mensaje de Advertencia", 
        "Debe agregar al menos una obra social o seleccionar 'Todas las Obras Sociales'", 
        "warning"
      );
    }
  }

  $.ajax({
    url: "../controller/practicas/controlador_registro_practicas.php",
    type: "POST",
    data: {
      code: code,
      pract: pract,
      idusu: idusu
    },
  }).done(function (resp) {
    console.log(resp);
    if (resp > 0) {
      if (todasObras) {
        // Si está marcado "Todas las obras sociales", registrar para todas
        Registrar_Practica_Todas_Obras(parseInt(resp));
      } else {
        // Si no, registrar solo las seleccionadas manualmente
        Registrar_Detalle_practicasObra(parseInt(resp));
      }
      
      Swal.fire(
        "Mensaje de Confirmación",
        "Nueva práctica registrada con el Código N°: <b>" + code + "</b>",
        "success"
      ).then((value) => {
        tbl_practicas.ajax.reload();
        limpiarFormulario();
        $("#modal_registro").modal("hide");
      });
    } else {
      return Swal.fire(
        "Mensaje de Error",
        "No se completo el registro",
        "error"
      );
    }
  });
}

// NUEVA FUNCIÓN: Registrar práctica para todas las obras sociales
function Registrar_Practica_Todas_Obras(id) {
  let code = document.getElementById("txt_code").value;
  let pract = document.getElementById("txt_practica").value;
  let valor = document.getElementById("txt_valor").value;

  if (valor.length == 0) {
    return Swal.fire(
      "Mensaje de Advertencia", 
      "Debe ingresar el valor monetario", 
      "warning"
    );
  }

  $.ajax({
    url: "../controller/practicas/controlador_registro_todas_obras.php",
    type: 'POST',
    data: {
      id: id,
      codigo: code,
      practica: pract,
      valor: valor
    }
  }).done(function (resp) {
    if (resp > 0) {
      console.log("Práctica registrada para todas las obras sociales");
    } else {
      return Swal.fire(
        "Mensaje De Advertencia", 
        "Error al registrar para todas las obras sociales", 
        "warning"
      );
    }
  });
}

// FUNCIÓN PARA MANEJAR EL TOGGLE DEL CHECKBOX
function toggleObrasSociales() {
  let checkbox = document.getElementById("chk_todas_obras_sociales");
  let selectObras = document.getElementById("txt_obras_sociales");
  let btnAgregar = document.querySelector("button[onclick='Agregar_practica_obra()']");
  let inputValor = document.getElementById("txt_valor");

  if (checkbox.checked) {
    // Si está marcado, deshabilitar select y botón agregar
    $(selectObras).prop('disabled', true);
    btnAgregar.disabled = true;
    btnAgregar.style.opacity = '0.5';
    
    // Limpiar la tabla
    $("#tabla_practica_obra tbody#tbody_tabla_practica_obra").empty();
    
    // Hacer obligatorio el valor monetario
    inputValor.required = true;
    inputValor.style.borderColor = '#dc3545';
    
    Swal.fire({
      icon: 'info',
      title: 'Modo: Todas las Obras Sociales',
      text: 'Se registrará esta práctica para todas las obras sociales disponibles.',
      timer: 3000,
      showConfirmButton: false
    });
  } else {
    // Si no está marcado, habilitar select y botón agregar
    $(selectObras).prop('disabled', false);
    btnAgregar.disabled = false;
    btnAgregar.style.opacity = '1';
    
    // Quitar obligatoriedad visual del valor
    inputValor.required = false;
    inputValor.style.borderColor = '';
  }
}

// VALIDACIÓN MODIFICADA
function verificarid(id) {
  let existe = $("#tbody_tabla_practica_obra td[for='id']").filter(function () {
    return $(this).text() === id;
  }).length > 0;
  
  return existe;
}

// AGREGAR PRÁCTICA-OBRA MODIFICADA
function Agregar_practica_obra() {
  // Verificar si el checkbox está marcado
  let todasObras = document.getElementById("chk_todas_obras_sociales").checked;
  
  if (todasObras) {
    return Swal.fire(
      "Mensaje de Advertencia", 
      "No puede agregar obras individuales mientras esté seleccionado 'Todas las Obras Sociales'", 
      "warning"
    );
  }

  var cod = $("#txt_code").val().trim(); 
  var prac = $("#txt_practica").val().trim(); 
  var val = $("#txt_valor").val().trim(); 
  var idobr = $("#txt_obras_sociales").val().trim(); 
  var obr = $("#txt_obras_sociales option:selected").text().trim();

  if (cod.length == 0 || prac.length == 0 || val.length == 0 || idobr.length == 0) {
    return Swal.fire("Mensaje de Advertencia", "Complete todos los campos obligatorios", "warning");
  }

  if (verificarid(idobr)) {
    return Swal.fire("Mensaje de Advertencia", "La obra social asociada a la práctica ya fue agregado a la tabla", "warning");
  }

  var datos_agregar = `
    <tr>
      <td>${cod}</td>
      <td>${prac}</td>
      <td>${val}</td>
      <td for="id">${idobr}</td>
      <td>${obr}</td>
      <td><button class='btn btn-danger' onclick='remove(this)'><i class='fas fa-trash'></i></button></td>
    </tr>`;

  $("#tbody_tabla_practica_obra").append(datos_agregar); 
  $("#txt_obras_sociales").val("").trigger("change");
  $("#txt_valor").val("");
}

// BORRAR REGISTRO (sin cambios)
function remove(t) {
  $(t).closest("tr").remove();
}

// REGISTRO DETALLE PRACTICAS - OBRAS (sin cambios significativos)
function Registrar_Detalle_practicasObra(id) {
  let count = $("#tabla_practica_obra tbody#tbody_tabla_practica_obra tr").length;
  if (count === 0) {
      return Swal.fire("Mensaje de Advertencia", "El detalle de las prácticas debe tener al menos un registro", "warning");
  }

  let arreglo_codigo = [];
  let arreglo_practica = [];
  let arreglo_valor = [];
  let arreglo_id = [];

  $("#tabla_practica_obra tbody#tbody_tabla_practica_obra tr").each(function () {
      arreglo_codigo.push($(this).find('td').eq(0).text().trim());
      arreglo_practica.push($(this).find('td').eq(1).text().trim());
      arreglo_valor.push($(this).find('td').eq(2).text().trim());
      arreglo_id.push($(this).find('td').eq(3).text().trim());
  });

  let codigo = arreglo_codigo.join(",");
  let practica = arreglo_practica.join(",");
  let valor = arreglo_valor.join(",");
  let idobra = arreglo_id.join(",");

  $.ajax({
      url: "../controller/practicas/controlador_detalle_practicas_obra.php",
      type: 'POST',
      data: {
          id: id,
          codigo: codigo,
          practica: practica,
          valor: valor,
          idobra: idobra
      }
  }).done(function (resp) {
      if (resp > 0) {
          console.log("Detalles registrados correctamente");
        } else {
          return Swal.fire("Mensaje De Advertencia", "Lo sentimos, no se pudo completar el registro", "warning");
      }
  });
}

// FUNCIÓN PARA LIMPIAR EL FORMULARIO
function limpiarFormulario() {
  document.getElementById('txt_code').value = "";
  document.getElementById('txt_practica').value = "";
  document.getElementById('txt_valor').value = "";
  document.getElementById('chk_todas_obras_sociales').checked = false;
  
  // Rehabilitar controles
  $("#txt_obras_sociales").prop('disabled', false).val("").trigger("change");
  let btnAgregar = document.querySelector("button[onclick='Agregar_practica_obra()']");
  btnAgregar.disabled = false;
  btnAgregar.style.opacity = '1';
  
  // Limpiar tabla
  $("#tabla_practica_obra tbody#tbody_tabla_practica_obra").empty();
}


///////VALIDAR EMAIL
function Eliminar_paciente(id) {
  $.ajax({
    url: "../controller/practicas/controlador_eliminar_practicas.php",
    type: "POST",
    data: {
      id: id,
    },
  }).done(function (resp) {
    if (resp > 0) {
      Swal.fire(
        "Mensaje de Confirmación",
        "Se elimino la práctica con exito",
        "success"
      ).then((value) => {
        tbl_practicas.ajax.reload();
      });
    } else {
      return Swal.fire(
        "Mensaje de Advetencia",
        "No se puede eliminar esta práctica por que esta siendo utilizado en el módulo de Registros, verifique por favor",
        "warning"
      );
    }
  });
}

//ENVIANDO AL BOTON DELETE
$("#tabla_practicas").on("click", ".eliminar", function () {
  var data = tbl_practicas.row($(this).parents("tr")).data();

  if (tbl_practicas.row(this).child.isShown()) {
    var data = tbl_practicas.row(this).data();
  }
  Swal.fire({
    title:
      "Desea eliminar la práctica con el Código N°: " + data.cod_practica + "?",
    text: "Una vez aceptado la práctica sera eliminada!!!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Si, Eliminar",
  }).then((result) => {
    if (result.isConfirmed) {
      Eliminar_paciente(data.id_practica);
    }
  });
});

//MODAL VER HISTORIAL
$("#tabla_practicas").on("click", ".historial", function () {
  var data = tbl_practicas.row($(this).parents("tr")).data();

  if (tbl_practicas.row(this).child.isShown()) {
    var data = tbl_practicas.row(this).data();
  }
  $("#modal_ver_historial").modal("show");

  document.getElementById("lb_titulo_historial").innerHTML =
    "<b>HISTORIAL DE PRACTICAS:</b> " + data.practica + "";

  listar_historial(data.id_practica);
});
// VISTA DE HISTORIAL
var tbl_historial;
function listar_historial(id) {
  tbl_historial = $("#tabla_ver_historial").DataTable({
    ordering: false,
    bLengthChange: true,
    searching: false, // Deshabilita la barra de búsqueda
    lengthMenu: [
      [10, 25, 50, 100, -1],
      [10, 25, 50, 100, "Todos"],
    ],
    pageLength: 5,
    destroy: true,
    pagingType: "full_numbers",
    scrollCollapse: true,
    responsive: true,
    async: false,
    processing: true,
    ajax: {
      url: "../controller/practicas/controlador_listar_historial_practicas.php",
      type: "POST",
      data: { id: id },
      dataSrc: function (json) {
        console.log("Respuesta JSON:", json);
        return json.data;
      },
    },
    dom: "Bfrtip",
    buttons: [
      {
        extend: "excelHtml5",
        text: '<i class="fas fa-file-excel"></i> Excel',
        titleAttr: "Exportar a Excel",
        filename: "LISTA_DE_HISTORIAL",
        title: "LISTA DE HISTORIAL",
        className: "btn btn-success",
      },
      {
        extend: "pdfHtml5",
        text: '<i class="fas fa-file-pdf"></i> PDF',
        titleAttr: "Exportar a PDF",
        filename: "LISTA_DE_HISTORIAL",
        title: "LISTA DE HISTORIAL",
        className: "btn btn-danger",
      },
      {
        extend: "print",
        text: '<i class="fa fa-print"></i> Imprimir',
        titleAttr: "Imprimir",
        title: "LISTA DE HISTORIAL",
        className: "btn btn-primary",
      },
    ],
    columns: [
      {
        data: null,
        render: function (data, type, row, meta) {
          return meta.row + 1;
        },
      },
      { data: "USUARIO" },
      { data: "cod_practica" },
      { data: "practica" },
      { data: "fecha_formateada" },
    ],
    language: {
      emptyTable: "No se encontraron datos", // ✅ Mensaje cuando la tabla está vacía
      zeroRecords: "No se encontraron resultados", // ✅ Mensaje para búsquedas sin coincidencias
      info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
      infoEmpty: "Mostrando 0 a 0 de 0 registros",
      infoFiltered: "(filtrado de _MAX_ registros en total)",
      lengthMenu: "Mostrar _MENU_ registros",
      loadingRecords: "Cargando...",
      processing: "Procesando...",
      search: "Buscar:",
      paginate: {
        first: "Primero",
        last: "Último",
        next: "Siguiente",
        previous: "Anterior",
      },
    },
    select: true,
  });
}



//MODAL VER PRACTICAS OBRAS
$("#tabla_practicas").on("click", ".ver_todo", function () {
  var data = tbl_practicas.row($(this).parents("tr")).data();

  if (tbl_practicas.row(this).child.isShown()) {
    var data = tbl_practicas.row(this).data();
  }
  $("#modal_practicas_obras").modal("show");

  document.getElementById("lb_titulo").innerHTML =
    "<b>DETALLE DE PRACTICAS - OBRAS:</b> " + data.practica + "";
  document.getElementById("txt_id_practica2").value = data.id_practica;

  listar_practicaS_obras(data.id_practica);
});
// VISTA DE HISTORIAL
var tbl_detalle_practica_obra;

function listar_practicaS_obras(id) {
  tbl_detalle_practica_obra = $("#tabla_practicas_obras_sociales").DataTable({
    ordering: false,
    bLengthChange: true,
    lengthMenu: [
      [10, 25, 50, 100, -1],
      [10, 25, 50, 100, "Todos"],
    ],
    pageLength: 5,
    destroy: true,
    pagingType: "full_numbers",
    scrollCollapse: true,
    responsive: true,
    async: false,
    processing: true,
    ajax: {
      url: "../controller/practicas/controlador_listar_practicas_obra_sociales.php",
      type: "POST",
      data: { id: id },
      dataSrc: function (json) {
        console.log("Respuesta JSON:", json);
        return json.data;
      },
    },
    dom: "Bfrtip",
    buttons: [
    {
      extend: "excelHtml5",
      text: '<i class="fas fa-file-excel"></i> Excel',
      titleAttr: "Exportar a Excel",
      filename: "LISTA_DE_PRACTICAS_OBRAS",
      title: "LISTA DE PRACTICAS - OBRAS",
      className: "btn btn-success",
      exportOptions: {
        columns: [0,1,2,3,4],
        format: {
          body: function (data, row, column, node) {
            var $input = $('input', node);
            var value = $input.length ? $input.val() : $(node).text().trim();
            if (column === 4) { // columna valor
              return '$AR ' + value;
            }
            return value;
          }
        }
      }
    },
    {
      extend: "pdfHtml5",
      text: '<i class="fas fa-file-pdf"></i> PDF',
      titleAttr: "Exportar a PDF",
      filename: "LISTA_DE_PRACTICAS_OBRAS",
      title: "LISTA DE PRACTICAS - OBRAS",
      className: "btn btn-danger",
      exportOptions: {
        columns: [0,1,2,3,4],
        format: {
          body: function (data, row, column, node) {
            var $input = $('input', node);
            var value = $input.length ? $input.val() : $(node).text().trim();
            if (column === 4) { // columna valor
              return '$AR ' + value;
            }
            return value;
          }
        }
      }
    },
    {
      extend: "print",
      text: '<i class="fa fa-print"></i> Imprimir',
      titleAttr: "Imprimir",
      title: "LISTA DE PRACTICAS - OBRAS",
      className: "btn btn-primary",
      exportOptions: {
        columns: [0,1,2,3,4],
        format: {
          body: function (data, row, column, node) {
            var $input = $('input', node);
            var value = $input.length ? $input.val() : $(node).text().trim();
            if (column === 4) { // columna valor
              return '$AR ' + value;
            }
            return value;
          }
        }
      }
    }
  ],

    columns: [
      {
        data: null,
        render: function (data, type, row, meta) {
          return meta.row + 1;
        },
      },
      { 
        data: "codigo_prac",
        render: function (data, type, row, meta) {
          return `<input type="text" class="form-control input-codigo" id="txt_codi_prac" value="${data || ''}" style="width: 100%;">`;
        },
      },
      { 
        data: "nombre_prac",
        render: function (data, type, row, meta) {
          return `<input type="text" class="form-control input-practica" id="txt_practica_nom" value="${data || ''}" style="width: 100%;">`;
        },
      },
      { data: "Nombre" },
      {
        data: "valor",
        render: function (data, type, row, meta) {
          return `<div class="input-group">
                    <span class="input-group-text">$AR</span>
                    <input type="number" class="form-control input-valor" id="txt_id_valor_prac" value="${data || ''}" step="0.01" min="0">
                  </div>`;
        },
      },
      {
        defaultContent: `
        <button class='historial_prac_obra btn btn-success btn-sm' title='Ver historial de modificaciones'>
          <i class='fa fa-history'></i> Ver
        </button>

        <button class='editar_practica_obra btn btn-primary btn-sm' title='Editar datos de área'>
          <i class='fa fa-edit'></i> Editar
        </button>
        <button class='eliminar_prac_obra btn btn-danger btn-sm' title='Eliminar datos de área'>
          <i class='fa fa-trash'></i> Eliminar
        </button>
      `,
      },
    ],
    language: {
      emptyTable: "No se encontraron datos",
      zeroRecords: "No se encontraron resultados",
      info: "Mostrando _START_ a _END_ de _TOTAL_ registros",
      infoEmpty: "Mostrando 0 a 0 de 0 registros",
      infoFiltered: "(filtrado de _MAX_ registros en total)",
      lengthMenu: "Mostrar _MENU_ registros",
      loadingRecords: "Cargando...",
      processing: "Procesando...",
      search: "Buscar:",
      paginate: {
        first: "Primero",
        last: "Último",
        next: "Siguiente",
        previous: "Anterior",
      },
    },
    select: true,
  });
}

// Funciones auxiliares para obtener los valores de los inputs
function obtenerValoresFila(numeroFila) {
  return {
    codigo: $("#codigo_" + numeroFila).val(),
    practica: $("#practica_" + numeroFila).val(),
    valor: $("#valor_" + numeroFila).val()
  };
}

function obtenerTodosLosValores() {
  var valores = [];
  $("#tabla_practicas_obras_sociales tbody tr").each(function(index) {
    var fila = {
      numero: index,
      codigo: $("#codigo_" + index).val(),
      practica: $("#practica_" + index).val(),
      valor: $("#valor_" + index).val()
    };
    valores.push(fila);
  });
  return valores;
}

function Eliminar_practica_obra(id) {
  $.ajax({
    url: "../controller/practicas/controlador_eliminar_practicas_obra.php",
    type: "POST",
    data: {
      id: id,
    },
  }).done(function (resp) {
    if (resp > 0) {
      Swal.fire(
        "Mensaje de Confirmación",
        "Se elimino la práctica - obra social con exito",
        "success"
      ).then((value) => {tabla_ver_historial
        tbl_detalle_practica_obra.ajax.reload();
      });
    } else {
      return Swal.fire(
        "Mensaje de Advetencia",
        "No se puede eliminar esta práctica - obra social por que esta siendo utilizado en el módulo de Pacientes, verifique por favor",
        "warning"
      );
    }
  });
}

//ENVIANDO AL BOTON DELETE
$("#tabla_practicas_obras_sociales").on("click", ".eliminar_prac_obra", function () {
  var data = tbl_detalle_practica_obra.row($(this).parents("tr")).data();

  if (tbl_detalle_practica_obra.row(this).child.isShown()) {
    var data = tbl_detalle_practica_obra.row(this).data();
  }
  Swal.fire({
    title:
      "Desea eliminar la práctica - obra social con el Código N°: " + data.cod_practica + "?",
    text: "Una vez aceptado la práctica - obra social sera eliminada!!!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Si, Eliminar",
  }).then((result) => {
    if (result.isConfirmed) {
      Eliminar_practica_obra(data.id_practicas_obras);
    }
  });
});



function Modificacion_masiva() {
  let id = document.getElementById("txt_id_practica2").value;
  let code = document.getElementById("bulk_codigo").value.trim();
  let pract = document.getElementById("bulk_practica").value.trim();
  let valor = document.getElementById("bulk_valor").value.trim();
  let idusu = document.getElementById("txtprincipalid").value;

  // primero validar que haya id (debe existir siempre)
  if (id.length === 0) {
    return Swal.fire(
      "Mensaje de Advertencia",
      "No se ha especificado la práctica a modificar",
      "warning"
    );
  }

  // validar que al menos uno de los campos (code, pract, valor) tenga algo
  if (code.length === 0 && pract.length === 0 && valor.length === 0) {
    return Swal.fire(
      "Mensaje de Advertencia",
      "Debe ingresar al menos un campo para modificar",
      "warning"
    );
  }

  $.ajax({
    url: "../controller/practicas/controlador_modificar_practicas_obras_masivo.php",
    type: "POST",
    data: {
      id: id,
      code: code,
      pract: pract,
      valor: valor,
      idusu: idusu
    },
  }).done(function (resp) {
    if (resp > 0) {
      Swal.fire(
        "Mensaje de Confirmación",
        "Datos de la Práctica - Obra social Actualizado de forma masiva",
        "success"
      ).then(() => {
        tbl_detalle_practica_obra.ajax.reload();
        tbl_practicas.ajax.reload();

        // limpiar solo los campos de entrada, no el id
        document.getElementById("bulk_codigo").value = "";
        document.getElementById("bulk_practica").value = "";
        document.getElementById("bulk_valor").value = "";
      });
    } else {
      Swal.fire(
        "Mensaje de Error",
        "No se completó el proceso",
        "error"
      );
    }
  });
}



function Editar_practica_obra(id) {
  let code = $("#tabla_practicas_obras_sociales tbody tr").find(".input-codigo").val().trim();
  let pract = $("#tabla_practicas_obras_sociales tbody tr").find(".input-practica").val().trim();
  let valor = $("#tabla_practicas_obras_sociales tbody tr").find(".input-valor").val().trim();
  let idusu = document.getElementById("txtprincipalid").value;

  //validar
  if (code.length == 0 || pract.length == 0 || valor.length == 0) {
    return Swal.fire(
      "Mensaje de Advertencia",
      "Tiene campos vacios",
      "warning"
    );
  };
  $.ajax({
    url: "../controller/practicas/controlador_editar_practicas_obra.php",
    type: "POST",
    data: {
      id: id,
      code:code,
      pract:pract,
      valor:valor,
      idusu:idusu
    },
  }).done(function (resp) {
    if (resp > 0) {
      Swal.fire(
        "Mensaje de Confirmación",
        "Se modifica la práctica - obra social con exito",
        "success"
      ).then((value) => {
        tbl_detalle_practica_obra.ajax.reload();
      });
    } else {
      return Swal.fire(
        "Mensaje de Advetencia",
        "No se puede modificar esta práctica - obra social, verifique por favor",
        "warning"
      );
    }
  });
}

//ENVIANDO AL BOTON DELETE
$("#tabla_practicas_obras_sociales").on("click", ".editar_practica_obra", function () {
  var data = tbl_detalle_practica_obra.row($(this).parents("tr")).data();

  if (tbl_detalle_practica_obra.row(this).child.isShown()) {
    var data = tbl_detalle_practica_obra.row(this).data();
  }
  Swal.fire({
    title:
      "Desea modificar la práctica - obra social con el Código N°: " + data.cod_practica + " y obra social"+data.Nombre+"?",
    text: "Una vez aceptado la práctica - obra social sera eliminada!!!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Si, Modificar",
  }).then((result) => {
    if (result.isConfirmed) {
      Editar_practica_obra(data.id_practicas_obras);
    }
  });
});





//MODAL VER HISTORIAL
$('#tabla_practicas_obras_sociales').on('click','.historial_prac_obra',function(){
  var data = tbl_detalle_practica_obra.row($(this).parents('tr')).data();

  if(tbl_detalle_practica_obra.row(this).child.isShown()){
      var data = tbl_detalle_practica_obra.row(this).data();
  }
$("#modal_ver_historial_obras_practicas").modal('show');

  document.getElementById('lb_titulo_historial_obras_prac').innerHTML="<b>HISTORIAL DE MODIFICACIÓN PRACTICA - OBRA:</b> "+data.nombre_prac+"";

  listar_historial_modi_prac_obra(data.id_practicas_obras);

})
// VISTA DE HISTORIAL
var tbl_historial_modi_prac_obra;
function listar_historial_modi_prac_obra(id) {
  tbl_historial_modi_prac_obra = $("#tabla_ver_historial_obra_practica").DataTable({
      "ordering": false,
      "bLengthChange": true,
      "searching": false,  // Deshabilita la barra de búsqueda
      "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Todos"]],
      "pageLength": 5,
      "destroy": true,
      "pagingType": 'full_numbers',
      "scrollCollapse": true,
      "responsive": true,
      "async": false,
      "processing": true,
      "ajax": {
          "url": "../controller/practicas/controlador_listar_historial_mod_prac_obra.php",
          "type": 'POST',
          "data": { id: id },
          "dataSrc": function(json) {
              console.log("Respuesta JSON:", json);
              return json.data;
          }
      },
      "dom": 'Bfrtip', 
      "buttons": [
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: "LISTA_DE_HISTORIAL_MODIFICACION_PRACTICAS_OBRAS",
          title: "LISTA DE HISTORIAL DE MOFDIFICACIÓN PRACTICAS - OBRAS",
          className: 'btn btn-success' 
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: "LISTA_DE_HISTORIAL_MODIFICACION_PRACTICAS_OBRAS",
          title: "LISTA DE HISTORIAL DE MOFDIFICACIÓN PRACTICAS - OBRAS",
          className: 'btn btn-danger'
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: "LISTA DE HISTORIAL DE MOFDIFICACIÓN PRACTICAS - OBRAS",
          className: 'btn btn-primary' 
        }
      ],
      "columns": [
          { "data": null, "render": function(data, type, row, meta) { return meta.row + 1; } }, 
          { "data": "USUARIO" },
          { "data": "cod_practica_nuevo" },
          { "data": "practica_nueva" },
          { "data": "valor_nuevo" },
          {"data":"tipo",
            render: function(data,type,row){
                    if(data=='MODIFICACIÓN INDIVIDUAL'){
                    return '<span class="badge bg-success">MODIFICACIÓN INDIVIDUAL</span>';
                    }else{
                    return '<span class="badge bg-dark">MODIFICACIÓN MASIVA</span>';
                    }
            }   
        },
          { "data": "fecha_formateada" }
      ],
      "language": {
          "emptyTable": "No se encontraron datos", // ✅ Mensaje cuando la tabla está vacía
          "zeroRecords": "No se encontraron resultados", // ✅ Mensaje para búsquedas sin coincidencias
          "info": "Mostrando _START_ a _END_ de _TOTAL_ registros",
          "infoEmpty": "Mostrando 0 a 0 de 0 registros",
          "infoFiltered": "(filtrado de _MAX_ registros en total)",
          "lengthMenu": "Mostrar _MENU_ registros",
          "loadingRecords": "Cargando...",
          "processing": "Procesando...",
          "search": "Buscar:",
          "paginate": {
              "first": "Primero",
              "last": "Último",
              "next": "Siguiente",
              "previous": "Anterior"
          }
      },
      "select": true
  });
}
function Modificar_Practicas() {
  let id = document.getElementById("txt_id_practica").value;
  let code = document.getElementById("txt_code_editar").value;
  let pract = document.getElementById("txt_practica_editar").value;
  let status = document.getElementById("txt_estatus").value;
  let idusu = document.getElementById("txtprincipalid").value;

  if (code.length == 0 || pract.length == 0) {
    return Swal.fire(
      "Mensaje de Advertencia",
      "Tiene campos vacios",
      "warning"
    );
  }

  // Verificar si el checkbox "Todas las obras sociales" está marcado
  let todasObras = document.getElementById("chk_todas_obras_sociales_editar").checked;

  // Solo validar si NO están marcadas todas las obras sociales
  if (!todasObras) {
    let count = $("#tabla_practica_obra_editar tbody#tbody_tabla_practica_obra_editar tr").length;
    if (count === 0) {
      return Swal.fire(
        "Mensaje de Advertencia",
        "Debe agregar al menos una obra social o seleccionar 'Todas las Obras Sociales'",
        "warning"
      );
    }
  }

  $.ajax({
    url: "../controller/practicas/controlador_modificar_practicas.php",
    type: "POST",
    data: {
      id: id,
      code: code,
      pract: pract,
      status: status,
      idusu: idusu
    },
  }).done(function (resp) {
    console.log("Respuesta modificar práctica:", resp);
    if (resp > 0) {
      if (todasObras) {
        // Si está marcado "Todas las obras sociales", registrar para todas
        console.log("Llamando a Modificar_Practica_Todas_ObrasEditar con ID:", id);
        Modificar_Practica_Todas_ObrasEditar(id, function(success) {
          if (success) {
            mostrarMensajeExitoYCerrar(code);
          } else {
            Swal.fire(
              "Mensaje de Error",
              "Error al registrar en todas las obras sociales",
              "error"
            );
          }
        });
      } else {
        // Si no, registrar solo las seleccionadas manualmente
        console.log("Llamando a Registrar_Detalle_practicasObraEditar con ID:", id);
        Registrar_Detalle_practicasObraEditar(id, function(success) {
          if (success) {
            mostrarMensajeExitoYCerrar(code);
          } else {
            Swal.fire(
              "Mensaje de Error",
              "Error al registrar las obras sociales seleccionadas",
              "error"
            );
          }
        });
      }
    } else {
      return Swal.fire(
        "Mensaje de Error",
        "No se completo la actualización",
        "error"
      );
    }
  }).fail(function() {
    Swal.fire(
      "Mensaje de Error",
      "Error de conexión al modificar la práctica",
      "error"
    );
  });

  // Función para mostrar mensaje de éxito y cerrar modal
  function mostrarMensajeExitoYCerrar(code) {
    Swal.fire(
      "Mensaje de Confirmación",
      "Se modificó la práctica con el Código N°: <b>" + code + "</b>",
      "success"
    ).then((value) => {
      tbl_practicas.ajax.reload();
      limpiarFormularioEditar();
      $("#modal_editar").modal("hide");
    });
  }
}

// FUNCIÓN MODIFICADA: Registrar práctica para todas las obras sociales
function Modificar_Practica_Todas_ObrasEditar(id, callback) {
  let code = document.getElementById("txt_code_editar").value;
  let pract = document.getElementById("txt_practica_editar").value;
  let valor = document.getElementById("txt_valor_editar").value;

  console.log("Ejecutando Modificar_Practica_Todas_ObrasEditar");
  console.log("ID:", id, "Código:", code, "Práctica:", pract, "Valor:", valor);

  if (valor.length == 0) {
    Swal.fire(
      "Mensaje de Advertencia", 
      "Debe ingresar el valor monetario", 
      "warning"
    );
    if (callback) callback(false);
    return;
  }

  $.ajax({
    url: "../controller/practicas/controlador_registro_todas_obras2.php",
    type: 'POST',
    data: {
      id: id,
      codigo: code,
      practica: pract,
      valor: valor
    }
  }).done(function (resp) {
    console.log("Respuesta todas las obras:", resp);
    if (resp > 0) {
      console.log("Práctica modificada para todas las obras sociales");
      if (callback) callback(true);
    } else {
      Swal.fire(
        "Mensaje De Advertencia", 
        "Error al registrar para todas las obras sociales", 
        "warning"
      );
      if (callback) callback(false);
    }
  }).fail(function() {
    console.error("Error AJAX en Modificar_Practica_Todas_ObrasEditar");
    Swal.fire(
      "Mensaje de Error",
      "Error de conexión al registrar en todas las obras sociales",
      "error"
    );
    if (callback) callback(false);
  });
}

// FUNCIÓN MODIFICADA: Registro detalle practicas - obras
function Registrar_Detalle_practicasObraEditar(id, callback) {
  let count = $("#tabla_practica_obra_editar tbody#tbody_tabla_practica_obra_editar tr").length;
  
  console.log("Ejecutando Registrar_Detalle_practicasObraEditar");
  console.log("Count de filas:", count);
  
  if (count === 0) {
    Swal.fire(
      "Mensaje de Advertencia", 
      "El detalle de las prácticas debe tener al menos un registro", 
      "warning"
    );
    if (callback) callback(false);
    return;
  }

  let arreglo_codigo = [];
  let arreglo_practica = [];
  let arreglo_valor = [];
  let arreglo_id = [];

  $("#tabla_practica_obra_editar tbody#tbody_tabla_practica_obra_editar tr").each(function () {
    arreglo_codigo.push($(this).find('td').eq(0).text().trim());
    arreglo_practica.push($(this).find('td').eq(1).text().trim());
    arreglo_valor.push($(this).find('td').eq(2).text().trim());
    arreglo_id.push($(this).find('td').eq(3).text().trim());
  });

  let codigo = arreglo_codigo.join(",");
  let practica = arreglo_practica.join(",");
  let valor = arreglo_valor.join(",");
  let idobra = arreglo_id.join(",");

  console.log("Datos a enviar:", {id, codigo, practica, valor, idobra});

  $.ajax({
    url: "../controller/practicas/controlador_detalle_practicas_obra2.php",
    type: 'POST',
    data: {
      id: id,
      codigo: codigo,
      practica: practica,
      valor: valor,
      idobra: idobra
    }
  }).done(function (resp) {
    console.log("Respuesta detalle obras:", resp);
    if (resp > 0) {
      console.log("Detalles registrados correctamente");
      if (callback) callback(true);
    } else {
      Swal.fire(
        "Mensaje De Advertencia", 
        "Lo sentimos, no se pudo completar el registro", 
        "warning"
      );
      if (callback) callback(false);
    }
  }).fail(function() {
    console.error("Error AJAX en Registrar_Detalle_practicasObraEditar");
    Swal.fire(
      "Mensaje de Error",
      "Error de conexión al registrar las obras sociales",
      "error"
    );
    if (callback) callback(false);
  });
}

// FUNCIÓN PARA MANEJAR EL TOGGLE DEL CHECKBOX
function toggleObrasSocialesEditar() {
  let checkbox = document.getElementById("chk_todas_obras_sociales_editar");
  let selectObras = document.getElementById("txt_obras_sociales_editar");
  let btnAgregar = document.querySelector("button[onclick='Agregar_practica_obraEditar()']");
  let inputValor = document.getElementById("txt_valor_editar");

  if (checkbox.checked) {
    // Si está marcado, deshabilitar select y botón agregar
    $(selectObras).prop('disabled', true);
    btnAgregar.disabled = true;
    btnAgregar.style.opacity = '0.5';
    
    // Limpiar la tabla
    $("#tabla_practica_obra_editar tbody#tbody_tabla_practica_obra_editar").empty();
    
    // Hacer obligatorio el valor monetario
    inputValor.required = true;
    inputValor.style.borderColor = '#dc3545';
    
    Swal.fire({
      icon: 'info',
      title: 'Modo: Todas las Obras Sociales',
      text: 'Se registrará esta práctica para todas las obras sociales disponibles.',
      timer: 3000,
      showConfirmButton: false
    });
  } else {
    // Si no está marcado, habilitar select y botón agregar
    $(selectObras).prop('disabled', false);
    btnAgregar.disabled = false;
    btnAgregar.style.opacity = '1';
    
    // Quitar obligatoriedad visual del valor
    inputValor.required = false;
    inputValor.style.borderColor = '';
  }
}

// VALIDACIÓN MODIFICADA
function verificaridEditar(id) {
  let existe = $("#tbody_tabla_practica_obra_editar td[for='id']").filter(function () {
    return $(this).text() === id;
  }).length > 0;
  
  return existe;
}

// AGREGAR PRÁCTICA-OBRA MODIFICADA
function Agregar_practica_obraEditar() {
  // Verificar si el checkbox está marcado
  let todasObras = document.getElementById("chk_todas_obras_sociales_editar").checked; // This line was already changed in the last edit.
  
  if (todasObras) {
    return Swal.fire(
      "Mensaje de Advertencia", 
      "No puede agregar obras individuales mientras esté seleccionado 'Todas las Obras Sociales'", 
      "warning"
    );
  }

  var cod = $("#txt_code_editar").val().trim(); 
  var prac = $("#txt_practica_editar").val().trim(); 
  var val = $("#txt_valor_editar").val().trim(); 
  var idobr = $("#txt_obras_sociales_editar").val().trim(); 
  var obr = $("#txt_obras_sociales_editar option:selected").text().trim();

  if (cod.length == 0 || prac.length == 0 || val.length == 0 || idobr.length == 0) {
    return Swal.fire("Mensaje de Advertencia", "Complete todos los campos obligatorios", "warning");
  }

  if (verificaridEditar(idobr)) {
    return Swal.fire("Mensaje de Advertencia", "La obra social asociada a la práctica ya fue agregado a la tabla", "warning");
  }

  var datos_agregar = `
    <tr>
      <td>${cod}</td>
      <td>${prac}</td>
      <td>${val}</td>
      <td for="id">${idobr}</td>
      <td>${obr}</td>
      <td><button class='btn btn-danger' onclick='removeEditar(this)'><i class='fas fa-trash'></i></button></td>
    </tr>`;

  $("#tbody_tabla_practica_obra_editar").append(datos_agregar); 
  $("#txt_obras_sociales_editar").val("").trigger("change");
  $("#txt_valor_editar").val("");
}

// BORRAR REGISTRO (sin cambios)
function removeEditar(t) {
  $(t).closest("tr").remove();
}



// FUNCIÓN PARA LIMPIAR EL FORMULARIO
function limpiarFormularioEditar() {
  document.getElementById('txt_code_editar').value = "";
  document.getElementById('txt_practica_editar').value = "";
  document.getElementById('txt_valor_editar').value = "";
  document.getElementById('txt_obras_sociales_editar').checked = false;
  
  // Rehabilitar controles
  $("#txt_obras_sociales_editar").prop('disabled', false).val("").trigger("change");
  let btnAgregar = document.querySelector("button[onclick='Agregar_practica_obraEditar()']");
  btnAgregar.disabled = false;
  btnAgregar.style.opacity = '1';
  
  // Limpiar tabla
  $("#tabla_practica_obra_editar tbody#tbody_tabla_practica_obra_editar").empty();
}
