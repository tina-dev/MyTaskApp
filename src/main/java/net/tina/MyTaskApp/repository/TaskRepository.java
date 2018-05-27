package net.tina.MyTaskApp.repository;
import java.sql.Date;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import net.tina.MyTaskApp.entity.Task;

@Repository
public interface TaskRepository extends JpaRepository<Task, Integer>
{
	@Query(value = "SELECT * from task t WHERE t.id = :id", nativeQuery = true)
	public List<Task> findTasksByUserId(@Param("id") int id);
	
	@Transactional
	@Modifying(clearAutomatically = true)
    @Query(value = "UPDATE task t SET t.name = :name, "
    		+ "t.description = :description, "
    		+ "t.assigned_time_budget = :assigned_time_budget, "
    		+ "t.used_time_budget = :used_time_budget, "
    		+ "t.state = :state, "
    		+ "t.scheduled_date = :scheduled_date, "
    		+ "t.completion_date = :completion_date, "
    		+ "t.parent_id = :parent_id, "
    		+ "t.milestone_id = :milestone_id, "
    		+ "t.created_by = :created_by WHERE t.id = :id", nativeQuery = true)
    public int updateTask(	@Param("id") int id, 
    						@Param("name") String name, 
    						@Param("description") String description, 
    						@Param("assigned_time_budget") Float assigned_time_budget, 
    						@Param("used_time_budget") Float used_time_budget, 
    						@Param("state") String state, 
    						@Param("scheduled_date") Date scheduled_date, 
    						@Param("completion_date") Date completion_date, 
    						@Param("parent_id") int parent_id, 
    						@Param("milestone_id") int milestone_id, 
    						@Param("created_by") int created_by);
	
	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "DELETE from task t WHERE t.milestone_id = :id", nativeQuery = true)
	public void deleteMilestonesFromTasks(@Param("id") int id);
	
	@Transactional
	@Modifying(clearAutomatically = true)
	@Query(value = "UPDATE task t SET t.milestone_id = :milestone_id WHERE t.id = :id", nativeQuery = true)
	public int assignTask(@Param("id") int id, @Param("milestone_id") int milestone_id);
}