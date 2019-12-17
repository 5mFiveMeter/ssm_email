import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.Test;


public class TestConnection {
	@Test
	public void dododo() throws SQLException {
		Connection cc=TestConnection.this.getConnection();
		
		if(!cc.isClosed())
 
		System.out.println("Succeeded connecting to the Database!");
		Statement statement = cc.createStatement();
		String sql = "select * from users";
		ResultSet rs = statement.executeQuery(sql);
		while(rs.next()) {
			System.out.println(rs.getString("id")+"");
		}

	}
	
	
	
	public Connection getConnection() {
		String driver="com.mysql.jdbc.Driver";   //��ȡmysql���ݿ��������
		String url="jdbc:mysql://127.0.0.1:3306/hzst_ssm?useSSL=false&characterEncoding=utf-8"; //�������ݿ⣨kucun�����ݿ�����
		String name="java";//����mysql���û���
		String pwd="123456";//����mysql������
		
		try{
			Class.forName(driver);
			Connection conn=DriverManager.getConnection(url,name,pwd);//��ȡ���Ӷ���
			return conn;
		}catch(ClassNotFoundException e){
			e.printStackTrace();
			return null;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}

		
		
	}
	
	
	public void closeAll(Connection conn,PreparedStatement ps,ResultSet rs){
		try{
			if(rs!=null){
				rs.close();
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		try{
			if(ps!=null){
				ps.close();
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		try{
			if(conn!=null){
				conn.close();
			}
		}catch(SQLException e){
			e.printStackTrace();	
		}
	}
	
	
	
	
}
