<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>
		<!-- <link href="css/bootstrap-treeview.css" rel="stylesheet"/> -->
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
		<script src="js/bootstrap-treeview.min.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Admin page</title>
	</head>
	<body>
		<div class="container">
			<div class="row">
				<form role="Form" method="POST" action="<c:url value='/logout' />" accept-charset="UTF-8">
					<div class="form-group">
						<button type="submit" class="btn btn-default">Logout</button>
					</div>
				</form>
				<div id="login-box">
					<h2>Welcome to Task Management App</h2>
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#task">Task Management</a></li>
						<li><a data-toggle="tab" href="#milestone">Milestone Management</a></li>
					</ul>
					<br>
					<div class="tab-content">
						<div id="task" class="tab-pane fade in active">
							<div class="sidenav col-sm-5">
								<div>
									<span>Task Tree</span>
								</div>
								<div id="treeview" class=""></div>
								<br>
							</div>
							<div class="container">
								<div class="col-sm-6">
								  	<form role="Form" method="POST" accept-charset="UTF-8">
								    	<span for="task" id="task">Task</span>
								      	<input type="hidden" class="form-control" id="id"  name="id" value="0">
								      	<input type="text" class="form-control" id="name"  name="name">
								      	<br>
								      	<span for="pwd">Description</span>
								      	<textarea class="form-control" id="description" name="description" style="height:100px"></textarea>
									  	<br>
								      	<span for="state">State</span>
								      	<select id="state" name="state" size = "5" class="form-control">
											<option value="1">PLANNED</option>
										  	<option value="2">OPEN</option>
										  	<option value="3">RUNNING</option>
										  	<option value="4">COMPLETED</option>
										  	<option value="5">ABANDONED</option>
									  	</select>
									  	<br>
								    	<div class="form-group row">
								      		<div class="col-xs-5">
										        <span for="ex1">Assigned Time Budget</span>
										    	<input class="form-control" id="assignedTimeBudget" type="text" name="assignedTimeBudget">
										    </div>
								      		<div class="col-xs-5">
										        <span for="ex3">Used Time Budget</span>
										        <input class="form-control" id="usedTimeBudget" type="text" name="usedTimeBudget">
								      		</div>
								    	</div>
								  		<div class="form-group row">
								  			<div class="col-xs-5">
									  			<span for="ex1">Scheduled Date</span>
									  			<input id  = "datepicker" width="200" class="form-control" name="scheduledDate"/>
							    					<script type="text/javascript">
					       							$(function() {
					              					$("#datepicker").datepicker({ dateFormat: "yy-mm-dd" }).val()});
					   								</script>
								  			</div>
								  			<div class="col-xs-5">
									  			<span for="ex2">Completion Achieved</span>
									  			<input id="datepicker1" width="200" class="form-control" name="completionDate"/>
							    				<script type="text/javascript">
					       							$(function() {
					              					$("#datepicker1").datepicker({ dateFormat: "yy-mm-dd" }).val()});
					   								</script>
								  			</div>
								  		</div>
								  		<div class="form-group">
								  			<span for="milestone">Milestone</span>
							      			<select id="milestoneId" name="milestoneId" size = "5" class="form-control" >
										  		<option value="1">Microservice Examples Done</option>
										  		<option value="2">Monotlithic Examples Done</option>
										  		<option value="3">Simple Example Done</option>
										  		<option value="4">Slides Available</option>
									  		</select>
								  		</div>
								  		<div class="form-group">
								  			<span for="tasks">Subtask of:</span>
							      			<select id="parentId" name="parentId" size = "5" class="form-control" >
										  		<option value="0">No parent</option>
										  		<c:forEach items="${allTasks}" var="task">
												    <option value="${task.id}">${task.name}</option>
												</c:forEach>
									  		</select>
								  		</div>
								  		<br>
								  		<div class="form-group">
								  			<button type="button" class="btn btn-success" id="new" onclick="newBtnClick()">New</button>
											<button type="button" class="btn btn-primary" id="cancelNew" onclick="cancelNewBtnClick()" disabled>Cancel</button>
											<button type="submit" class="btn btn-primary" id="submitNew" formaction="<c:url value='/admin/createTask' />" disabled>Save</button>
								  		</div>
								  		<div class="form-group">
											<button type="button" class="btn btn-info" id="edit" onclick="editBtnClick()">Edit</button>
											<button type="button" class="btn btn-primary" id="cancelEdit" onclick="cancelEditBtnClick()" disabled>Cancel</button>
											<button type="submit" class="btn btn-primary" id="submitEdit" formaction="<c:url value='/admin/updateTask' />" disabled>Save</button>
								  		</div>
								  		<div class="form-group">
  											<button type="submit" class="btn btn-danger" formaction="<c:url value='/admin/deleteTask' />" >Delete</button>
								  		</div>
								  	</form>
							    </div>
							</div>
						</div>
						<div id="milestone" class="tab-pane fade">
							
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
		
		var tasklist;
		
		$(document).ready(function()
		{	         
			disableForm(true);
			tasklist = ${tasks};
			
			var initSelectableTree = function() {
		          return $('#treeview').treeview({
		            data: unflatten(tasklist),
		            onNodeSelected: function(event, node) {
		            	setTask(node.id);
		    			disableForm(false);
		            },
		            onNodeUnselected: function (event, node) {
		            	clearForm();
		    			disableForm(false);
		            }
		          });
		        };
		        var $selectableTree = initSelectableTree();
		});
		
		function newBtnClick()
		{
			document.getElementById('cancelNew').disabled = document.getElementById('submitNew').disabled = false;
			
			clearForm();
			disableForm(false);
		};
		
		function cancelNewBtnClick()
		{
			document.getElementById('cancelNew').disabled = document.getElementById('submitNew').disabled = true;

			disableForm(true);
		};
		
		function editBtnClick()
		{
			document.getElementById('cancelEdit').disabled = document.getElementById('submitEdit').disabled = false;
			
			disableForm(false);
		};
		
		function cancelEditBtnClick()
		{
			document.getElementById('cancelEdit').disabled = document.getElementById('submitEdit').disabled = true;
			
			disableForm(true);
		};
		
		function clearForm()
		{
			document.getElementById('id').value = "";
			document.getElementById('name').value = "";
			document.getElementById('description').value = "";
			document.getElementById("state").selectedIndex = "-1";
			document.getElementById('assignedTimeBudget').value = "";
			document.getElementById('usedTimeBudget').value = "";
			document.getElementById('datepicker').value = "";
			document.getElementById('datepicker1').value = "";
			document.getElementById("milestoneId").selectedIndex = "-1";
			document.getElementById("parentId").selectedIndex = "-1";
		};
		
		function disableForm(bool)
		{
			document.getElementById('name').disabled = bool;
			document.getElementById('description').disabled = bool;
			document.getElementById('state').disabled = bool;
			document.getElementById('assignedTimeBudget').disabled = bool;
			document.getElementById('usedTimeBudget').disabled = bool;
			document.getElementById('datepicker').disabled = bool;
			document.getElementById('datepicker1').disabled = bool;
			document.getElementById('milestoneId').disabled = bool;
			document.getElementById('parentId').disabled = bool;
		};
		
		function setTask(id)
		{
			for (var i = 0; i < tasklist.length; i++)
			{
				var task = tasklist[i];
				if(task.id == id)
				{
					document.getElementById('id').value = task.id;
					document.getElementById('name').value = task.name;
					document.getElementById('description').value = task.description;
					document.getElementById("state").selectedIndex = task.state;
					document.getElementById('assignedTimeBudget').value = task.assignedTimeBudget;
					document.getElementById('usedTimeBudget').value = task.usedTimeBudget;
					document.getElementById("milestoneId").selectedIndex = task.milestoneId;
					document.getElementById("parentId").selectedIndex = task.parentId;
					document.getElementById("datepicker").value = task.scheduledDate;
					document.getElementById("datepicker1").value = task.completionDate;
					/*if(task.scheduledDate){
						var scheduledDate = new Date(task.scheduledDate);
						document.getElementById('scheduledDate').value = 
							scheduledDate.getFullYear() + '-' + (scheduledDate.getMonth() + 1) + '-' + scheduledDate.getDate()
					}
					if(task.completionDate){
						var completionDate = new Date(task.completionDate);
						document.getElementById('completionDate').value = 
							completionDate.getFullYear() + '-' + (completionDate.getMonth() + 1) + '-' + completionDate.getDate()
					}*/
				}
			}
		};
		
		function unflatten(arr){
			var tree = [],
			mappedArr = [],
			arrElem,
			mappedElem;
			
			for(var i= 0; i<arr.length; i++){
				arrElem = arr[i];
				delete arrElem.state;
				mappedArr[arrElem.id] = arrElem;
			}
			
			for(var id in mappedArr){
				if(mappedArr.hasOwnProperty(id)){
					mappedElem = mappedArr[id];
					if(mappedElem.parentId){
						mappedArr[mappedElem['parentId']]['nodes'] = [];
						mappedArr[mappedElem['parentId']]['nodes'].push(mappedElem)
					}
					else{
						tree.push(mappedElem);
					}
				}
			}
			return tree;
		}
	</script>
	</body>
</html>