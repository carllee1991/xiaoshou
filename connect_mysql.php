<?php
session_start();
  $server="localhost:3306";
  $user="root";
  $password="";
  $database="xiaoshou";
  try {
    $pdo=new PDO("mysql:host=$server;dbname=$database", $user, $password);
  } catch (PDOException $e) {
  	print "Error!: " . $e->getMessage() . "<br/>";
	die();
  }
?>
