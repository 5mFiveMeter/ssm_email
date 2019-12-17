<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>杭州思达智慧协同办公</title>
</head>
<body>
	<jsp:include page="../components/header.jsp"></jsp:include>
	
	<div class="box_padding_xl fm_bdb">
		<button class="fm_btn bg_theme_green" id="delete_email">删 除</button>
		<button class="fm_btn bg_theme_green" id="clear_send_email">清 空</button>
	</div>
	
	<div class="box_padding_xl ">
		<div id="email_list" lay-filter="email-list"></div>
	</div>
	
	<script>
		layui.use(["layer","table","laytpl"],function(){
			//拿到草稿送列表
			window.layer = layui.layer;
			window.table = layui.table;
			window.laytpl = layui.laytpl;
			
			//保存到草稿箱
			window.saveDraftEmailSuccess = function (){
				layer.msg("保存成功",{icon:1,time:1000});
				layer.close(add_email_index);
				table.reload("email_list");
			}
			//发送邮件成功
			window.sendEmailSuccess = function(){
				layer.msg("发送成功",{icon:1,time:1000});
				layer.close(add_email_index);
				table.reload("email_list");
			}
			table.render({
				elem:"#email_list",
				id:"email_list",
				url:"${pageContext.request.contextPath}/email/getEmailByDraft",
				method:"post",
				page:true,
				where:{
					sendId:user_info.userId
				},
				limit:20,
				parseData:function(rsp){
					return {
						code:rsp.code,
						msg:rsp.msg,
						count:rsp.data.count,
						data:rsp.data.list
					}
				},
				response:{
					statusName: "code",
					statusCode: 200
				},
				cols:[[
					{type:'emailId',hide:true},
					{type:'allReceiveId',hide:true},
					{type:'emailId',hide:true},
					{type:'checkbox',width:'5%'},
					{title:'主题',width:'35%',event:"review",templet:function(data){
						return "<span class='fm_bdb_blue'>"+data.title+"</span>";
					}},
					{field:'attachId',title:'附件',width:'18%'},
					{field:'createTime',title:'保存时间',width:'15%'},
					{title:'收件人',width:'20%',field:'allReceiveName'},
					{title:"内容",align:'center',width:'7%',event:"review",templet:function(data){
						return "<button class='fm_btn'>编辑</button>"
					}}
				]]
			});
			//表格事件监听
			table.on("tool(email-list)",function(evt){
				if(evt.event=="review"){
					//点击编辑
					if(evt.event.emailId){return false}
					window.current_draft = evt.data;
					window.add_email_index = layer.open({
						type:2,
						title:"邮件编辑",
						area:["800px","600px"],
						maxmin:true,
						content:["${pageContext.request.contextPath}/email/editEmailPage?type=edit","no"]
					});
				}
			});
			//删除草稿
			$("#delete_email").on("click",function(){
				var emailIdGroup = []
				$.each(table.checkStatus("email_list").data,function(k,v){
					emailIdGroup.push(v.emailId);
				});
				if(emailIdGroup.length<1){
					layer.msg("未勾选任何邮件",{icon:2,time:1000});
				}else{
					//确认删除
					layer.confirm('确定删除？可在回收箱中找到。', {icon: 3, title:'清空发件箱'},function(index){
						$.ajax({
							url:"${pageContext.request.contextPath}/email/deleteEmail",
							type:"post",
							data: {
								emailIdGroup:emailIdGroup,
								type:3,
								userId:user_info.userId
							},
							success:function(rsp){
								if(rsp.code==200){
									table.reload("email_list");
									layer.msg(rsp.msg,{icon:1,time:1000});
								}else{
									layer.msg(rsp.msg,{icon:2,time:1000});
								}
								layer.close(index);
							}
						})
					});
				}
			});
			//清空收件箱
			$("#clear_send_email").on("click",function(){
				layer.confirm('确定清空草稿箱？可在回收箱中找到。', {icon: 3, title:'清空草稿箱'}, function(index){
					var emailIdGroup = []
					$.each(table.cache.email_list,function(k,v){
						emailIdGroup.push(v.emailId);
					});
					$.ajax({
						url:"${pageContext.request.contextPath}/email/deleteEmail",
						type:"post",
						data: {
							emailIdGroup: emailIdGroup,
							type:3,
							userId:user_info.userId
						},
						success:function(rsp){
							if(rsp.code==200){
								table.reload("email_list");
								layer.msg(rsp.msg,{icon:1,time:1000});
							}else{
								layer.msg(rsp.msg,{icon:2,time:1000});
							}
						}
					});
				  	layer.close(index);
				});
			});
		});
	</script>
</body>
</html>