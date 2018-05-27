package net.tina.MyTaskApp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;

import net.tina.MyTaskApp.entity.Milestone;
import net.tina.MyTaskApp.entity.Task;
import net.tina.MyTaskApp.entity.TaskUser;
import net.tina.MyTaskApp.model.Users;
import net.tina.MyTaskApp.service.TaskService;

@Controller
public class TaskController
{
	@Autowired
	private TaskService taskService;
	
	@RequestMapping(value = {"/task", "/welcome"}, method = RequestMethod.GET)
	public String getTaskPage()
	{
		return "task";
	}
	
	@PreAuthorize("hasAnyRole('ADMIN')")
	@RequestMapping(value = {"/admin"}, method = RequestMethod.GET)
	public String getAdminPage(Model model)
	{
		List<Task> allTasks = taskService.getAllTasks();
		List<Milestone> allMilestones = taskService.getAllMilestones();
		
		model.addAttribute("allMilestones", allMilestones);
		model.addAttribute("allTasks", allTasks);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonTasks = "";
		try
		{
			jsonTasks = mapper.writeValueAsString(allTasks);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		model.addAttribute("tasks", jsonTasks);
		
		String jsonMilestones = "";
		try
		{
			jsonMilestones = mapper.writeValueAsString(allMilestones);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		model.addAttribute("milestones", jsonMilestones);
		
		return "admin";
		
	}
	
	// Controllers for tasks ----------------------------------------------------------------------------------------------------
	
	@RequestMapping(value = "/admin/createTask", method = RequestMethod.POST)
    public String createTask(@Valid @ModelAttribute("task") Task task, BindingResult result, ModelMap model, Authentication authentication)
	{
        //if (result.hasErrors()) return "Error";
		
		if(authentication != null)
		{
			Users userDetails = (Users) authentication.getPrincipal();
			task.setCreatedBy(userDetails.getId());
		}
        
		Task createdTask = taskService.createTask(task);
		
        return createdTask != null ? "redirect:/admin?success" : "redirect:/admin?error";
    }
	
	@RequestMapping(value = "/admin/updateTask", method = RequestMethod.POST)
	public String updateTask(@Valid @ModelAttribute("task") Task task, BindingResult result, ModelMap model)
	{
		int updateResult = taskService.updateTask(task);
		
		return updateResult == 1 ? "redirect:/admin?success" : "redirect:/admin?error";
    }
	
	@RequestMapping(value = "/admin/deleteTask", method = RequestMethod.POST)
	public String deleteTask(@Valid @ModelAttribute("task") Task task, BindingResult result, ModelMap model)
	{
		try
		{
			taskService.deleteTask(task.getId());
		}
		catch(Exception e)
		{
			return "redirect:/admin?error";
		}
		
		return "redirect:/admin?success";
    }
	
	// Controllers for milestones -----------------------------------------------------------------------------------------------
	
	@RequestMapping(value = "/admin/createMilestone", method = RequestMethod.POST)
    public String createMilestone(@Valid @ModelAttribute("milestone") Milestone milestone, BindingResult result, ModelMap model, HttpServletRequest request)
	{		
		Milestone createdMilestone = taskService.createMilestone(milestone);
		
		if(createdMilestone != null)
		{
			try
			{
				String[] assignedTaskIds = request.getParameterValues("assignedTasksList[]");
				
				for(String assignedTaskId : assignedTaskIds)
				{
					taskService.assignTask(Integer.parseInt(assignedTaskId), createdMilestone.getId());
				}
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());
			}
		}
		
        return createdMilestone != null ? "redirect:/admin?success" : "redirect:/admin?error";
    }
	
	@RequestMapping(value = "/admin/updateMilestone", method = RequestMethod.POST)
	public String updateMilestone(@Valid @ModelAttribute("milestone") Milestone milestone, BindingResult result, ModelMap model, HttpServletRequest request)
	{
		try
		{
			taskService.deleteMilestonesFromTasks(milestone.getId());
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		
		int updateResult = taskService.updateMilestone(milestone);
		
		String[] assignedTaskIds = request.getParameterValues("assignedTasksList[]");
		for(String assignedTaskId : assignedTaskIds)
		{
			taskService.assignTask(Integer.parseInt(assignedTaskId), milestone.getId());
		}
		
		return updateResult == 1 ? "redirect:/admin?success" : "redirect:/admin?error";
    }
	
	@RequestMapping(value = "/admin/deleteMilestone", method = RequestMethod.POST)
	public String deleteMilestone(@Valid @ModelAttribute("milestone") Milestone milestone, BindingResult result, ModelMap model)
	{
		try
		{
			taskService.deleteMilestone(milestone.getId());
		}
		catch(Exception e)
		{
			return "redirect:/admin?success";
		}
		
		return "redirect:/admin?error";
    }
	
	// Controllers for task user ------------------------------------------------------------------------------------------------
	
	@RequestMapping(value = "/admin/createTaskUser", method = RequestMethod.POST)
    public String createTaskUser(@Valid @ModelAttribute("taskuser") TaskUser taskUser, BindingResult result, ModelMap model)
	{
		TaskUser createdTaskUser = taskService.createTaskUser(taskUser);
		
        return createdTaskUser != null ? "redirect:/admin?success" : "redirect:/admin?error";
    }
	
	@RequestMapping(value = "/admin/updateTaskUser", method = RequestMethod.POST)
	public String updateTaskUser(@Valid @ModelAttribute("taskuser") TaskUser taskUser, BindingResult result, ModelMap model)
	{
		int updateResult = taskService.updateTaskUser(taskUser);
		
		return updateResult == 1 ? "redirect:/admin?success" : "redirect:/admin?error";
    }
}