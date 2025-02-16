var tbl_area;
function listar_area(){
  tbl_area = $("#tabla_area").DataTable({
      "ordering":true,   
      "bLengthChange":true,
      "searching": { "regex": false },
      "lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
      "pageLength": 10,
      "destroy":true,
      pagingType: 'full_numbers',
      scrollCollapse: true,
      responsive: true,
      "async": false ,
      "processing": true,
      "ajax":{
          "url":"../controller/area/controlador_listar_area.php",
          type:'POST'
      },
      dom: 'Bfrtip', 
      buttons: [ 
        {
          extend: 'excelHtml5',
          text: '<i class="fas fa-file-excel"></i> Excel',
          titleAttr: 'Exportar a Excel',
          filename: function() {
            return "LISTA DE ÁREAS";
          },
          title: function() {
            return "LISTA DE ÁREAS";
          },
          className: 'btn btn-excel',
          exportOptions: {
            columns: [ 1, 2, 3, 4, 5, 6] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'pdfHtml5',
          text: '<i class="fas fa-file-pdf"></i> PDF',
          titleAttr: 'Exportar a PDF',
          filename: function() {
            return "LISTA DE ÁREAS";
          },
          title: function() {
            return "LISTA DE ÁREAS";
          },
          className: 'btn btn-pdf',
          exportOptions: {
            columns: [ 1, 2, 3, 4, 5, 6] // Exportar solo hasta la columna 'estado'
          }
        },
        {
          extend: 'print',
          text: '<i class="fa fa-print"></i> Imprimir',
          titleAttr: 'Imprimir',
          title: function() {
            return "LISTA DE ÁREAS";
          },
          className: 'btn btn-print',
          exportOptions: {
            columns: [ 1, 2, 3, 4, 5, 6] // Exportar solo hasta la columna 'estado'
          }
        }
      ],
      
      "columns":[
        {"defaultContent":""},
        {"data":"nombre"},
        {"data":"descripcion"},
        {"data":"fecha_formateada"},
        {"data":"fecha_formateada2"},
        {"data":"USUARIO"},

        {"data":"estado_area",
            render: function(data,type,row){
                    if(data=='ACTIVO'){
                    return '<span class="badge bg-success">ACTIVO</span>';
                    }else{
                    return '<span class="badge bg-danger">INACTIVO</span>';
                    }
            }   
        },
        {
          "defaultContent": "<button class='editar btn btn-primary btn-sm' title='Editar datos de área'><i class='fa fa-edit'></i> Editar</button> <button class='eliminar btn btn-danger btn-sm' title='Eliminar datos de área'><i class='fa fa-trash'></i> Eliminar</button>"
        }
            ],

    "language":idioma_espanol,
    select: true
  });

  tbl_area.on('draw.td', function(){
    var PageInfo = $("#tabla_area").DataTable().page.info();
    tbl_area.column(0, {page: 'current'}).nodes().each(function(cell, i){
      cell.innerHTML = i + 1 + PageInfo.start;
    });
  });
}

$('#tabla_area').on('click','.editar',function(){
  var data = tbl_area.row($(this).parents('tr')).data();

  if(tbl_area.row(this).child.isShown()){
      var data = tbl_area.row(this).data();
  }
  $("#modal_editar").modal('show');
  document.getElementById('txt_idarea').value=data.id_area;
  document.getElementById('txt_area_editar').value=data.nombre;
  document.getElementById('txt_descripcion_editar').value=data.descripcion;
  document.getElementById('txt_estatus').value=data.estado_area;
})

function AbrirRegistro(){
  $("#modal_registro").modal({backdrop:'static',keyboard:false})
  $("#modal_registro").modal('show');
}

function Registrar_Area(){
  let area = document.getElementById('txt_area').value;
  let descripcion = document.getElementById('txt_descripcion').value;
  let idusu = document.getElementById('txtprincipalid').value;

  if(area.length==0){
      return Swal.fire("Mensaje de Advertencia","Ingrese nombre del área es obligatorio","warning");
  }
  $.ajax({
    "url":"../controller/area/controlador_registro_area.php",
    type:'POST',
    data:{
      area:area,
      descripcion:descripcion,
      idusu:idusu
    }
  }).done(function(resp){
    if(resp>0){
      if(resp==1){
        Swal.fire("Mensaje de Confirmación","Nueva Área registrada con el nombre: "+area,"success").then((value)=>{
          tbl_area.ajax.reload();
          document.getElementById('txt_area').value="";
          document.getElementById('txt_descripcion').value="";
        $("#modal_registro").modal('hide');
        });
      }else{
        Swal.fire("Mensaje de Advertencia","El área que desea registrar ya se encuentra en la base de datos","warning");
      }
    }else{
      return Swal.fire("Mensaje de Error","No se completo el registro","error");

    }
  })
}
function Modificar_Area(){
  let id = document.getElementById('txt_idarea').value;
  let area = document.getElementById('txt_area_editar').value;
  let descripcion = document.getElementById('txt_descripcion_editar').value;
  let esta = document.getElementById('txt_estatus').value;
  let idusu = document.getElementById('txtprincipalid').value;

  if(area.length==0 || id.length==0){
      return Swal.fire("Mensaje de Advertencia","Tiene campos vacios","warning");
  }
  $.ajax({
    "url":"../controller/area/controlador_modificar_area.php",
    type:'POST',
    data:{
      id:id,
      area:area,
      descripcion:descripcion,
      esta:esta,
      idusu:idusu
    }
  }).done(function(resp){
    if(resp>0){
      if(resp==1){
        Swal.fire("Mensaje de Confirmación","Datos actualizados del área: "+area,"success").then((value)=>{
          tbl_area.ajax.reload();
        $("#modal_editar").modal('hide');
        });
      }else{
        Swal.fire("Mensaje de Advertencia","El área ingresada ya se encuentra en la base de datos","warning");
      }
    }else{
      return Swal.fire("Mensaje de Error","No se completo la actualización","error");

    }
  })
}

//ELIMINAR AREAS
function Eliminar_area(id){
  $.ajax({
    "url":"../controller/area/controlador_eliminar_area.php",
    type:'POST',
    data:{
      id:id
    }
  }).done(function(resp){
    if(resp>0){
        Swal.fire("Mensaje de Confirmación","Se elimino el area con exito","success").then((value)=>{
          tbl_area.ajax.reload();

        });
    }else{
      return Swal.fire("Mensaje de Advetencia","No se puede eliminar esta área por que esta siendo utilizado en el módulo de Prácticas, verifique por favor","warning");

    }
  })
}

//ENVIANDO AL BOTON DELETE
$('#tabla_area').on('click','.eliminar',function(){
  var data = tbl_area.row($(this).parents('tr')).data();

  if(tbl_area.row(this).child.isShown()){
      var data = tbl_area.row(this).data();
  }
  Swal.fire({
    title: 'Desea eliminar el área con el nombre: '+data.nombre+'?',
    text: "Una vez aceptado el área sera eliminado!!!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Si, Eliminar'
  }).then((result) => {
    if (result.isConfirmed) {
      Eliminar_area(data.id_area);
    }
  })
})