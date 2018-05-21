package net.tina.MyTaskApp.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import net.tina.MyTaskApp.entity.TaskUser;

@Repository
public interface TaskUserRepository extends JpaRepository<TaskUser, Integer>
{
	@Transactional
	@Modifying(clearAutomatically = true)
    @Query(value = "UPDATE task_user t SET t.user_id = :user_id, t.task_id = :task_id WHERE t.id = :id", nativeQuery = true)
    public int updateTaskUser(	@Param("id") int id, 
    						@Param("user_id") int user_id, 
    						@Param("task_id") int task_id);
}