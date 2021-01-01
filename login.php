<?PHP
    header("Content-Type: text/html; charset=utf8");
    if(!isset($_POST["submit"])){
        exit("错误执行");
    }

    include('connect_mysql.php');
    $id = $_POST['id'];
    $password = $_POST['password'];

    if ($id && $password){
        printf($id, "<br>");
        $sql = "SELECT * FROM Accounts WHERE AccountID = '$id' and AccountPassword='$password'";
        $result = mysqli_query($mysqli, $sql);
        $rows=mysqli_num_rows($result);
        if($rows){
            header("refresh:0;url=index.php");
            exit;
        }else{
            echo "用户名或密码错误";
            echo "<script>
                    setTimeout(function(){window.location.href='login.html';},10000);
                  </script>";
        }
    }else{
        echo "表单填写不完整";
        echo "<script>
                setTimeout(function(){window.location.href='login.html';},10000);
              </script>";
    }
    mysqli_close($mysqli);
?>