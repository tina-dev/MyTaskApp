package net.tina.MyTaskApp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.tina.MyTaskApp.entity.Milestone;
import net.tina.MyTaskApp.entity.Task;
import net.tina.MyTaskApp.entity.TaskUser;
import net.tina.MyTaskApp.repository.MilestoneRepository;
import net.tina.MyTaskApp.repository.TaskRepository;
import net.tina.MyTaskApp.repository.TaskUserRepository;

@Service
public class TaskServiceImpl implements TaskService
{
	@Autowired
    private TaskRepository taskRepository;
	
	@Autowired
    private MilestoneRepository milestoneRepository;
	
	@Autowired
	private TaskUserRepository taskUserRepository;
	
	@Override
	public List<Task> getAllTasks()
	{
		return taskRepository.findAll();
	}
	
	@Override
	public List<Task> getTasksByUserId(int id)
	{
		return taskRepository.findTasksByUserId(id);
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

	@Override
	public List<Milestone> getAllMilestones()
	{
		return milestoneRepository.findAll();
	}
	
	@Override
	public Milestone createMilestone(Milestone milestone)
	{
		return milestoneRepository.save(milestone);
	}
	
	@Override
	public int updateMilestone(Milestone milestone)
	{
		return milestoneRepository.updateMilestone(milestone.getId(), 
				milestone.getName(), 
				milestone.getDueDate(), 
				milestone.getState());
	}
	
	@Override
	public void deleteMilestone(int id)
	{
		milestoneRepository.deleteById(id);
	}
	
	@Override
	public List<TaskUser> getAllTaskUsers()
	{
		return taskUserRepository.findAll();
	}
	
	@Override
	public TaskUser createTaskUser(TaskUser taskUser)
	{
		return taskUserRepository.save(taskUser);
	}
	
	@Override
	public int updateTaskUser(TaskUser taskUser)
	{
		return taskUserRepository.updateTaskUser(taskUser.getId(), taskUser.getUserId(), taskUser.getTaskId());
	}
	
	@Override
	public void deleteTaskUser(int id)
	{
		taskUserRepository.deleteById(id);
	}
}