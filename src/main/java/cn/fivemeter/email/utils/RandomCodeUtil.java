package cn.fivemeter.email.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RandomCodeUtil {
	public static final String SESSION_KEY = "random_code";
	private Random random = new Random();
	private String randomStringRange = "0123456789ZXCVBNMASDFGHJKLQWERTYUIP";
	
	private int width = 80;
	private int height = 40;
	private int codeSize = 18;
	private int codeNum = 5;
	private int missLine = 3;
	
	
	
	public int getCodeSize() {
		return codeSize;
	}

	public RandomCodeUtil setCodeSize(int width) {
		this.codeSize = codeSize;
		return this;
	}
	
	public int getWidth() {
		return width;
	}

	public RandomCodeUtil setWidth(int width) {
		this.width = width;
		return this;
	}

	public int getHeight() {
		return height;
	}

	public RandomCodeUtil setHeight(int height) {
		this.height = height;
		return this;
	}

	public int getMissLine() {
		return missLine;
	}

	public RandomCodeUtil setMissLine(int missLine) {
		this.missLine = missLine;
		return this;
	}

	public int getCodeNum() {
		return codeNum;
	}

	public RandomCodeUtil setCodeNum(int codeNum) {
		this.codeNum = codeNum;
		return this;
	}

	/*
	 *  ���ͼƬ
	 */
	public void getRandCode(HttpServletRequest request,HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
		
		Graphics g = image.getGraphics();
		g.fillRect(0, 0, width, height);
		g.setFont(new Font("Times NEW Roman",Font.ROMAN_BASELINE,codeSize));
		//�����߻���
		for(int i=0;i<missLine;i++) {
			drowMissLine(g);
		}
		//��������ַ���
		String randomString = "";
		for(int i=0;i<codeNum;i++) {
			randomString = drowString(g,randomString,i);
		}
		//����session
		session.removeAttribute(SESSION_KEY);
		session.setAttribute(SESSION_KEY,randomString);
		g.dispose();
		//����ͼƬ
		try {
			ImageIO.write(image, "JPEG", response.getOutputStream());
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/*
	 * ����
	 */
	private Font getFont() {
		return new Font("Fixedsys",Font.CENTER_BASELINE,18);
	}
	
	/*
	 * ��ɫ���
	 */
	private Color getRandColor() {
		return new Color(random.nextInt(255),random.nextInt(255),random.nextInt(255));
	}
	
	
	/*
	 * ����ַ���ȡ
	 */
	private String getRandomString() {
		return String.valueOf(randomStringRange.charAt(random.nextInt(randomStringRange.length())));
	}
	
	/*
	 * �ַ�������
	 */
	private String drowString(Graphics g,String randomString,int i) {
		g.setFont(getFont());
		g.setColor(getRandColor());
		String rand = getRandomString();
		randomString += rand;
		//��λ��ĸ���½�λ��
		g.drawString(rand, random.nextInt(width/(codeNum+1)), codeSize + random.nextInt(height-codeSize));
		//�������Ͻ�������ԭ��ƫ��
		g.translate(width/(codeNum+1), 0);
		return randomString;
	}
	
	/*
	 * �����߻���
	 */
	private void drowMissLine(Graphics g) {
		g.setColor(getRandColor());
		int x1 = random.nextInt(width);
		int y1 = random.nextInt(height);
		int x2 = random.nextInt(width/5);
		int y2 = random.nextInt(height);
		g.drawLine(x1, y1, x2, y2);
	}
}
