<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-treeview/1.2.0/bootstrap-treeview.min.js"></script>
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
									  			<span for="ex1">Scheduled Completion</span>
									  			<input id="scheduledDate" width="200" class="form-control" name="scheduledDate"/>
							    				<script>
											        $('#scheduledDate').datepicker({
											            uiLibrary: 'bootstrap'
											        });
											    </script>
								  			</div>
								  			<div class="col-xs-5">
									  			<span for="ex2">Completion Achieved</span>
									  			<input id="completionDate" width="200" class="form-control" name="completionDate"/>
							    				<script>
											        $('#completionDate').datepicker({
											            uiLibrary: 'bootstrap'
											        });
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
			document.getElementById('name').value = "";
			document.getElementById('description').value = "";
			document.getElementById("state").selectedIndex = "-1";
			document.getElementById('assignedTimeBudget').value = "";
			document.getElementById('usedTimeBudget').value = "";
			document.getElementById('scheduledDate').value = "";
			document.getElementById('completionDate').value = "";
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
			document.getElementById('scheduledDate').disabled = bool;
			document.getElementById('completionDate').disabled = bool;
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
					document.getElementById('scheduledDate').value = task.scheduledDate;
					document.getElementById('completionDate').value = task.completionDate;
					document.getElementById("milestoneId").selectedIndex = task.milestoneId;
					document.getElementById("parentId").selectedIndex = task.parentId;
				}
			}
		};
		
		</script>
	<script type="text/javascript">
		$(function() {
    var treeData = [
      {
        text: 'P: Prepare Lecture',
        href: '#menu1',
        nodes: [
          {
            text: 'C: Prepare Slides',
            href: '#submenu1',
            tags: ['2'],
            nodes: [
              {
                text: 'S: Select Existing Slides',
                href: '#submenu1.1',
                tags: ['0']
              },
              {
                text: 'S: Translate Selected Eixsting Slides',
                href: '#submenu1.2',
                tags: ['0']
              },
              {
                text: 'S: Create New Slides',
                href: '#submenu1.2',
                tags: ['0']
              }
            ]
          },
          {
            text: 'C: Prepare Example Code',
            href: '#submenu2',
            tags: ['2'],
            nodes:
            [
            	{
            		text: 'C: Monolothic Example',
                	href: '#submenu1.1',
                	tags: ['0'],
                	nodes:
                	[
                		{
                			text: 'S: Program Monolothic Examples',
            				href: '#submenu2',
            				tags: ['2']
                		},
                		{
                			text: 'S: Test Monolothic Examples',
            				href: '#submenu2',
            				tags: ['2']
                		}
                	]
            	},
            	{
                	text: 'S: Simple Examples',
            		href: '#submenu2',
            		tags: ['2']
                },
                {
            		text: 'C: Microservice Example',
                	href: '#submenu1.1',
                	tags: ['0'],
                	nodes:
                	[
                		{
                			text: 'S: Install Docker',
            				href: '#submenu2',
            				tags: ['2']
                		},
                		{
                			text: 'S: Refactor Monolothic Examples',
            				href: '#submenu2',
            				tags: ['2']
                		},
                		{
                			text: 'S: Test MMicroservice Examples',
            				href: '#submenu2',
            				tags: ['2']
                		}
                	]
            	}
            ]
          }
        ]
      }
    ];
    $('#treeview').treeview({
      data: treeData,
    });
	})
	</script>
	</body>
</html>