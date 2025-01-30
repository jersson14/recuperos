<?php
require_once  __DIR__ . '/../vendor/autoload.php';
require_once '../conexion.php';
$codigo = $_GET['codigo'];
$query ="SELECT
empresa.empresa_id, 
empresa.emp_razon, 
empresa.emp_email, 
empresa.emp_cod, 
empresa.emp_telefono, 
empresa.emp_direccion, 
empresa.emp_logo
FROM
empresa";
date_default_timezone_set('America/Lima');
$html="";
$resultado = $mysqli->query($query);
$query2="SELECT
documento.documento_id, 
documento.doc_dniremitente, 
CONCAT_WS(' ',documento.doc_nombreremitente,documento.doc_apepatremitente,documento.doc_apematremitente) AS REMITENTE, 
documento.doc_nombreremitente, 
documento.doc_apepatremitente, 
documento.doc_apematremitente, 
documento.tipodocumento_id, 
tipo_documento.tipodo_descripcion, 
documento.doc_estatus, 
documento.doc_nrodocumento, 
documento.doc_celularremitente, 
documento.doc_emailremitente, 
documento.doc_direccionremitente, 
documento.doc_representacion, 
documento.doc_ruc, 
documento.doc_empresa, 
documento.doc_folio, 
documento.doc_archivo, 
documento.doc_asunto, 
documento.doc_fecharegistro,
documento.area_origen, 
documento.area_destino, 
documento.area_id,
documento.dias_pasados,
dias_respuesta,
acciones,
doc_observaciones,
dias_respuesta,
origen.area_nombre as origen, 
destino.area_nombre as destino
FROM
documento
INNER JOIN
tipo_documento
ON 
    documento.tipodocumento_id = tipo_documento.tipodocumento_id
INNER JOIN
area AS origen
ON 
    documento.area_origen = origen.area_cod
INNER JOIN
area AS destino
ON 
    documento.area_destino = destino.area_cod
WHERE
documento.documento_id = '".$codigo."'";
$resultado2 = $mysqli->query($query2);
$razon      = "";
$telefono   = "";
$email      = "";
$codigo     = "";
$logo       = "";
$direccion  = "";
while($row2 = $resultado->fetch_assoc()){
    $razon      = $row2['emp_razon'];
    $cod_cel    = $row2['emp_cod'];
    $telefono   = $row2['emp_telefono'];
    $email      = utf8_encode($row2['emp_email']);
    $logo       = $row2['emp_logo'];
    $direccion  = $row2['emp_direccion'];

}
while($row = $resultado2->fetch_assoc()){
    $html.='
    <style>
        @page{
            margin: 10mm;
            margin-header: 0mm;
            margin-footer: 0mm;
            odd-footer-name: html_myFooter1;
        }
    </style>
    <table>
        <tr>
            <td align="center">
             <img src="../../../img/diressa.jpg" style="border: 1.5px solid blue; padding: 5px;border-radius: 25px;" width="100%" align="center" >
            </td>
        </tr>
    </table>
    <hr>
    <line x1="0" y1="0" x2="100" y2="0" style="stroke: black; stroke-width: 2;" />
    <span style="font-size:12px"><b><br>Código de Seguimiento:
    
    </b><strong><em style="color:blue"> '.$row['documento_id'].'</em></strong>
    </span><br>
    <span style="font-size:12px"><b><br>DNI Remitente:
    </b><strong><em style="color:blue"> '.$row['doc_dniremitente'].'</em></strong>
    </span><br>
    <hr>
    <line x1="0" y1="0" x2="100" y2="0" style="stroke: black; stroke-width: 2;" />
    <span style="font-size:12px"><b><br>Datos Remitente:<br>
    </b> '.utf8_encode($row['REMITENTE']).'
    </span><br>
    <span style="font-size:12px"><b><br>Oficina de destino:
    </b> '.$row['origen'].'
    </span><br>
    <span style="font-size:12px"><b><br>Nro. de Registro:
    </b> '.$row['doc_nrodocumento'].'
    </span><br>
    <span style="font-size:12px"><b><br>Fecha - Hora:
    </b> '.date('d/m/Y - H:i:s', strtotime($row['doc_fecharegistro'])).'
    </span><br>
    <span style="font-size:12px"><b><br>Tipo Documento:
    </b> '.utf8_encode($row['tipodo_descripcion']).'
    </span><br>
    <span style="font-size:12px"><b><br>Asunto:
    </b> '.utf8_encode($row['doc_asunto']).'
    </span><br>
    <hr>
    <line x1="0" y1="0" x2="100" y2="0" style="stroke: black; stroke-width: 2;" />
            <table width="100%" cellpadding="8">
            <tr>
                <td class="barcodecell" align="center">
                    <barcode code="http://localhost:8080/SISTRAMITEDOC/seguimiento.php" type="QR"  class="barcode" size="1.2" disableborder="1"/>
                </td>
            </tr>
        </table>
        <hr>
        <line x1="0" y1="0" x2="100" y2="0" style="stroke: black; stroke-width: 2;" />
    <htmlpagefooter name="myFooter1">
        <table width="100%">
            <tr>
                <td style="text-align:center; font-size:12" width="50%"><b>Celular:</b>
                '.$telefono.'
                </td>
                <td style="text-align:center; font-size:12" width="50%"><b>Email:</b>
                '.utf8_encode($email).'
                </td>
            </tr>
        </table>
        <table>
        <tr>
            <td style="text-align:center; font-size:10" width="50%">
            '.utf8_encode($direccion).'
            </td>
        </tr>
    </table>
    </htmlpagefooter>
    ';
}
$mpdf = new \Mpdf\Mpdf(
    ['mode' => 'UTF-8','format' => [80,175]]
);
$mpdf->WriteHTML($html);
$mpdf->Output();
?>