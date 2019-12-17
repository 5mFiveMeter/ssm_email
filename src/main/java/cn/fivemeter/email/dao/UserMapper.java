package cn.fivemeter.email.dao;

import java.util.List;
import java.util.Map;

import cn.fivemeter.email.bean.User;

public interface UserMapper {

	List<User> select(Map map);
	
	int update(Map map);
	
	int insert(User user);
}
