<?php
session_start();

$con = mysqli_connect("localhost", "root", "", "menumatrix");

if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    echo "<script>alert('You must be logged in'); window.location.href='login.html';</script>";
    exit();
}

$employee_id = $_SESSION['user_id'];

if (isset($_POST['btnAddExpense'])) {
    $expense_type = trim($_POST['expense_type']);
    $amount = $_POST['amount'];
    $date = trim($_POST['dateAdded']); 
    $category = trim($_POST['category']);

    $errors = [];
    if (empty($expense_type)) $errors[] = "Expense type is required";
    if (!is_numeric($amount) || $amount <= 0) $errors[] = "Amount must be a positive number";
    if (empty($date)) $errors[] = "Date is required";
    if (empty($category)) $errors[] = "Category is required";
    
    if (!empty($date) && !preg_match('/^\d{2}\/\d{2}\/\d{4}$/', $date)) {
        $errors[] = "Date must be in MM/DD/YYYY format (e.g. 12/31/2023)";
    }

    if (!empty($errors)) {
        echo "<script>alert('".implode("\\n", $errors)."'); window.location.href='totalExpenses.html';</script>";
        exit();
    }

    $query = "INSERT INTO totalexpenses (expense_type, amount, date, category) 
             VALUES ('$expense_type', $amount, '$date', '$category')";
    $result = mysqli_query($con, $query);
    
    if (!$result) {
        echo "<script>alert('Failed to add expense: " . mysqli_error($con) . "'); window.location.href='totalExpenses.html';</script>";
        exit();
    }
    
    echo "<script>alert('Expense added successfully!'); window.location.href='totalExpenses.html';</script>";
    exit();
}

mysqli_close($con);
?>