<?php

/*Inicialmente se generaron las funciones para conectar y desconectar la base de datos, por lo tanto, se suministran los datos 
de conexión haciendo uso del método de PDO de PHP para conectar*/
$pdo = null;
$host = "localhost";
$user = "root";
$password = "";
$bdName = "proyectoinventarios";

function conectar(){
    try{
        $GLOBALS['pdo'] = new PDO("mysql:host=".$GLOBALS['host'].";dbname=".$GLOBALS['bdName']."",$GLOBALS['user'],$GLOBALS['password']);
        $GLOBALS['pdo']->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }catch (PDOException $e){
        print "Error!: No se pudo conectar a la bd".$bdName."<br/>";
        print "\nError!:".$e."<br/>";
        die();
    }
}   

function desconectar(){
    $GLOBALS['pdo'] = null;
}

/*A continuación fueron definidios los métodos del CRUD los cuales reciben los query desde el archivo index,
para generar las peticiones hacia la base de datos*/
function metodoGet ($query){
    try{
        conectar();
        $statement = $GLOBALS['pdo']->prepare($query);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        desconectar();
        return $statement;
    }catch (Exception $e){
        die("Error: ".$e);
    }
}

function metodoPost ($query, $queryAutoIncrement){
    try{
        conectar();
        $statement = $GLOBALS['pdo']->prepare($query);
        $statement->execute();
        $idAutoIncrement = metodoGet($queryAutoIncrement)->fetch(PDO::FETCH_ASSOC);
        $resultado = array_merge($idAutoIncrement, $_POST);
        $statement->closeCursor();
        desconectar();
        return $resultado;
    }catch(Exception $e){
        die("Error: ".$e);
    }
}

function metodoPut ($query){
    try{
        conectar();
        $statement = $GLOBALS['pdo']->prepare($query);
        $statement->execute();
        $resultado = array_merge($_GET, $_POST);
        $statement->closeCursor();
        desconectar();
        return $resultado;
    }catch(Exception $e){
        die("Error: ".$e);
    }
}

function metodoDelete ($query){
    try{
        conectar();
        $statement = $GLOBALS['pdo']->prepare($query);
        $statement->execute();
        $statement->closeCursor();
        desconectar();
        return $_GET['id'];
    }catch(Exception $e){
        die("Error: ".$e);
    }
}


?>