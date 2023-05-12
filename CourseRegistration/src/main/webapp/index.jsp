<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Login Page</title>
  <link rel="stylesheet" href="index.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"></head>
<body>
  <div class="container">
    <div class="logo">
      <a href="http://www.sust.edu">
        <img src="https://epayment.sust.edu/front/img/logo.png" alt="Example Image">
      </a>
    </div>
    <div class="name_label">
      <h1>Shahjalal University Of Science & Technology</h1>
    </div>
    <div class="form">
      <h2 style="text-align:center">Login to your Account</h2>
      <form action="LogInServlet" method="post">
        <div class="form-control">
		  <label for="username" style="font-size: 18px;"><i class="fas fa-user"></i>   Username</label>
		  <input type="text" id="username" name="username" required>
		</div>
		<div class="form-control">
		  <label for="password" style="font-size: 18px;"><i class="fas fa-lock"></i>   Password</label>
		  <input type="password" id="password" name="password" required>
		</div>
        <div class="form-control" style="margin-top: 10px; width:120px; margin-left:33%">
          <input type="submit" value="Sign In" style="font-size: 16px;">
        </div>
        <c:if test="${not empty errorMessage}">
          <div style="color: red; text-align: center; margin-top: 10px;">
            ${errorMessage}
          </div>
        </c:if>
      </form>

    </div>
  </div>
</body>
</html>
