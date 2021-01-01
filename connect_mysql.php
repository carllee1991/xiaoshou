<?php
  $server="localhost:3306";
  $user="root";
  $password="";
  $database="xiaoshou";

  $mysqli = mysqli_connect($server,$user,$password, $database);
  if(!$mysqli){
    echo "Error: Unable to connect to MySQL." . PHP_EOL . "<br>";
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL . "<br>";
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL . "<br>";
    exit;
  }
?>
