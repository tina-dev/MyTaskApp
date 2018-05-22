package net.tina.MyTaskApp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import net.tina.MyTaskApp.entity.Milestone;
import net.tina.MyTaskApp.entity.Task;
import net.tina.MyTaskApp.entity.TaskUser;
import net.tina.MyTaskApp.service.TaskService;

@RestController
@RequestMapping("/task")
public class TaskRestController
{
	@Autowired
	private TaskService taskService;
	
	@RequestMapping(value = "/getAllTasks", method = RequestMethod.GET)
    List<Task> getAllTasks(HttpServletRequest request, ModelMap model)
	{
		if(request.getParameter("id") != null)
		{
			return taskService.getTasksByUserId(Integer.parseInt(request.getParameter("id")));
		}
		
		return taskService.getAllTasks();
    }
	
	@RequestMapping(value = "/getAllMilestones", method = RequestMethod.GET)
    List<Milestone> getAllMilestones(ModelMap model)
	{
		return taskService.getAllMilestones();
    }
	
	@RequestMapping(value = "/getAllTaskUsers", method = RequestMethod.GET)
    List<TaskUser> getAllTaskUsers(ModelMap model)
	{
		return taskService.getAllTaskUsers();
    }
	
	@RequestMapping(value = "/admin/deleteTaskUser/{id}", method = RequestMethod.GET)
	public String deleteTaskUser(@PathVariable("id") int id, ModelMap model)
	{
		try
		{
			taskService.deleteTaskUser(id);
		}
		catch(Exception e)
		{
			return "Error";
		}
		
		return "Success";
    }
	
	@RequestMapping(value = "/getStates", method = RequestMethod.GET)
    Map<Integer, String> getStates(ModelMap model)
	{
		Map<Integer, String> states = new HashMap<Integer, String>();
		states.put(1, "PLANNED");
		states.put(2, "OPEN");
		states.put(3, "RUNNING");
		states.put(4, "COMPLETED");
		states.put(5, "ABONDONED");
		
		return states;
    }
}