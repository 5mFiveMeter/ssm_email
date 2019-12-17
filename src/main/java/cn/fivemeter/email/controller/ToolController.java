package cn.fivemeter.email.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.fivemeter.email.utils.RandomCodeUtil;

@Controller
@RequestMapping("/tool")
public class ToolController {
	
	@RequestMapping("randomCode")
	public void getRandomCode(HttpServletRequest request,HttpServletResponse response) throws Exception {
		//返回值类型
		response.setContentType("image/jpeg");
		//避免缓存
		response.setHeader("pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expire", 0);
		
		try {
			new RandomCodeUtil().setWidth(115).setHeight(30).getRandCode(request,response);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
