<?php 
    header("Content-Type: text/html; charset=utf8");

    if(!isset($_POST['submit'])){
        exit("错误执行");
    }

    $id=$_POST['id'];
    $email=$_POST['email'];
    $password=$_POST['password'];

    include('connect_mysql.php');
    $sql = "INSERT INTO Accounts (AccountID, AccountEmail, AccountPassword, AccountCreateDate, AccountModifyDate) VALUES ('$id', '$email', '$password', now(), now())";
    $reslut=mysqli_query($mysqli, $sql);
    
    if (!$reslut){
        die('Error: ' . mysqli_error($mysqli));
    }else{
        echo "注册成功";
    }
    mysqli_close($mysqli);
?>
