package net.tina.MyTaskApp.entity;

import java.sql.Date;

import javax.persistence.*;

@Entity
@Table(name = "milestone")
public class Milestone
{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private int id;
    
    @Column(name = "name")
    private String name;
    
    @Column(name = "due_date")
    private Date dueDate;
    
    @Column(name = "state")
    private String state;
    
    public Milestone()
    {
    	
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }
}