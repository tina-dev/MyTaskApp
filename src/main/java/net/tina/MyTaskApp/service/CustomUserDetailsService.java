package net.tina.MyTaskApp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import net.tina.MyTaskApp.model.CustomUserDetails;
import net.tina.MyTaskApp.model.Users;
import net.tina.MyTaskApp.repository.UsersRepository;

import java.util.Optional;

@Service
public class CustomUserDetailsService implements UserDetailsService
{
    @Autowired
    private UsersRepository usersRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException
    {
        Optional<Users> optionalUsers = usersRepository.findByUsername(username);

        optionalUsers
                .orElseThrow(() -> new UsernameNotFoundException("Username not found"));
        return optionalUsers
                .map(CustomUserDetails::new).get();
    }
    
    public void registerNewUser(Users newUser)
    {
    	usersRepository.save(newUser);
    }
}