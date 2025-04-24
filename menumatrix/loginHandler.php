<?php
session_start();

$con = mysqli_connect("localhost", "root", "", "menumatrix");

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if (isset($_POST['btnLogin'])) {
    $userType = $_POST['userType'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    
    if (empty($userType) || empty($email) || empty($password)) {
        echo "<script>alert('All fields are required'); window.history.back();</script>";
        exit();
    }

    if ($userType == 'customer') {
        $table = 'customer';
        $field = 'email';
        $idfield = 'customer_id'; 
    } else {
        $table = 'employee';
        $field = 'name'; 
        $idfield = 'employee_id';
    }

    $sql = "SELECT * FROM $table WHERE $field = '$email' AND password = '$password'";
    $result = mysqli_query($con, $sql);

    if (mysqli_num_rows($result) > 0) {
        $user = mysqli_fetch_assoc($result);
        
        $_SESSION['logged_in'] = true;
        $_SESSION['user_type'] = $userType;
        $_SESSION['user_name'] = $user['name'];
        $_SESSION['user_id'] = $user[$idfield];


        setcookie('loggedIn', 'true', time() + (86400 * 30), "/");
        setcookie('userName', urlencode($user['name']), time() + (86400 * 30), "/");
        setcookie($idfield, $user[$idfield], time() + (86400 * 30), "/"); // Set employee or customer ID

        if ($userType == 'customer') {
            header("Location: index.html");
        } else {
            header("Location: employee_index.html");
        }
        exit();
    } else {
        echo "<script>alert('Invalid email or password'); window.history.back();</script>";
        exit();
    }
}
?>
