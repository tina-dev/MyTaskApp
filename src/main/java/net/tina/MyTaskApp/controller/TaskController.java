package net.tina.MyTaskApp.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TaskController
{
	@RequestMapping(value = {"/task", "/welcome"}, method = RequestMethod.GET)
	public String getTaskPage()
	{
		return "task";
	}
	
	@PreAuthorize("hasAnyRole('ADMIN')")
	@RequestMapping(value = {"/admin"}, method = RequestMethod.GET)
	public String getAdminPage()
	{
		return "admin";
	}
}