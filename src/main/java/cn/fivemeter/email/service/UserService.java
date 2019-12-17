package cn.fivemeter.email.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.fivemeter.email.bean.User;
import cn.fivemeter.email.dao.UserMapper;

@Service
public class UserService {
	
	@Autowired
	private UserMapper userMapper;
	
	public User login(String userName,String password) {
		Map map = new HashMap<String,String>();
		map.put("userName",userName);
		map.put("password",password);
		List<User> userList = userMapper.select(map);
		if(userList.size()>0) {
			return userList.get(0);
		}else {
			return  null;
		}
	}
	
	public List getUserTree() {
		List<HashMap> rsp_list = new ArrayList();
		List<User> rst = userMapper.select(new HashMap());
		for(User user : rst) {
			HashMap one = new HashMap<String,Object>();
			one.put("userName",user.getUserName());
			one.put("userId",user.getUserId());
			one.put("departId",user.getDepartId());
			one.put("departName",user.getDepartName());
			rsp_list.add(one);
		}
		return rsp_list;
	}
	
	public boolean update(Map map) {
		if(userMapper.update(map)>0) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean authExist(Map map) {
		List<User> userList =  userMapper.select(map);
		if(userList!=null && userList.size()>0) {
			return true;
		}else {
			return false;
		}
	}
	
	public int register(User user) {
		//用户查重 1成功 2用户重复3未知错误
		Map map = new HashMap<String,String>();
		map.put("userName",user.getUserName());
		List<User> userList = userMapper.select(map);
		if(userList.size()>0) {
			return 2; //用户已存在
		}else if(userMapper.insert(user)>0) {
			return 1; //注册成功
		}else {
			return 3; //注册失败
		}
	}
}
