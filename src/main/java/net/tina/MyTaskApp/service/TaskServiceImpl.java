package net.tina.MyTaskApp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.tina.MyTaskApp.entity.Task;
import net.tina.MyTaskApp.repository.TaskRepository;

@Service
public class TaskServiceImpl implements TaskService
{
	@Autowired
    private TaskRepository taskRepository;
	
	@Override
	public List<Task> getAllTasks()
	{
		return taskRepository.findAll();
	}
	
	@Override
	public Task createTask(Task task)
	{
		return taskRepository.save(task);
	}
	
	@Override
	public int updateTask(Task task)
	{
		return taskRepository.updateTask(task.getId(), 
				task.getName(), 
				task.getDescription(), 
				task.getAssignedTimeBudget(), 
				task.getUsedTimeBudget(), 
				task.getState(), 
				task.getScheduledDate(), 
				task.getCompletionDate(), 
				task.getParentId(), 
				task.getMilestoneId(), 
				task.getCreatedBy());
	}
	
	@Override
	public void deleteTask(int id)
	{
		taskRepository.deleteById(id);
	}
}