<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>杭州思达智慧协同办公</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree_v3/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
	<style>
		#left_tree{
			float:left;
			width: 248px;
			height: 100%;
			overflow:auto;
		}
		.search_container{
			height: 40px;
		}
		#tree_query{
			width: 60%;
			height: 25px;
			float: left;
			margin: 7px 10px 0 10px;
		}
		#tree_search_btn{
			font-size: 12px;
			width:18%;
			text-align:center;
			line-height:20px;
			height: 23px;
			float: left;
			margin: 7px 10px 0 0;
			cursor: pointer;
			user-select: none;
		}
		#middle_arrow{
			width: 20px;
			height:20px;
			float: left;
			margin: 210px 10px 0;
		}
		#right_container{
			float:left;
			width: 248px;
			height: 100%;
			overflow-y:auto;
		}
		.select_box{
			padding: 10px 0;
		}
		.box_name{
			padding: 0 10px;
		}
		.box_delete{
			float: right;
			color:red;
			line-height: 1;
			margin-right: 10px;
			cursor: pointer;
		}
		.right_top{
			padding: 5px 10px;
			color: red;	
			text-align: right;
		}
		#clear_select{
			color: red;
			cursor:pointer;
		}
	</style>
</head>
<body class="iframe_container">
	<div class="box_padding_xxl" style="height: 88%;">
		<div class="left_tree fm_bdc" id="left_tree">
			<div class="search_container fm_bdb">
				<input class="layui-input" id="tree_query">
				<span class="fm_bdc" id="tree_search_btn">搜索</span>
			</div>
			<!-- 树控件 -->
			<div id="user_tree" class="ztree"></div>
		</div>
		<img src="${pageContext.request.contextPath}/static/images/right_arrow.png" id="middle_arrow">
		<div class="right_container fm_bdc" id="right_container">
			<div  class="fm_bdb right_top">
				<span id="clear_select">清空</span>
			</div>
		</div>
		
	</div>
	
	<div class="panel_footer fm_bdt">
		<button class="fm_btn" style="margin-right: 5px;" id="sure_select">确认</button>
		<button class="fm_btn_raw" style="margin-right: 5px;" id="cancel_select">取消</button>
	</div>

	<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/zTree_v3/js/jquery.v2.2.4.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/zTree_v3/js/jquery.ztree.all.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/zTree_v3/js/jquery.ztree.exhide.min.js"></script>
	<script type="text/javascript">
		layui.use(["layer"],function(){
			window.layer = layui.layer;
			var localtion_search = window.location.search.slice(1).split("&");
			//1单选,2多选
			var select_count = parseInt("${param.selectCount}");
			var exist_data = parent.receive_group || [];
			//树设置
			var ztree_set = {
				data: {
					simpleData: {
						enable: true,
						idKey:"value",
						pIdKey:"departId",
						rootPId:"0"
					}
				},
				view:{
					showLine: true,
					txtSelectedEnable: true
				},
				callback:{
					onClick:function(evt,treeId,treeNode){
						if(treeNode.isParent){
							//加入全部子节点
							$.each(treeNode.children,function(k,v){
								
								renderNodeToRight(v,select_count)
							})
						}else{
							//直接加入
							renderNodeToRight(treeNode,select_count)
						}
					}
				}
			}
			
			//左侧树数据
			var left_raw_data = [];
			var left_tree_data = [];
			//右侧选中数据
			var right_select = [];
			//zTree对象
			var zTree_object = {};
			//拿到数据渲染树 
			$.ajax({
				url:"${pageContext.request.contextPath}/user/getUserTree",
				success:function(rsp){
					if(rsp.code==200){
						var rsp_data = rsp.data || [];
						$.each(rsp_data,function(k,v){
							v.name=v.userName;
							v.value=v.userId;
							v.icon="${pageContext.request.contextPath}/static/images/user.png"
						})
						//添加一个根节点
						rsp_data.unshift({
							name:"全部用户",
							value:"0",
							icon:"${pageContext.request.contextPath}/static/images/user_group.png",
							open:true
						});
						//渲染树
						zTree_object = $.fn.zTree.init($("#user_tree"),ztree_set,rsp_data);
						//树数据
						left_raw_data = rsp_data;
						left_tree_data = zTree_object.getNodes();
						//数据回显
						$.each(exist_data,function(k,v){
							renderNodeToRight(v,select_count);
						});
					}else{
						layer.msg(rsp.msg,{icon:2,time:2000})
					}
				}
			});
			//模糊查询监听
			$("#tree_search_btn").on("click",function(){
				var key_words = $("#tree_query").val().trim();
				if(key_words==""){
					$.fn.zTree.init($("#user_tree"),ztree_set,left_raw_data);
				}else{
					//隐藏全部数据
					zTree_object.hideNodes(left_tree_data[0].children);
					//展示搜索结果
					zTree_object.showNodes(zTree_object.getNodesByParamFuzzy("name",key_words,null));
				}
			});
			//清空选择别表监听
			$("#clear_select").on("click",function(){
				right_select = []
				$(".select_box").remove();
			});
			//确定按钮监听
			$("#sure_select").on("click",function(){
				parent.treeCallback(0,right_select);
			});
			$("#cancel_select").on("click",function(){
				parent.treeCallback(1);
			});
			//将选中节点渲染到右侧
			function renderNodeToRight(node,type){ //node数据,type单选多选
				//重复则不添加
				for(var i=0;i<right_select.length;i++){
					if(node.value==right_select[i].value){
						return false;
					}
				}
				var box_str = "<div class='select_box'>"+
								"<span class='box_name'>"+node.name+"</span>"+
								"<span class='box_delete' box-value='"+node.value+"'>x</span>"+
							"</div>";
				//单选多选判断
				if(type==1){
					right_select = [node]
					$(".select_box").remove();
					$("#right_container").append(box_str);
				}else{
					right_select.push(node);
					$("#right_container").append(box_str);
				}
				//删除事件监听
				$("span[box-value="+node.value+"]").on("click",function(){
					//删除dom
					$(this).parent().remove();
					//删除绑定数据
					var box_index = -1;
					$.each(right_select,function(k,v){
						if(v.value==node.value){box_index=k}
					});
					if(box_index!=-1){
						right_select.splice(box_index,1);
					}
				})
			}
		})
	</script>
</body>
</html>