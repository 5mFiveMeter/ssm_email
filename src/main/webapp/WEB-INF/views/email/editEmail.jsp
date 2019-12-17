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
#receive_group{
	vertical-align: middle;
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
	display:inline-block;
	width: 400px;
	line-height: 38px;
}
</style>
</head>
<body>
	<div class="iframe_container">
	
		<div class="box_padding_xl fm_bdb">
			<button class="fm_btn" id="send_email">发 送</button>
			<button class="fm_btn" id="save_draft">保存草稿箱</button>
		</div>
		
		<div class="box_padding_xl">
			<table>
				<tr>
					<td class="bg_table_label">
						<span class="fm_require">收件人</span>
					</td>
					<td class="box_padding_xxl">
						<div class="layui-input" id="receive_group"></div>
						<button class="fm_btn bg_theme_green" id="clear_receive">清空</button>
					</td>
				</tr>
				<tr>
					<td class="bg_table_label">
						<span class="fm_require">主 题</span>
					</td>
					<td class="box_padding_xxl">
						<input class="layui-input" id="email_title">
					</td>
				</tr>
				<tr>
					<td class="bg_table_label">
						<span>附 件</span>
					</td>
					<td class="box_padding_xxl">
						<button class="fm_btn">上传附件</button>
					</td>
				</tr>
				<tr>
					<td class="bg_table_label">
						<span>邮件内容</span>
					</td>
					<td class="box_padding_xxl">
						<div id="content_edit">1</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
	
	<script type="text/javascript">
		layui.use(["layedit","jquery","layer"],function(){
			window.$ = layui.$
			window.layedit = layui.layedit
			window.layer = layui.layer;
			
			//收件人列表
			window.receive_group = []
			//树控件的回调
			window.treeCallback = function (index,data){
				if(index==0){
					var receive_name = [];
					console.log(data)
					$.each(data,function(k,v){
						receive_name.push(v.name);
						receive_group.push({
							receiveId:v.value,
							value:v.value,
							receiveName:v.name,
							name:v.name
						})
					})
					$("#receive_group").html(receive_name.join(","));
					layer.close(tree_index);
				}else if(index==1){
					layer.close(tree_index);
				}
			}
			//加载中
			var loading = false;
			//富文本编辑器
			var editorIndex = layedit.build("content_edit",{});
			
			//选人控件
			var tree_index
			//数据回显
			var init_email = parent.current_draft;
			if(init_email){
				//收件人
				var receive_ids = init_email.allReceiveId.split(",");
				var receive_names = init_email.allReceiveName.split(",");
				var temp_arr = [];
				$.each(receive_ids,function(k,v){
					temp_arr.push({
						receiveId:v,
						value:v,
						receiveName:receive_names[k],
						name:receive_names[k]
					});
				});
				window.treeCallback(0,temp_arr);
				//主题
				$("#email_title").val(init_email.title);
				//内容
				layedit.setContent(editorIndex,init_email.content,false);
			}
			//选人控件选择
			$("#receive_group").on("click",function(){
				var exist_id = [];
				$.each(receive_group,function(k,v){
					exist_id.push(v.receiveId);
				})
				tree_index = layer.open({
					type:2,
					title:"选择收件人",
					area:["550px","500px"],
					content:["${pageContext.request.contextPath}/user/selectTree?selectCount="+2,"no"]
				});
			});
			//收件人清空
			$("#clear_receive").on("click",function(){
				receive_group = [];
				$("#receive_group").html("");
				
			});
			//发送邮件监听
			$("#send_email").on("click",function(){
				var email_title = $("#email_title").val().trim();
				var email_content = layedit.getContent(editorIndex);
				console.log(receive_group)
				if(receive_group.length<1){
					layer.msg("请选择收件人",{icon:7,time:2000});
				}else if(email_title == ""){
					layer.msg("请填写主题",{icon:7,time:2000});
				}else{
					if(loading){return;}
					var ajax_param = {
						sendId:parent.user_info.userId,
						sendName:parent.user_info.userName,
						receiveList:receive_group,
						title:email_title,
						content:email_content
					}
					//草稿箱发送时带上邮件id
					if(init_email){
						ajax_param.emailId = init_email.emailId
					}
					$.ajax({
						url:"${pageContext.request.contextPath}/email/sendEmail",
						type:"POST",
						contentType:'application/json;charset=UTF-8',
						data:JSON.stringify(ajax_param),
						success:function(rsp){
							if(rsp.code==200){
								parent.sendEmailSuccess();
							}else{
								layer.msg(rsp.msg,{icon:2,time:2000});
							}
						},
						beforeSend:function(){
							loading = true
						},
						complete:function(){
							setTimeout(function(){
								loading = false;
							},1000);
						}
					})
				}
			});
			//保存到草稿箱
			$("#save_draft").on("click",function(){
				
				var email_title = $("#email_title").val().trim();
				var email_content = layedit.getContent(editorIndex);
				if(receive_group.length<1){
					layer.msg("请选择收件人",{icon:7,time:2000});
				}else if(email_title == ""){
					layer.msg("请填写主题",{icon:7,time:2000});
				}else{
					if(loading){return;}
					var ajax_param = {
						sendId:parent.user_info.userId,
						sendName:parent.user_info.userName,
						receiveList:receive_group,
						title:email_title,
						content:email_content
					}
					//编辑时带上邮件id
					if(init_email){
						ajax_param.emailId = init_email.emailId
					}
					$.ajax({
						url:"${pageContext.request.contextPath}/email/saveDraft",
						type:"POST",
						contentType:'application/json;charset=UTF-8',
						data:JSON.stringify(ajax_param),
						success:function(rsp){
							if(rsp.code==200){
								parent.saveDraftEmailSuccess();
							}else{
								layer.msg(rsp.msg,{icon:2,time:2000});
							}
						},
						beforeSend:function(){
							loading = true
						},
						complete:function(){
							setTimeout(function(){
								loading = false;
							},1000);
						}
					})
				}
			});
			
		})
	</script>
</body>
</html>