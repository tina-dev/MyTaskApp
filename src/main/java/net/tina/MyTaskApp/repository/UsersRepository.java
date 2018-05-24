package net.tina.MyTaskApp.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import net.tina.MyTaskApp.model.Users;
import java.util.Optional;

public interface UsersRepository extends JpaRepository<Users, Integer>
{
    Optional<Users> findByUsername(String username);
}