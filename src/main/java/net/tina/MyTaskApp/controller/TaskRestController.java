package net.tina.MyTaskApp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
	
	@RequestMapping(value = "/createTask", method = RequestMethod.POST)
    String createTask(@Valid @ModelAttribute("task") Task task, BindingResult result, ModelMap model, Authentication authentication)
	{
        //if (result.hasErrors()) return "Error";
		
		if(authentication != null)
		{
			Users userDetails = (Users) authentication.getPrincipal();
			task.setCreatedBy(userDetails.getId());
		}
        
		Task createdTask = taskService.createTask(task);
		
        return createdTask != null ? "Success" : "Error";
    }
	
	@RequestMapping(value = "/updateTask", method = RequestMethod.POST)
	public String updateTask(@Valid @ModelAttribute("task") Task task, BindingResult result, ModelMap model)
	{
		int updateResult = taskService.updateTask(task);
		
		return updateResult == 1 ? "Success" : "Error";
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
	
	@RequestMapping(value = "/createMilestone", method = RequestMethod.POST)
    String createMilestone(@Valid @ModelAttribute("milestone") Milestone milestone, BindingResult result, ModelMap model)
	{
		Milestone createdMilestone = taskService.createMilestone(milestone);
		
        return createdMilestone != null ? "Success" : "Error";
    }
	
	@RequestMapping(value = "/updateMilestone", method = RequestMethod.POST)
	public String updateMilestone(@Valid @ModelAttribute("milestone") Milestone milestone, BindingResult result, ModelMap model)
	{
		int updateResult = taskService.updateMilestone(milestone);
		
		return updateResult == 1 ? "Success" : "Error";
    }
	
	@RequestMapping(value = "/deleteMilestone/{id}", method = RequestMethod.GET)
	public String deleteMilestone(@PathVariable("id") int id, ModelMap model)
	{
		try
		{
			taskService.deleteMilestone(id);
		}
		catch(Exception e)
		{
			return "Error";
		}
		
		return "Success";
    }
	
	// Controllers for task user ------------------------------------------------------------------------------------------------
	
	@RequestMapping(value = "/getAllTaskUsers", method = RequestMethod.GET)
    List<TaskUser> getAllTaskUsers(ModelMap model)
	{
		return taskService.getAllTaskUsers();
    }
	
	@RequestMapping(value = "/createTaskUser", method = RequestMethod.POST)
    String createTaskUser(@Valid @ModelAttribute("taskuser") TaskUser taskUser, BindingResult result, ModelMap model)
	{
		TaskUser createdTaskUser = taskService.createTaskUser(taskUser);
		
        return createdTaskUser != null ? "Success" : "Error";
    }
	
	@RequestMapping(value = "/updateTaskUser", method = RequestMethod.POST)
	public String updateTaskUser(@Valid @ModelAttribute("taskuser") TaskUser taskUser, BindingResult result, ModelMap model)
	{
		int updateResult = taskService.updateTaskUser(taskUser);
		
		return updateResult == 1 ? "Success" : "Error";
    }
	
	@RequestMapping(value = "/deleteTaskUser/{id}", method = RequestMethod.GET)
	public String deleteTaskUser(@PathVariable("id") int id, ModelMap model)
	{
		try
		{
			taskService.deleteTaskUser(id);;
		}
		catch(Exception e)
		{
			return "Error";
		}
		
		return "Success";
    }
}