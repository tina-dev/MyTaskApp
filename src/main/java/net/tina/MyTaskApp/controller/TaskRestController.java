package net.tina.MyTaskApp.controller;

import java.util.List;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import net.tina.MyTaskApp.entity.Task;
import net.tina.MyTaskApp.service.TaskService;

@RestController
@RequestMapping("/task")
public class TaskRestController
{
	@Autowired
	private TaskService taskService;
	
	@RequestMapping(value = "/getAllTasks", method = RequestMethod.GET)
    List<Task> getAllTasks(ModelMap model)
	{
		return taskService.getAllTasks();
    }
	
	@RequestMapping(value = "/createTask", method = RequestMethod.POST)
    String createTask(@Valid @ModelAttribute("task") Task task, BindingResult result, ModelMap model)
	{
        if (result.hasErrors())
        {
            return "Error";
        }
        
		Task createdTask = taskService.createTask(task);
		
        return createdTask != null ? "Success" : "Error";
    }
	
	@RequestMapping(value = "/updateTask", method = RequestMethod.POST)
	public String updateTask(@Valid @ModelAttribute("task") Task task, BindingResult result, ModelMap model)
	{
		if (result.hasErrors())
        {
            return "Error";
        }
		
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
}