package net.tina.MyTaskApp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import net.tina.MyTaskApp.entity.Milestone;
import net.tina.MyTaskApp.entity.Task;
import net.tina.MyTaskApp.entity.TaskUser;
import net.tina.MyTaskApp.model.Users;
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
	

	@SuppressWarnings("static-access")
	@RequestMapping(value = "/createTask", method = RequestMethod.POST)
    void createTask(@Valid @ModelAttribute("task") Task task, BindingResult result, ModelMap model, Authentication authentication,HttpServletResponse httpServletResponse)
	{
        //if (result.hasErrors()) return "Error";
		
		if(authentication != null)
		{
			Users userDetails = (Users) authentication.getPrincipal();
			task.setCreatedBy(userDetails.getId());
		}
        
		Task createdTask = taskService.createTask(task);
		if(createdTask != null)
			httpServletResponse.setStatus(httpServletResponse.SC_MOVED_TEMPORARILY);
			httpServletResponse.setHeader("Location", "/MyTaskApp/task");
		
        }
	
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/updateTask", method = RequestMethod.POST)
	public void updateTask(@Valid @ModelAttribute("task") Task task, BindingResult result, ModelMap model, HttpServletResponse httpServletResponse)
	{
		int updateResult = taskService.updateTask(task);
		
		if(updateResult == 1)
			httpServletResponse.setStatus(httpServletResponse.SC_MOVED_TEMPORARILY);
			httpServletResponse.setHeader("Location", "/MyTaskApp/task");
		
    }
	
	@RequestMapping(value = "/deleteTask/{id}", method = RequestMethod.GET)
	public String deleteTask(@PathVariable("id") int id, ModelMap model)
	{
		try
		{
			taskService.deleteTask(id);;
		}
		catch(Exception e)
		{
			return "Error";
		}
		
		return "Success";
    }
	
	// Controllers for milestones -----------------------------------------------------------------------------------------------
	
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
    Map<String, String> getStates(ModelMap model)
	{
		Map<String, String> states = new HashMap<String, String>();
		states.put("planned", "PLANNED");
		states.put("opened", "OPEN");
		states.put("running", "RUNNING");
		states.put("completed", "COMPLETED");
		states.put("abandoned", "ABONDONED");
		
		return states;
    }
}