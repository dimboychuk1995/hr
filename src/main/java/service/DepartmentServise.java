package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.DepartmentDAO;
import domain.Department;

@Service
public class DepartmentServise {

	@Autowired
	private DepartmentDAO departmentDAO; 
	
	@Transactional
	public Department listDepartment() {
		return departmentDAO.listDepartment();
	}

}
