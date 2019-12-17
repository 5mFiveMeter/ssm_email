<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>杭州思达智慧协同办公</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
	<style>
		.container{
			width: 100%;
			height: 100%;
			background: url("${pageContext.request.contextPath}/static/images/login_bg.png") no-repeat;
			background-position: center;
			background-size: cover;
			overflow: hidden;
		}
		.login_footer{
			position: absolute;
			bottom: 0;
			width: 100%;
			padding: 10px 0;
		}
		.cpy_logo{
			float: left;
			margin: 30px 0 0 50px;
			background: url("${pageContext.request.contextPath}/static/images/logo_02.png") no-repeat;
			background-position: center;
			background-size: cover;
			width: 190px;
			height: 43px;
		}
		.login_container{
			margin: 200px auto 0;
			width: 420px;
			height: 380px;
			border-radius: 5px;
			background: #fff;
			overflow: hidden;
		}
		.top_info{ 
			width: 250px;
			height: 50px;
			margin:80px auto 30px;
			background: url("${pageContext.request.contextPath}/static/images/logo_03.png") no-repeat;
			background-position: center;
			background-size:contain;
		}
		.username_box,.password_box,.verify_box{
			position: relative;
			width: 270px;
			height: 55px;
			margin: 0 auto;
		}
		.username_box input,.password_box input,.verify_box input{
			width: 230px;
			height:40px;
			border:1px solid #000;
			padding-left: 40px;
			font-size: 16px;
		}
		.username_box img,.password_box img,.verify_box img{
			position:absolute;
			top: 12px;
			left: 10px;
			width: 20px;height: 20px;
			object-fit: contain;
    		object-position: center;
		}
		#verify_img{
			position: absolute;
			right: 3px;
			left:unset;
			top: 6px;
			width:115px;
			height: 30px;
			user-select: none;
			cursor:pointer;
		}
		.btn_container{
			text-align: center;
		}
		#login_btn{
			width: 100px;
			padding: 5px 15px;
			height:40px;
		}
		#register_btn{
			margin-left: 15px;
			width: 100px;
			height:40px;
		}
		#register_container{
			display:none;
			position: fixed;
			top: 0;right:0;bottom:0;left: 0;
			background: rgba(0,0,0,0.4);
			z-index: 1996;
			transition:transform 3s ease;
		}
		#info_panel{
			width: 520px;
			height: 310px;
			margin: 230px auto 0;
			border-radius: 2px;
			position: relative;
		}
		.close_register{
			position: absolute;
			top: 2px;
			right:5px;
			color: red;
			font-size: 12px;
			cursor: pointer;
		}
		#info_panel table{
			border: none;
		}
		#info_panel table td{
			border: none;
		}
		#photo{
			display: block;
			width: 130px;
			height: 130px;
			margin: 0 auto 15px;
		}
		.register_tip{
			font-size: 12px;
    		color: #e2e2e2;
		}
	</style>
</head>
<body>

	<div class="container">
		<div class="cpy_logo"></div>
		
		<div class="login_container">
			<div class="top_info"></div>
			<div class="username_box">
				<img src="${pageContext.request.contextPath}/static/images/person_icon.png">
				<input type="text" placeholder="用户名" id="user_name">
			</div>
			<div class="password_box">
				<img src="${pageContext.request.contextPath}/static/images/lock_icon.png">
				<input type="password" placeholder="密码" id="user_pass">
			</div>
			<div class="verify_box">
				<img src="${pageContext.request.contextPath}/static/images/verify_icon.png">
				<input type="text" placeholder="请输入验证码" id="verify_code">
				<img onclick="this.src+='?'" src="${pageContext.request.contextPath}/tool/randomCode" id="verify_img">
			</div>
			<div class="btn_container">
				<button class="fm_btn" id="login_btn">登录</button>
				<button class="fm_btn_raw" id="register_btn">注册</button>
			</div>
		</div>
		
		<div class="login_footer bg_theme_blue">
			<p>版权所有C 1999-2019 杭州思达电子科技发展有限公司</p>
		</div>
		
	</div>
	
	<div id="register_container">
		<div id="info_panel" class="fm_bdc">
			<div class="close_register">x</div>
			<p class="box_padding_xl fm_bdb">
				<button class="fm_btn" id="register_user">注册用户</button>
			</p>
			<div class="box_padding_xl">
				<table>
					<tr>
						<td class="box_padding_xxl fm_text_center fm_require">昵 称</td>
						<td class="box_padding_xxl">
							<input class="layui-input" id="register_name">
							<p class="box_padding_xxl register_tip">请输入1-16个字符</p>
						</td>
						<td rowspan="5" class="fm_text_center">
							<img id="photo" src="${pageContext.request.contextPath}/static/images/male_photo.png">
							<button class="fm_btn" id="upload_photo">上传头像</button>
						</td>
					</tr>
					<tr>
						<td class="box_padding_xxl fm_text_center fm_require">密 码</td>
						<td class="box_padding_xxl">
							<input class="layui-input" id="register_pass" type="password">
							<p class="box_padding_xxl register_tip">请输入1-20个字符</p>
						</td>						
					</tr>
					<tr>
						<td class="box_padding_xxl fm_text_center">性 别</td>
						<td class="box_padding_xxl">
							<label style="margin-right: 10px;">
								<img style="vertical-align:sub;width:25px;height:25px;" src="${pageContext.request.contextPath}/static/images/male.png">
								<input checked style="width:17px;height:17px;" type="radio" name="sex" value="男">
							</label>
							<label>
								<img style="vertical-align:sub;width:25px;height:25px;" src="${pageContext.request.contextPath}/static/images/female.png">
								<input style="width:17px;height:17px;" type="radio" name="sex" value="女">
							</label>
						</td>				
					</tr>
					<tr>
						<td class="box_padding_xxl fm_text_center">生 日</td>
						<td class="box_padding_xxl">
							<input type="text" class="layui-input" id="birth">
						</td>				
					</tr>
					<tr>
						<td class="box_padding_xxl fm_text_center">电 话</td>
						<td class="box_padding_xxl">
							<input id="phone" class="layui-input" />
						</td>				
					</tr>
				</table>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
	<script type="text/javascript">
		layui.use(["jquery","layer","laydate"],function(){
			window.$ = layui.$;
			window.layer = layui.layer;
			window.laydate = layui.laydate;
			
			//生日选择控件
			laydate.render({
				elem:"#birth",
				zIndex:2000
			});
			//空值校验
			function checkEmpty(){
				if(!$("#user_name").val()){
					layer.msg("请填写用户名",{
						icon:2,
						time:2000
					})
					return false
				}else if(!$("#user_pass").val()){
					layer.msg("请填写密码",{
						icon:2,
						time:2000
					})
					return false
				}else if(!$("#verify_code").val()){
					layer.msg("请输入验证码",{
						icon:2,
						time:2000
					})
					return false
				}else{
					return true
				}
			}
			//登录
			function login(){
				$.ajax({
					url:"${pageContext.request.contextPath}/user/login",
					type:"POST",
					data:{
						userName:$("#user_name").val(),
						password:$("#user_pass").val(),
						verifyCode:$("#verify_code").val()
					},
					success:function(rsp){
						if(rsp.code==200){
							//本地存储
							localStorage.setItem("user",JSON.stringify(rsp.data));
							layer.msg("登录成功",{
								icon:1,
								time:1000,
								end:function(){
									window.location.href="${pageContext.request.contextPath}/email/receive";
									
								}
							})
							
						}else{
							layer.msg(rsp.msg,{
								icon:2,
								time:2000
							});
							$("#verify_img").click();
						}
					}
				})
			}
			//注册面板弹出
			function showRegister(){
				$("#register_container").css("display","block");
			}
			//注册面板关闭
			function hiddenRegister(){
				$("#register_container").css("display","none");
				//清空面板数据
				$("#register_name").val("");
				$("#register_pass").val("");
				$("#birth").val("");
				$("#phone").val("");
				$("input[name=sex][value=男]").click();
			}
			//点击登陆
			$("#login_btn").on("click",function(){
				checkEmpty() && login();
			});
			//点击注册
			$("#register_btn").on("click",function(evt){
				showRegister();
			});
			$("#info_panel").on("click",function(evt){
				//阻止事件冒泡关闭注册层
				evt.stopPropagation();
			});
			//关闭注册
			$("#register_container").on("click",function(){
				hiddenRegister();
			});
			$(".close_register").on("click",function(){
				hiddenRegister();
			});
			//判断是否上传头像
			var had_photo = false
			//头像性别切换
			$("[name=sex]").on("click",function(){
				if(!had_photo && $(this).val()=="男"){
					$("input[name=sex][value=男]").attr("checked","");
					$("input[name=sex][value=女]").removeAttr("checked");
					$("#photo").attr("src","${pageContext.request.contextPath}/static/images/male_photo.png");
				}else if(!had_photo && $(this).val()=="女"){
					$("input[name=sex][value=男]").removeAttr("checked");
					$("input[name=sex][value=女]").attr("checked","");
					$("#photo").attr("src","${pageContext.request.contextPath}/static/images/female_photo.png");
				}
			});
			//注册校验
			function registerCheck(){
				//昵称
				var register_name = $("#register_name").val();
				//密码
				var register_pass = $("#register_pass").val();
				//生日
				var register_birth = $("#birth").val();
				//电话
				var register_phone = $("#phone").val();
				if(register_name==""){
					layer.msg("请填写昵称",{icon:2,time:1000,zIndex:2019})
					return false;
				}else if(register_name.length>16){
					layer.msg("昵称请填写1-16字符",{icon:2,time:1000,zIndex:2019})
					return false;
				}else if (register_pass=="") {
					layer.msg("请填写密码",{icon:2,time:1000,zIndex:2019})
					return false;
				}else if (register_pass.length>20) {
					layer.msg("密码请填写1-20字符",{icon:2,time:1000,zIndex:2019})
					return false;
				}else if (register_birth.length>10) {
					layer.msg("生日请填写错误",{icon:2,time:1000,zIndex:2019})
					return false;
				}else if (register_phone.length>18) {
					layer.msg("填写电话过长",{icon:2,time:1000,zIndex:2019})
					return false;
				}else{
					return true;
				}
			}
			//注册事件
			var register_loading = false
			$("#register_user").on("click",function(){
				//防止重复提交
				if(register_loading){
					return ;
				}else{
					register_loading=true;
				}
				if(registerCheck()){
					var params = {
						userName:$("#register_name").val(),
						password:$("#register_pass").val(),
						sex:$("input[name=sex][checked]").val(),
						birth:$("#birth").val(),
						mobile:$("#phone").val(),
						photo:$("#photo").attr("src")
					}
					$.ajax({
						url:"${pageContext.request.contextPath}/user/doRegister",
						data:params,
						type:"POST",
						success:function(rsp){
							if(rsp.code==200){
								layer.msg("注册成功",{icon:1,time:1000,zIndex:2019,end:function(){
									//数据放入登录框
									$("#user_name").val($("#register_name").val());
									$("#user_pass").val($("#register_pass").val());
									//关闭注册层
									hiddenRegister();
								}});
							}else{
								layer.msg(rsp.msg,{icon:2,time:1000,zIndex:2019})
							}
						},
						complete:function(){
							register_loading=false;
						}
					});
				}
			});
			//Enter键登陆
			$(window).keydown(function(event){
				if(event.keyCode==13){
					checkEmpty() && login();
				}
			})
			
		})
	</script>
	
</body>

</html>