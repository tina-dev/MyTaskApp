package net.tina.MyTaskApp.service;

import java.util.List;

import net.tina.MyTaskApp.entity.Milestone;
import net.tina.MyTaskApp.entity.Task;
import net.tina.MyTaskApp.entity.TaskUser;

public interface TaskService
{
	public List<Task> getAllTasks();
	
	public List<Task> getTasksByUserId(int id);
	
	public Task createTask(Task task);
	
	public int updateTask(Task task);
	
	public void deleteTask(int id);
	
	public List<Milestone> getAllMilestones();
	
	public Milestone createMilestone(Milestone milestone);
	
	public int updateMilestone(Milestone milestone);
	
	public void deleteMilestone(int id);
	
	public void deleteMilestonesFromTasks(int id);
	
	public void assignTask(int taskId, int milestoneId);
	
	public List<TaskUser> getAllTaskUsers();
	
	public TaskUser createTaskUser(TaskUser taskUser);
	
	public int updateTaskUser(TaskUser taskUser);
	
	public void deleteTaskUser(int id);
}