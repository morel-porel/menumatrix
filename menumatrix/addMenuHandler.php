<?php
    $con = mysqli_connect("localhost", "root", "", "menumatrix");

    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $name = $_POST['menuName'];
        $description = $_POST['menuDescription'];
        $price = $_POST['menuPrice'];
        $category = $_POST['menuCategory'];
        $availability = isset($_POST['menuAvailability']) ? 1 : 0;

        if (empty($name) || empty($price) || empty($category)) {
            echo "<script>alert('Name, Price, and Category are required.'); window.history.back();</script>";
            exit();
        }

        $sql = "INSERT INTO menuitem (name, description, price, category, availability) VALUES (?, ?, ?, ?, ?)";
        $stmt = mysqli_prepare($con, $sql);

        if ($stmt) {
            mysqli_stmt_bind_param($stmt, "ssdsi", $name, $description, $price, $category, $availability);

            if (mysqli_stmt_execute($stmt)) {
                echo "<script>alert('Menu item successfully added!'); window.location.href = 'menu.html';</script>";
            } else {
                echo "<script>alert('Error adding menu item.'); window.history.back();</script>";
            }

            mysqli_stmt_close($stmt);
        } else {
            echo "<script>alert('Database error.'); window.history.back();</script>";
        }

        mysqli_close($con);
    }
?>
