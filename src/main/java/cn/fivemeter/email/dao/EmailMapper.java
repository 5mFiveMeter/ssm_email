package cn.fivemeter.email.dao;

import java.util.List;
import java.util.Map;

import cn.fivemeter.email.bean.Email;

public interface EmailMapper {
	
	/*�����ʼ�*/
	int insert(Email email);
	//���ż�����
	int getSendEmailCount(Map map);
	//���ż���ҳ�б�
	List<Map> getSendEmailList(Map map);
	
	//���ż�����
	int getReceiveEmailCount(Map map);
	//���ż���ҳ�б�
	List<Map> getReceiveEmailList(Map map);
	
	//����
	List<Email> select(Map map);
	//����
	int update(Object obj);
}
