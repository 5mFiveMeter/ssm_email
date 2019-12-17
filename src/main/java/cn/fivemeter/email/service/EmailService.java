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
	
	//�����ʼ�
	public int save(Email email) {
		return emailMapper.insert(email);
	}
	//��ȡ���ʼ��б�����
	public int getSendEmailCount(Map map) {
		return emailMapper.getSendEmailCount(map);
	}
	//��ȡ���ʼ���ҳ�б�
	public List<Map> getSendEmailList(Map map) {
		return emailMapper.getSendEmailList(map);
	}
	
	//��ȡ���ʼ��б�����
	public int getReceiveEmailCount(Map map) {
		return emailMapper.getReceiveEmailCount(map);
	}
	//��ȡ���ʼ���ҳ�б�
	public List<Map> getReceiveEmailList(Map map) {
		return emailMapper.getReceiveEmailList(map);
	}
	
	
	//��ȡ�ʼ�
	public List<Email> getEmailList(Map map) {
		return emailMapper.select(map);
	}
	//�޸��ʼ�
	public int updateEmail(Object obj) {
		return emailMapper.update(obj);
	}
}

