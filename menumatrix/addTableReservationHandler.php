<?php
$con = mysqli_connect("localhost", "root", "", "menumatrix");

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $tableNumber = $_POST['tableNumber'];
    $dateTime = $_POST['dateTime'];
    $customerId = trim($_POST['customerId']); 

    if (empty($tableNumber) || empty($dateTime) || empty($customerId)) {
        echo "<script>alert('Table Number, Date/Time, and Customer ID are required.'); window.history.back();</script>";
        exit();
    }

    $checkCustomerQuery = "SELECT customer_id FROM customer WHERE customer_id = ?";
    $checkCustomerStmt = mysqli_prepare($con, $checkCustomerQuery);

    if ($checkCustomerStmt) {
        mysqli_stmt_bind_param($checkCustomerStmt, "i", $customerId);
        mysqli_stmt_execute($checkCustomerStmt);
        mysqli_stmt_store_result($checkCustomerStmt);

        if (mysqli_stmt_num_rows($checkCustomerStmt) == 0) {
            echo "<script>alert('Error: Customer ID does not exist.'); window.history.back();</script>";
            mysqli_stmt_close($checkCustomerStmt);
            mysqli_close($con);
            exit();
        }
        mysqli_stmt_close($checkCustomerStmt);
    } else {
        echo "<script>alert('Database error during customer ID check.'); window.history.back();</script>";
        mysqli_close($con);
        exit();
    }

    $status = "occupied";

    $sql = "INSERT INTO tables (table_number, date_time, status, customer_id) VALUES (?, ?, ?, ?)";
    $stmt = mysqli_prepare($con, $sql);

    if ($stmt) {
        mysqli_stmt_bind_param($stmt, "sssi", $tableNumber, $dateTime, $status, $customerId);

        if (mysqli_stmt_execute($stmt)) {
            echo "<script>alert('Table reservation successfully added!'); window.location.href = 'index.html';</script>";
        } else {
            echo "<script>alert('Error adding table reservation: " . mysqli_error($con) . "'); window.history.back();</script>";
        }

        mysqli_stmt_close($stmt);
    } else {
        echo "<script>alert('Database error during reservation.'); window.history.back();</script>";
    }

    mysqli_close($con);
}
?>