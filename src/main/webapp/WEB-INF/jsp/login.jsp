<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Sign in or Sign up</title>
	</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-lg-6 col-lg-offset-3">
					<div id="login-box">
						<h2>Welcome to Task Management App</h2>
						<ul class="nav nav-tabs">
							<li class="active"><a data-toggle="tab" href="#signin">Sign in</a></li>
							<li><a data-toggle="tab" href="#signup">Sign up</a></li>
						</ul>
						<div class="tab-content">
							<div id="signin" class="tab-pane fade in active">
								<h3>SIGN IN</h3>
								<form role="Form" method="POST" action="<c:url value='/login' />" accept-charset="UTF-8">
									<div class="form-group">
										<input type="text" name="username" placeholder="Username..." class="form-control">
									</div>
									<div class="form-group">
										<input type="password" name="password" placeholder="Password..." class="form-control">
									</div>
									<div class="form-group">
										<button type="submit" class="btn btn-default">Sign in</button>
									</div>
								</form>
							</div>
							<div id="signup" class="tab-pane fade">
								<h3>SIGN UP</h3>
								<form role="Form" method="POST" action="<c:url value='/signup' />" accept-charset="UTF-8">
									<div class="form-group">
										<input type="text" name="name" placeholder="Name..." class="form-control">
									</div>
									<div class="form-group">
										<input type="text" name="lastname" placeholder="Lastname..." class="form-control">
									</div>
									<div class="form-group">
										<input type="text" name="email" placeholder="Email..." class="form-control">
									</div>
									<div class="form-group">
										<input type="text" name="username" placeholder="Username..." class="form-control">
									</div>
									<div class="form-group">
										<input type="password" name="password1" placeholder="Password..." class="form-control">
									</div>
									<div class="form-group">
										<input type="password" name="password2" placeholder="Verify password..." class="form-control">
									</div>
									<h6>Select user type:</h6>
									<div class="form-group">
										<div class="radio">
											<label><input type="radio" name="usertype" value="ADMIN" checked>Admin</label>
										</div>
										<div class="radio">
										 	<label><input type="radio" name="usertype" value="USER">User</label>
										</div>
									</div>
									<div class="form-group">
										<button type="submit" class="btn btn-default">Sign up</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>