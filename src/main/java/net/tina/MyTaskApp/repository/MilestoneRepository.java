package net.tina.MyTaskApp.repository;

import java.sql.Date;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import net.tina.MyTaskApp.entity.Milestone;
@Repository
public interface MilestoneRepository extends JpaRepository<Milestone, Integer>
{
	@Transactional
	@Modifying(clearAutomatically = true)
    @Query(value = "UPDATE milestone m SET m.name = :name, "
    		+ "m.due_date = :due_date, "
    		+ "m.state = :state WHERE m.id = :id", nativeQuery = true)
    public int updateMilestone(	@Param("id") int id, 
    						@Param("name") String name, 
    						@Param("due_date") Date due_date, 
    						@Param("state") String state);
}