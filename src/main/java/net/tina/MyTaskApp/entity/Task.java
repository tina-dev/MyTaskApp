package net.tina.MyTaskApp.entity;

import java.sql.Date;

import javax.persistence.*;

@Entity
@Table(name = "task")
public class Task
{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private int id;
    
    @Column(name = "name")
    private String name;
    
    @Column(name = "description")
    private String description;
    
    @Column(name = "assigned_time_budget")
    private Float assignedTimeBudget;
    
    @Column(name = "used_time_budget")
    private Float usedTimeBudget;
    
    @Column(name = "state")
    private String state;
    
    @Column(name = "scheduled_date")
    private Date scheduledDate;
    
    @Column(name = "completion_date")
    private Date completionDate;
    
    @Column(name = "parent_id")
    private int parentId;
    
    @Column(name = "milestone_id")
    private int milestoneId;
    
    @Column(name = "created_by")
    private int createdBy;

    public Task()
    {
    	
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Float getAssignedTimeBudget() { return assignedTimeBudget; }
    public void setAssignedTimeBudget(Float assignedTimeBudget) { this.assignedTimeBudget = assignedTimeBudget; }

    public Float getUsedTimeBudget() { return usedTimeBudget; }
    public void setUsedTimeBudget(Float usedTimeBudget) { this.usedTimeBudget = usedTimeBudget; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public Date getScheduledDate() { return scheduledDate; }
    public void setScheduledDate(Date scheduledDate) { this.scheduledDate = scheduledDate; }

    public Date getCompletionDate() { return completionDate; }
    public void setCompletionDate(Date completionDate) { this.completionDate = completionDate; }

    public int getParentId() { return parentId; }
    public void setParentId(int parentId) { this.parentId = parentId; }

    public int getMilestoneId() { return milestoneId; }
    public void setMilestoneId(int milestoneId) { this.milestoneId = milestoneId; }

    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }
}