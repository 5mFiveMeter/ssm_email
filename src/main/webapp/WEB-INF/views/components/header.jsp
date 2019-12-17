<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>杭州思达智慧协同办公</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/reset.css">

<style>
	.header{
		height: 60px;
	}
	.hzst_words{
		text-align: left;
		font-size: 30px;
		padding-top: 12px;
		padding-left: 10px;
	}
	.top_navigation{
		height: 40px;
		background: #fff;
		margin-bottom: 5px;
		position: relative;
	}
	.navigation_item{
		height: 100%;
		width: 120px;
		float: left;
		line-height: 35px;
		text-align: center;
		cursor: pointer;
		font-weight: 500;
	}
	.navigation_item a{
		display:inline-block;
		width: 100%;
		height:100%;
	}
	#navigation_bottom_bar{
		position: absolute;
		width: 80px;
		height:2px;
		position: absolute;
		bottom: 0;
		left: -80px;
		transition:left 0.3s ease;
	}
</style>
</head>
<body>
	<div class="header bg_theme_blue">
		<p class="hzst_words">思达智慧协同办公邮件</p>
		<p style="text-align: right;">
			<span id="user_name"></span>
			<span>,欢迎您!</span>
			<a href="/5m/login.jsp" style="margin:0 10px;font-size: 12px;">退出登录</a>
		</p>
		
	</div>
	<div class="top_navigation">
		<div id="reveice_navigation" class="navigation_item">
			<a href="${pageContext.request.contextPath}/email/receive">收件箱</a>
		</div>
		<div id="send_navigation" class="navigation_item">
			<a href="${pageContext.request.contextPath}/email/send">发件箱</a>
		</div>
		<div id="draft_navigation" class="navigation_item">
			<a href="${pageContext.request.contextPath}/email/draft">草稿箱</a>
		</div>
		<!-- 底部bar -->
		<div id="navigation_bottom_bar" class="bg_theme_blue"></div>
	</div>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
	<script type="text/javascript">
		layui.use(["jquery"],function(){
			window.$ = layui.$;
			//根据路由改变active
			$(window).ready(function(){
				switch (window.location.pathname) {
				case "/5m/email/receive":
					$("#navigation_bottom_bar").css("left","20px");
					break;
				case "/5m/email/send":
					$("#navigation_bottom_bar").css("left","140px");
					break;
				case "/5m/email/draft":
					$("#navigation_bottom_bar").css("left","260px");
					break;
				case "/5m/email/collect":
					$("#navigation_bottom_bar").css("left","380px");
					break;
				}
			});
			//拿到本地的用户信息
			window.user_info = JSON.parse(window.localStorage.getItem("user"));
			var token_exist = document.cookie.match(user_info.token);
			//本地存储的信息存在切token一致
			if(user_info == null || user_info.userName == false || token_exist == null || token_exist.length < 1){
				window.location.href="${pageContext.request.contextPath}";
			}else{
				$("#user_name").html(user_info.userName);
			}
		})
	</script>
</body>
</html>