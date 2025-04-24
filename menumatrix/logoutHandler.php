<?php
session_start();


if (isset($_POST['btnYes'])) {
    
    $_SESSION = array();
    
    if (ini_get("session.use_cookies")) {
        $params = session_get_cookie_params();
        setcookie(session_name(), '', time() - 42000,
            $params["path"], $params["domain"],
            $params["secure"], $params["httponly"]
        );
    }
    
    
    session_destroy();
    
    setcookie('loggedIn', '', time() - 3600, "/");
    setcookie('userName', '', time() - 3600, "/");
    
    
    header("Location: index.html");
    
} else {
    header("Location: index.html");
    
}
?>