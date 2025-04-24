<?php
    $con=mysqli_connect("localhost","root","","menumatrix");
	
	
	if(isset($_POST['btnCreateAccount'])){
		$usertype =$_POST['userType'];
		$fname =$_POST['InputFirstName'];
        $lname =$_POST['InputLastName'];
        $phone =$_POST['InputPhone'];
        $email =$_POST['InputEmail'];
		$pwd =$_POST['InputPassword'];
        $conpwd =$_POST['ConfirmPassword'];

		

		if (empty($fname) || empty($lname) || empty($phone) || empty($email) || empty($pwd) || empty($conpwd)) {
			echo "<script> alert('All fields are required.');</script>";
		}
		
		if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
			echo "<script> alert('Invalid email format.');</script>";
		}

		if($pwd != $conpwd){
			echo "<script> alert('Passwords do not match.');</script>";
		}

		if(empty($usertype)){
			echo "<script> alert('Select account type.');</script>";
		}
		
		if ($usertype === 'customer') {
			$phone = $_POST['InputPhone'];
			$email = $_POST['InputEmail'];
			
			if (empty($phone) || empty($email)) {
				echo"<script>alert('All customer fields are required.');</script>";
			}
			
			$sqlCheck = "select * from customer WHERE email='$email'";
			$check = mysqli_query($con, $sqlCheck);
			if (mysqli_num_rows($check) > 0) {
				echo"<script>alert('Email already registered.');</script>";
			}
			
			$sql = "insert into customer (name, phone, email, password) 
					values ('$fname $lname', '$phone', '$email', '$pwd')";
			
		} elseif ($usertype === 'employee') {

			
	
			$role = $_POST['InputRole'];
			$shiftStart = $_POST['InputShiftStart'];
			$shiftEnd = $_POST['InputShiftEnd'];
			
			if (empty($role) || empty($shiftStart) || empty($shiftEnd)) {
				echo"<script>alert('All employee fields are required.');</script>";
			}

			$salary = 0;
			switch($role) {
				case 'chef':
					$salary = 30000;  
					break;
				case 'manager':
					$salary = 35000;  
					break;
				case 'supervisor':
					$salary = 25000;  
					break;
				case 'crewMember':
					$salary = 18000;  
					break;
				case 'diningStaff':
					$salary = 15000; 
					break;
				case 'janitor':
					$salary = 12000; 
					break;
				case 'delivery':
					$salary = 15000;  
					break;
				default:
					$salary = 0;  
			}
			
			$sql = "insert into employee (name, password, role, shift_time_in, shift_time_out, salary) 
					values ('$fname $lname', '$pwd', '$role', '$shiftStart', '$shiftEnd', $salary)";
		}
		
		
		if(mysqli_query($con, $sql)) {
			echo "<script>alert('Registration successful!');</script>";
			header('Location: login.html');
		} 

		
	}
?>