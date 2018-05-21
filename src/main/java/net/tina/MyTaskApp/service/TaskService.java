package net.tina.MyTaskApp.service;
import java.util.List;
import net.tina.MyTaskApp.entity.Task;

public interface TaskService
{
	public List<Task> getAllTasks();
	
	public Task createTask(Task task);
	
	public int updateTask(Task task);
	
	public void deleteTask(int id);
}