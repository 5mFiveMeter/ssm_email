package cn.fivemeter.email.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.fivemeter.email.bean.Email;
import cn.fivemeter.email.dao.EmailMapper;

@Service
public class EmailService {

	@Autowired
	private EmailMapper emailMapper;
	
	//保存邮件
	public int save(Email email) {
		return emailMapper.insert(email);
	}
	//获取发邮件列表数量
	public int getSendEmailCount(Map map) {
		return emailMapper.getSendEmailCount(map);
	}
	//获取发邮件分页列表
	public List<Map> getSendEmailList(Map map) {
		return emailMapper.getSendEmailList(map);
	}
	
	//获取收邮件列表数量
	public int getReceiveEmailCount(Map map) {
		return emailMapper.getReceiveEmailCount(map);
	}
	//获取收邮件分页列表
	public List<Map> getReceiveEmailList(Map map) {
		return emailMapper.getReceiveEmailList(map);
	}
	
	
	//获取邮件
	public List<Email> getEmailList(Map map) {
		return emailMapper.select(map);
	}
	//修改邮件
	public int updateEmail(Object obj) {
		return emailMapper.update(obj);
	}
}

