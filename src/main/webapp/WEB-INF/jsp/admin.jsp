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
				<form method="POST" action="<c:url value='/logout' />" accept-charset="UTF-8">
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
								  	<form method="POST" accept-charset="UTF-8">
								    	<span id="task">Task</span>
								      	<input type="hidden" class="form-control" id="id"  name="id" value="0">
								      	<input type="text" class="form-control" id="name"  name="name">
								      	<br>
								      	<span>Description</span>
								      	<textarea class="form-control" id="description" name="description" style="height:100px"></textarea>
									  	<br>
								      	<span>State</span>
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
										        <span>Assigned Time Budget</span>
										    	<input class="form-control" id="assignedTimeBudget" type="text" name="assignedTimeBudget">
										    </div>
								      		<div class="col-xs-5">
										        <span>Used Time Budget</span>
										        <input class="form-control" id="usedTimeBudget" type="text" name="usedTimeBudget">
								      		</div>
								    	</div>
								  		<div class="form-group row">
								  			<div class="col-xs-5">
									  			<span>Scheduled Completion</span>
									  			<input id="scheduledDate" width="200" class="form-control" name="scheduledDate"/>
							    				<script>
											        
											    </script>
								  			</div>
								  			<div class="col-xs-5">
									  			<span>Completion Achieved</span>
									  			<input id="completionDate" width="200" class="form-control" name="completionDate"/>
							    				<script> 
											    </script>
								  			</div>
								  		</div>
								  		<div class="form-group">
								  			<span>Milestone</span>
							      			<select id="milestoneId" name="milestoneId" size = "5" class="form-control" >
										  		<c:forEach items="${allMilestones}" var="milestone">
											<option value="${milestone.id}">${milestone.name}</option>
										</c:forEach>
									  		</select>
								  		</div>
								  		<div class="form-group">
								  			<span>Subtask of:</span>
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
							<div class="sidenav col-sm-5">
								<div class="form-group">
						  			<span>Milestone</span>
					      			<select id="milestoneSelect" name="milestoneId" size = "5" class="form-control" onchange="milestoneSelected()">
								  		<c:forEach items="${allMilestones}" var="milestone">
											<option value="${milestone.id}">${milestone.name}</option>
										</c:forEach>	
							  		</select>
						  		</div>
							</div>
							<div class="container">
								<div class="col-md-6">
									<form method="POST" accept-charset="UTF-8">
								    	<span id="task">Milestone</span>
								      	<input type="hidden" class="form-control" id="milestoneId"  name="id" value="0">
								      	<input type="text" class="form-control" id="milestoneName"  name="name">
									  	<br>
								      	<span>State</span>
								      	<select id="milestoneState" name="state" size = "5" class="form-control">
											<option value="1">OPEN</option>
										  	<option value="2">COMPLETED</option>
									  	</select>
									  	<br>
								  		<div class="form-group row">
								  			<div class="col-xs-5">
									  			<span>Date due</span>
									  			<input id="dueDate" width="200" class="form-control" name="dueDate"/>
								  			</div>
								  		</div>
								  		<div class="form-group row">
								  			<div class="col-md-12">
									      		<span><strong>Subtasks</strong></span>
									      	</div>
									      	<div class="col-md-5">
									      		<span>Available</span>
										      	<select id="availableTasks" name="state" size="5" class="form-control">
													<!-- will be filled using JavaScript -->
											  	</select>
										  	</div>
									      	<div class="col-md-1" style="padding:20px 0px 0px 0px">
										      	<button type="button" class="btn btn-success" id="assignTask" onclick="assignTaskClick()">→</button>
												<br>
												<br>
												<button type="button" class="btn btn-danger" id="removeAssignedTask" onclick="removeAssignedTaskClick()">←</button>
										  	</div>
									      	<div class="col-md-5">
									      		<span>Assigned</span>
										      	<select id="assignedTasks" name="state" size="5" class="form-control">
													<!-- will be filled using JavaScript -->
											  	</select>
										  	</div>
									  	</div>
								  		<br>
								  		<div class="form-group">
								  			<button type="button" class="btn btn-success" id="newMilestone" onclick="newMilestoneBtnClick()">New</button>
											<button type="button" class="btn btn-primary" id="cancelNewMilestone" onclick="cancelNewMilestoneBtnClick()" disabled>Cancel</button>
											<button type="button" class="btn btn-primary" id="submitNewMilestone" onclick="createMilestone()" disabled>Save</button>
								  		</div>
								  		<div class="form-group">
											<button type="button" class="btn btn-info" id="editMilestone" onclick="editMilestoneBtnClick()">Edit</button>
											<button type="button" class="btn btn-primary" id="cancelEditMilestone" onclick="cancelEditMilestoneBtnClick()" disabled>Cancel</button>
											<button type="button" class="btn btn-primary" id="submitEditMilestone" onclick="updateMilestone()" disabled>Save</button>
								  		</div>
								  		<div class="form-group">
  											<button type="button" class="btn btn-danger" onclick="deleteMilestone()" >Delete</button>
								  		</div>
								  	</form>
								</div>  
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
		
		var tasklist;
		var milestoneList;
		
		$(document).ready(function()
		{
			$('#scheduledDate').datepicker({
	            format: 'yyyy-mm-dd'
	        });

	        $('#completionDate').datepicker({
	            format: 'yyyy-mm-dd'
	        });

	        $('#dueDate').datepicker({
	            format: 'yyyy-mm-dd'
	        });
	        
			disableForm(true);
			tasklist = ${tasks};
			
			disableMilestoneForm(true);
			milestoneList = ${milestones};
			
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

		// SCRIPTS FOR MILESTONE MANAGEMENT -------------------------------------------------------------------------------------
		function newMilestoneBtnClick()
		{
			document.getElementById('cancelNewMilestone').disabled = document.getElementById('submitNewMilestone').disabled = false;
			
			document.getElementById("availableTasks").options.length = 0;
			document.getElementById("assignedTasks").options.length = 0;
			
			clearMilestoneForm();
			disableMilestoneForm(false);
		};
		
		function cancelNewMilestoneBtnClick()
		{
			document.getElementById('cancelNewMilestone').disabled = document.getElementById('submitNewMilestone').disabled = true;

			disableMilestoneForm(true);
		};
		
		function editMilestoneBtnClick()
		{
			document.getElementById('cancelEditMilestone').disabled = document.getElementById('submitEditMilestone').disabled = false;
			
			disableMilestoneForm(false);
		};
		
		function cancelEditMilestoneBtnClick()
		{
			document.getElementById('cancelEditMilestone').disabled = document.getElementById('submitEditMilestone').disabled = true;
			
			disableMilestoneForm(true);
			clearMilestoneForm();
			milestoneSelected();
		};
		
		function clearMilestoneForm()
		{
			document.getElementById('milestoneId').value = "";
			document.getElementById('milestoneName').value = "";
			document.getElementById("milestoneState").selectedIndex = "-1";
			document.getElementById('dueDate').value = "";
			
			setAvailableTasks(0);
			setAssignedTasks(-1);
		};
		
		function disableMilestoneForm(bool)
		{
			document.getElementById('milestoneId').disabled = bool;
			document.getElementById('milestoneName').disabled = bool;
			document.getElementById('milestoneState').disabled = bool;
			document.getElementById('dueDate').disabled = bool;
			document.getElementById('availableTasks').disabled = bool;
			document.getElementById('assignTask').disabled = bool;
			document.getElementById('removeAssignedTask').disabled = bool;
			document.getElementById('assignedTasks').disabled = bool;
		};
		
		function milestoneSelected()
		{
			var id = document.getElementById("milestoneSelect").value;
			
			disableMilestoneForm(true);
			document.getElementById("availableTasks").options.length = 0;
			document.getElementById("assignedTasks").options.length = 0;
			
			setMilestone(id);
			setAvailableTasks(id);
			setAssignedTasks(id);
		}
		
		function setMilestone(id)
		{
			for (var i = 0; i < milestoneList.length; i++)
			{
				var milestone = milestoneList[i];
				if(milestone.id == id)
				{
					document.getElementById('milestoneId').value = milestone.id;
					document.getElementById('milestoneName').value = milestone.name;
					document.getElementById("milestoneState").value = milestone.state;
					//document.getElementById('dueDate').value = milestone.dueDate;
					if(milestone.dueDate){
						var dueDate = new Date(milestone.dueDate);
						document.getElementById('dueDate').value = 
							dueDate.getFullYear() + '-' + (dueDate.getMonth() + 1) + '-' + dueDate.getDate();
					}
				}
			}
		};
		
		function setAvailableTasks(id)
		{
			var select = document.getElementById('availableTasks');
			
			for (var i = 0; i < tasklist.length; i++)
			{
				var task = tasklist[i];
				if(task.milestoneId > 0 && task.milestoneId != id)
				{
				    var option = document.createElement('option');
				    option.setAttribute('value', task.id);
				    option.appendChild(document.createTextNode(task.name));
				    select.appendChild(option);
				}
			}
		};
		
		function setAssignedTasks(id)
		{
			var select = document.getElementById('assignedTasks');
			
			for (var i = 0; i < tasklist.length; i++)
			{
				var task = tasklist[i];
				if(task.milestoneId == id)
				{
				    var option = document.createElement('option');
				    option.setAttribute('value', task.id);
				    option.appendChild(document.createTextNode(task.name));
				    select.appendChild(option);
				}
			}
		};
		
		function assignTaskClick()
		{
			var select = document.getElementById('availableTasks');
			if(select.selectedIndex > -1)
			{
				var value = select.value;
				var name = select.options[select.selectedIndex].text;
				select.remove(select.selectedIndex);
				
				var option = document.createElement('option');
			    option.setAttribute('value', value);
			    option.appendChild(document.createTextNode(name));
			    document.getElementById('assignedTasks').appendChild(option);
			}
		};
		
		function removeAssignedTaskClick()
		{
			var select = document.getElementById('assignedTasks');
			if(select.selectedIndex > -1)
			{
				var value = select.value;
				var name = select.options[select.selectedIndex].text;
				select.remove(select.selectedIndex);
				
				var option = document.createElement('option');
			    option.setAttribute('value', value);
			    option.appendChild(document.createTextNode(name));
			    document.getElementById('availableTasks').appendChild(option);
			}
		};
		
		function createMilestone()
		{
			var assignedTasksList = [];
			for (var i = 0; i < document.getElementById("assignedTasks").options.length; i++)
			{
				assignedTasksList.push(document.getElementById("assignedTasks").options[i].value);
			}
			
			$.ajax({
	            type: "POST",
	            url: "<c:url value='/admin/createMilestone' />",
	            data: {
	            	id: document.getElementById('milestoneId').value,
					name: document.getElementById('milestoneName').value,
					state: document.getElementById("milestoneState").value,
					dueDate: document.getElementById('dueDate').value,
					assignedTasksList: assignedTasksList
	            },
	            dataType:'json',
	            success: function(){
	            	location.reload();
	            },
	            error: function(){
	            	location.reload();
	            }
	       	});
		};
		
		function updateMilestone()
		{
			var assignedTasksList = [];
			for (var i = 0; i < document.getElementById("assignedTasks").options.length; i++)
			{
				assignedTasksList.push(document.getElementById("assignedTasks").options[i].value);
			}
			
			$.ajax({
	            type: "POST",
	            url: "<c:url value='/admin/updateMilestone' />",
	            data: {
	            	id: document.getElementById('milestoneId').value,
					name: document.getElementById('milestoneName').value,
					state: document.getElementById("milestoneState").value,
					dueDate: document.getElementById('dueDate').value,
					assignedTasksList: assignedTasksList
	            },
	            success: function(){
	            	location.reload();
	            },
	            error: function(){
	            	location.reload();
	            }
	       	});
		};
		
		function deleteMilestone()
		{
			$.ajax({
	            type: "POST",
	            url: "<c:url value='/admin/deleteMilestone' />",
	            data: {
	            	id: document.getElementById('milestoneId').value
	            },
	            success: function(){
	            	location.reload();
	            },
	            error: function(){
	            	location.reload();
	            }
	       	});
		};
		
		// SCRIPTS FOR TASK MANAGEMENT ------------------------------------------------------------------------------------------
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
					document.getElementById("state").value = task.state;
					document.getElementById('assignedTimeBudget').value = task.assignedTimeBudget;
					document.getElementById('usedTimeBudget').value = task.usedTimeBudget;
					document.getElementById("milestoneId").selectedIndex = task.milestoneId;
					document.getElementById("parentId").selectedIndex = task.parentId;
					if(task.scheduledDate){
						var scheduledDate = new Date(task.scheduledDate);
						document.getElementById('scheduledDate').value = 
							scheduledDate.getFullYear() + '-' + (scheduledDate.getMonth() + 1) + '-' + scheduledDate.getDate()
					}
					if(task.completionDate){
						var completionDate = new Date(task.completionDate);
						document.getElementById('completionDate').value = 
							completionDate.getFullYear() + '-' + (completionDate.getMonth() + 1) + '-' + completionDate.getDate()
					}
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