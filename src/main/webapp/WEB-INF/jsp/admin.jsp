<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Admin page</title>
	</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-lg-6 col-lg-offset-3">
					<h3>This is admin page!</h3>
					<form role="Form" method="POST" action="<c:url value='/logout' />" accept-charset="UTF-8">
						<div class="form-group">
							<button type="submit" class="btn btn-default">Logout</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>