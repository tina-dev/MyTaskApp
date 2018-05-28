<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Task Management App</title>
	<link href='css/fullcalendar.css' rel='stylesheet' />
	<link href='css/fullcalendar.print.css' rel='stylesheet' media='print' />
	<link href='css/jquery-ui.min.css' rel='stylesheet' />
	<link href='css/jquery-ui.theme.min.css' rel='stylesheet' />
	<link href='css/style.css' rel='stylesheet'/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	
	<script src='js/jquery/jquery-1.10.2.js'></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  	<script src='js/jquery/jquery-ui.custom.min.js'></script>
	
	<script src='js/fullcalendar.js'></script>
	

	
	
	<script>

	$(document).ready(function() {
	    var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		
		$.ajax({
            type: "GET",
            url: "<c:url value='/task/getAllTasks' />", //this is my servlet
            success: function(data){ 
            	var source =[];
            	$(data).each(function (e, v) { 
                    source.push({
                    	title: v.name,
    					start: v.scheduledDate,
    					end: v.completionDate,
    					allDay: true,
    					className: v.state,
    					id: v.id
                    });
                  });
            	generateCalendar(source)
            }
       	});
		
		$.ajax({
            type: "GET",
            url: "<c:url value='/task/getAllMilestones' />", //this is my servlet
            success: function(data){
            	$.each(data, function(key, value) {   
            	     $('#milestoneId')
            	         .append($("<option></option>")
            	                    .attr("value",value.id)
            	                    .text(value.name)); 
            	});
            }
       	});
		

		/*  className colors
		
		className: abandoned(purple), completed(red), opened(yellow), running(green), planned(blue)
		
			
		
		  
		/* initialize the external events
		-----------------------------------------------------------------*/
	
		$('#external-events div.external-event').each(function() {
		
			// create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
			// it doesn't need to have a start or end
			var eventObject = {
				title: $.trim($(this).text()) // use the element's text as the event title
			};
			
			// store the Event Object in the DOM element so we can get to it later
			$(this).data('eventObject', eventObject);
			
			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});
			
		});
	
	
		/* initialize the calendar
		-----------------------------------------------------------------*/
		
		function generateCalendar(dataSource){
			var calendar =  $('#calendar').fullCalendar({
				header: {
					left: 'title',
					center: 'agendaDay,agendaWeek,month',
					right: 'prev,next today'
				},
				editable: true,
				firstDay: 1, //  1(Monday) this can be changed to 0(Sunday) for the USA system
				selectable: true,
				defaultView: 'month',
				
				axisFormat: 'h:mm',
				columnFormat: {
	                month: 'ddd',    // Mon
	                week: 'ddd d', // Mon 7
	                day: 'dddd M/d',  // Monday 9/7
	                agendaDay: 'dddd d'
	            },
	            titleFormat: {
	                month: 'MMMM yyyy', // September 2009
	                week: "MMMM yyyy", // September 2009
	                day: 'MMMM yyyy'                  // Tuesday, Sep 8, 2009
	            },
				allDaySlot: false,
				selectHelper: true,
				select: function(start, end, allDay) {
					$( function() {
						$('#task_form')[0].reset();
						$('#task_form :input').prop('readonly', false);
						$('#task_form').attr('action', "<c:url value='/task/createTask' />");
					    $( "#dialog" ).dialog({width :'638.4px'});
					  } );
					
				calendar.fullCalendar('unselect');
				},
				eventClick: function(calEvent, jsEvent, view) {

					$.ajax({
			            type: "GET",
			            url: "<c:url value='/task/getAllTasks' />", //this is my servlet
			            data: { id: calEvent.id },
			            success: function(data){ 
			            	$('#task_form input[name="id"]').val(data[0].id);
			            	$('#task_form input[name="name"]').val(data[0].name);
			            	$('#task_form textarea[name="description"]').val(data[0].description);
			            	$('#task_form select[name="state"]').val(data[0].state);
			            	$('#task_form input[name="assignedTimeBudget"]').val(data[0].assignedTimeBudget);
			            	$('#task_form input[name="usedTimeBudget"]').val(data[0].usedTimeBudget);
			            	$('#task_form input[name="scheduledDate"]').val(data[0].scheduledDate);
			            	$('#task_form input[name="completionDate"]').val(data[0].completionDate);
			            	$('#task_form select[name="milestoneId"]').val(data[0].milestoneId);
			            	$( function() {
							    $( "#dialog" ).dialog({width :'638.4px'});
							  } );
			            }
			       	});
					
				    // change the border color just for fun
				    $(this).css('border-color', 'red');

				  },
				droppable: true, // this allows things to be dropped onto the calendar !!!
				drop: function(date, allDay) { // this function is called when something is dropped
				
					// retrieve the dropped element's stored Event Object
					var originalEventObject = $(this).data('eventObject');
					
					// we need to copy it, so that multiple events don't have a reference to the same object
					var copiedEventObject = $.extend({}, originalEventObject);
					
					// assign it the date that was reported
					copiedEventObject.start = date;
					copiedEventObject.allDay = allDay;
					
					// render the event on the calendar
					// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
					$('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
					
					// is the "remove after drop" checkbox checked?
					if ($('#drop-remove').is(':checked')) {
						// if so, remove the element from the "Draggable Events" list
						$(this).remove();
					}
					
				},
				events: dataSource,			
			});
			
			$(document).on('click', '#delete_btn', function(){
				
				if (confirm("Are you sure you want to delete this task?")) {
					
					var taskId = $('#task_form').find('input[name="id"]').val();
					$.ajax({
			            type: "GET",
			            url: "<c:url value='/task/deleteTask/"+ taskId +"' />",
			            success: function(){ 
			            	$('#dialog').dialog('close');
			            	$('#calendar').fullCalendar('removeEvents', taskId);
			            }
			       	});	
				}
			});
			
			$(document).on('click', '#edit_btn', function(){
									
				$('#task_form :input').prop('readonly', false);
					
			});

			$(document).on('click', '#cancel_btn', function(){
									
				$('#dialog').dialog('close');
					
			});
		}
		
		
		
	});

</script>
	</head>
	<body>
		<nav class="navbar navbar-inverse">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      <a class="navbar-brand" href="#">Time Management</a>
		    </div>
		    <ul class="nav navbar-nav">
		      <li class="active"><a href="#">MyCalendar</a></li>
		     </ul>
		   
		    <ul class="nav navbar-nav navbar-right">
		    	<li>
		    		<form role="Form" method="POST" action="<c:url value='/admin' />" modelAttribute="admin" accept-charset="UTF-8">
		      			<li><button type="submit" class="btn btn-default">My projects</button></li>
	    			</form>
	    		
		      		<form role="Form" method="POST" action="<c:url value='/logout' />" accept-charset="UTF-8">
		      			<li><button type="submit" class="btn btn-default">Logout</button></li>
	    			</form>
	    		</li>
		    </ul>
	   
		  </div>
		</nav>
		
		<div id='calendar'></div>

	<div id="dialog" title="Task Management Dialog" style="display: none; width: 632px" class="form-group">

		<div class="container">
			<div class="col-sm-6">
				<form id="task_form" action="<c:url value='/task/updateTask' />"
					method="POST">
					<div class="form-group">
						<label for="task">Task</label> <input type="hidden"
							class="form-control" id="id" name="id"> <input
							type="text" class="form-control" id="task" name="name" readonly required>
					</div>
					<div class="form-group">
						<label for="description">Description</label>
						<textarea class="form-control" id="description" rows="3"
							name="description" readonly></textarea>
					</div>
					<div class="form-group">
						<label for="state">State</label> <select class="form-control"
							size="5" id="state" name="state" readonly required>
							<option value="planned">PLANNED</option>
							<option value="opened">OPENED</option>
							<option value="running">RUNNING</option>
							<option value="completed">COMPLETED</option>
							<option value="abandoned">ABANDONED</option>
						</select>
					</div>
					<div class="form-group row">
						<div class="col-xs-6">
							<label for="Assigned Time Budget">Assigned Time Budget</label> <input
								class="form-control" id="ex1" width="250" type="text"
								name="assignedTimeBudget" readonly>
						</div>
						<div class="col-xs-6">
							<label for="Used Time Budget">Used Time Budget</label> <input
								class="form-control" id="ex3" width="250" type="text"
								name="usedTimeBudget" readonly>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-xs-6">
							<label for="Scheduled Date">Scheduled Date</label> <input
								id="datepicker" width="250" name="scheduledDate" readonly required />
							<script type="text/javascript">
					       		$(function() {
					               $("#datepicker").datepicker({ dateFormat: "yy-mm-dd" }).val()
					       		});
					   		</script>
						</div>
						<div class="col-xs-6">
							<label for="Completion Date">Completion Date</label> <input
								id="datepicker1" width="250" name="completionDate" readonly required />
							<script type="text/javascript">
					       		$(function() {
					               $("#datepicker1").datepicker({ dateFormat: "yy-mm-dd" }).val()
					       		});
					   		</script>
						</div>
					</div>
					<div>
						<label for="state">Milestone</label> <select id="milestoneId" class="form-control"
							size="5" name="milestoneId" readonly >
						</select>
					</div>

					<div style="margin-top: 5px">
						<div class="btn-group">
							<button type="button" class="btn btn-lg" id="edit_btn">Edit</button>
						</div>
						<div class="btn-group">
							<button type="button" class="btn btn-lg" id="cancel_btn">Cancel</button>
						</div>
						<div class="btn-group">
							<button type="button" class="btn btn-lg" id="delete_btn">Delete</button>
						</div>
						<div class="btn-group">
							<button type="submit" class="btn btn-primary btn-lg"
								id="save_btn">Save</button>
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>

</body>
</html>