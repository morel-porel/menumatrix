<?php
    $con = mysqli_connect("localhost", "root", "", "menumatrix");

    if (!$con) {
        die("Connection failed: " . mysqli_connect_error());
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $name = $_POST['itemName'];
        $tags = $_POST['itemTags'];
        $status = $_POST['itemStatus'];
        $acq_date = $_POST['acquisitionDate'];
        $exp_date = $_POST['expirationDate'];

        // Basic validation
        if (empty($name) || empty($status) || empty($acq_date)) {
            echo "<script>alert('Item Name, Status, and Acquisition Date are required.'); window.history.back();</script>";
            exit();
        }

        // Prepare SQL insert
        $sql = "INSERT INTO inventory (name, tags, status, exp_date, `acquisition date`) VALUES (?, ?, ?, ?, ?)";
        $stmt = mysqli_prepare($con, $sql);

        if ($stmt) {
            mysqli_stmt_bind_param($stmt, "sssss", $name, $tags, $status, $exp_date, $acq_date);

            if (mysqli_stmt_execute($stmt)) {
                echo "<script>alert('Item successfully added to inventory!'); window.location.href = 'inventory.html';</script>";
            } else {
                echo "<script>alert('Error adding item.'); window.history.back();</script>";
            }

            mysqli_stmt_close($stmt);
        } else {
            echo "<script>alert('Database error.'); window.history.back();</script>";
        }

        mysqli_close($con);
    }
?>
