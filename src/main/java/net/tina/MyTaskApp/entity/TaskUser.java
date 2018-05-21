package net.tina.MyTaskApp.entity;

import javax.persistence.*;

@Entity
@Table(name = "task_user")
public class TaskUser
{
	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private int id;
    
    @Column(name = "user_id")
    private int userId;
    
    @Column(name = "task_id")
    private int taskId;

    public TaskUser()
    {
    	
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getTaskId() { return taskId; }
    public void setTaskId(int taskId) { this.taskId = taskId; }
}