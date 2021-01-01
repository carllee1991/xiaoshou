<?php
  $server="localhost:3306";
  $user="root";
  $password="";
  $database="xiaoshou";
  printf("<a href='login.html'>登陆</a> <a href='signup.html'>注册</a><br>");

  $mysqli = mysqli_connect($server,$user,$password, $database);
  if(!$mysqli){
    echo "Error: Unable to connect to MySQL." . PHP_EOL . "<br>";
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL . "<br>";
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL . "<br>";
    exit;
  }

  // $sql="SELECT * FROM Accounts;";
  // if ($result = $mysqli->query($sql, MYSQLI_USE_RESULT)) {
  //   while($row = mysqli_fetch_array($result)){
  //     print_r($row);
  //   }
  //   $result->close();
  // }
?>
