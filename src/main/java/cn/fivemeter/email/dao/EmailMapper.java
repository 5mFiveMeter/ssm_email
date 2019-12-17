package cn.fivemeter.email.dao;

import java.util.List;
import java.util.Map;

import cn.fivemeter.email.bean.Email;

public interface EmailMapper {
	
	/*保存邮件*/
	int insert(Email email);
	//发信件总数
	int getSendEmailCount(Map map);
	//发信件分页列表
	List<Map> getSendEmailList(Map map);
	
	//收信件总数
	int getReceiveEmailCount(Map map);
	//收信件分页列表
	List<Map> getReceiveEmailList(Map map);
	
	//查找
	List<Email> select(Map map);
	//更新
	int update(Object obj);
}
