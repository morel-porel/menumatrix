<?php
session_start();  

$con = mysqli_connect("localhost", "root", "", "menumatrix");

if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

echo "<script>console.log('Session logged_in: " . (isset($_SESSION['logged_in']) ? $_SESSION['logged_in'] : 'not set') . "');</script>";
echo "<script>console.log('Session user_type: " . (isset($_SESSION['user_type']) ? $_SESSION['user_type'] : 'not set') . "');</script>";
echo "<script>console.log('Session user_id: " . (isset($_SESSION['user_id']) ? $_SESSION['user_id'] : 'not set') . "');</script>";

if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true || $_SESSION['user_type'] !== 'employee' || !isset($_SESSION['user_id']) || empty($_SESSION['user_id'])) {
    die("<script>alert('Unauthorized or Employee ID not found in session. Please log in again.'); window.location.href='login.html';</script>");
}

$employee_id = $_SESSION['user_id'];

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $attendanceTimeIn = $_POST['attendanceTimeIn'];
    $attendanceTimeOut = $_POST['attendanceTimeOut'];
    $attendanceHoursWorked = $_POST['attendanceHoursWorked'];
    $attendanceDate = $_POST['attendanceDate'];

    if (empty($attendanceTimeIn) || empty($attendanceTimeOut) || empty($attendanceHoursWorked) || empty($attendanceDate)) {
        echo "<script>alert('All attendance details are required.'); window.history.back();</script>";
        exit();
    }

    $sql = "INSERT INTO attendance (employee_id, punch_in_time, punch_out_time, shift_date, hours_worked) VALUES (?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($con, $sql);

    if ($stmt) {
        mysqli_stmt_bind_param($stmt, "isssi", $employee_id, $attendanceTimeIn, $attendanceTimeOut, $attendanceDate, $attendanceHoursWorked);

        if (mysqli_stmt_execute($stmt)) { 
            echo "<script>alert('Attendance successfully added!'); window.location.href = 'employee_index.html';</script>";
        } else {
            echo "<script>alert('Error adding attendance: " . mysqli_error($con) . "'); window.history.back();</script>";
        }

        mysqli_stmt_close($stmt);
    } else {
        echo "<script>alert('Database error: " . mysqli_error($con) . "'); window.history.back();</script>";
    }

    mysqli_close($con);
}
?>