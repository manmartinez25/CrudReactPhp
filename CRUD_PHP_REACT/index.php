<?php
/*En el presente archivo se hizo la importación del archivo donde se contienen los métodos del CRUD y los datos para conectar
y desconectar la base de datos*/
include 'BD/bd.php';

header('Access-Control-Allow-Origin: *');

/*El siguiente corresponde al método GET en el cual se define el query para consultar los objetos de la base de datos,
adicionalmente el resultado se especifica para ser presentado en formato JSON*/
if($_SERVER['REQUEST_METHOD']=='GET'){
    if(isset($_GET['id'])){
        $query="SELECT * from producto WHERE id=".$_GET['id'];
        $resultado=metodoGet($query);
        echo json_encode($resultado->fetch(PDO::FETCH_ASSOC));
    }else{
        $query="SELECT * from producto";
        $resultado=metodoGet($query);
        echo json_encode($resultado->fetchAll());
    }
    header("HTTP/1.1 200 OK");
    exit();
}

/*A través del presente método se envia información por medio del llamado al método POST hacia la base de datos para añadir productos*/
if($_POST['METHOD']=='POST'){
    unset($_POST['METHOD']);
    $nombreProd = $_POST['nombre_prod'];
    $tipoProd = $_POST['tipo_prod'];
    $descripcion = $_POST['descripcion'];
    $precio = $_POST['precio'];
    $stock = $_POST['stock'];
    $marca = $_POST['marca'];
    $query = "INSERT INTO producto (nombre_prod, tipo_prod, descripcion, precio, stock, marca) VALUES ('$nombreProd','$tipoProd','$descripcion','$precio','$stock','$marca')";
    $queryAuroIncrement = "SELECT MAX(id) as id from producto";
    $resultado = metodoPost($query,$queryAuroIncrement);
    echo json_encode($resultado);
    header("HTTP/1.1 200 OK");
    exit();
}

/*A través del presente método se hace el envío de información a traves del llamado al método PUT para modificar los campos 
de un producto que ya se encuentra registrado en la base de datos*/
if($_POST['METHOD']=='PUT'){
    unset($_POST['METHOD']);
    $id = $_GET['id'];
    $nombreProd = $_POST['nombre_prod'];
    $tipoProd = $_POST['tipo_prod'];
    $descripcion = $_POST['descripcion'];
    $precio = $_POST['precio'];
    $stock = $_POST['stock'];
    $marca = $_POST['marca'];
    $query = "UPDATE producto SET nombre_prod='$nombreProd',tipo_prod='$tipoProd', descripcion='$descripcion', precio='$precio', stock='$stock', marca='$marca' WHERE id='$id'";
    $resultado = metodoPut($query);
    echo json_encode($resultado);
    header("HTTP/1.1 200 OK");
    exit();
}

/*Finalmente, a través del presente método se hace el llamado al método DELETE para que  mediante la obtención del objeto 
referenciado por su id, se realice la petición para eliminar este mismo*/
if($_POST['METHOD']=='DELETE'){
    unset($_POST['METHOD']);
    $id = $_GET['id'];
    $query = "DELETE FROM producto WHERE id='$id'";
    $resultado = metodoDelete($query);
    echo json_encode($resultado);
    header("HTTP/1.1 200 OK");
    exit();
}

header("HTTP/1.1 400 Bad Request");
?>