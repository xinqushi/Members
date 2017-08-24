<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link
	href="${pageContext.request.contextPath}/resources/H-ui_v3.0/css/H-ui.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/css/page.css"
	rel="stylesheet" type="text/css" />
<style type="text/css">
	.table .text-c th  {
    text-align: center;
    line-height: 25px;
}
	.table .text-c td{
	text-align: center;
    line-height: 28px;
}
</style>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
<script type="text/javascript">
$(function(){
	//layer加载 添加费用页面
	$("#add").unbind("click").click(function(){
		layer.open({
			  type: 2,
			  title: '添加账目',
			  area: ['800px', '600px'],
			  shift: 1,
			  shade: 0.5, //开启遮罩关闭
			  content: '${pageContext.request.contextPath}/admin/companyaccount/add.jsp?ftype=0',
			  end: function(){
				getData();
			  }
		});
	})
	//管理记账人
		
	//定义全局变量page 默认为1
	var page = 1;
	$.ajaxSetup({async:false});
	$("[name='assistant']").change(function(){
		getData();
	})
	showAssist();//展示assist 需要放在最前面
	getData();
	modify();
	deleteNode();
	show();
	textOn();
	accountReview();
	/*获取不同种类的费用信息*/
	$(".butname").click(function(){
		var buttons =$(".butname");
		buttons.removeClass("active");
	    $(this).addClass("active");
		getData();
	});

	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			page=this.lang;
			getData();
		})
	}
	//展示费用使用详情
	function getData(){
		//设置同步
		$.ajaxSetup({async:false});
		var json = {"admin.id":$("[name='assistant']").val(),ftype:0,"page.currentPage":page};
		//查看 北京地区 或者重庆地区按钮是否被选中
		$(".butname").each(function(i,e){
			if($(this).hasClass("active") && (this.lang != "0")){
				json = {"admin.id":$("[name='assistant']").val(),ftype:0,"province.id":this.lang,"page.currentPage":page}
			}
		})
		$.post("${pageContext.request.contextPath}/comAccount/getComAccountByPage.action",json,function(data){
	
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			var data=dataObj.returnMap.list;
			if(data.length == 0){
				$("#tbody").html("");
				$("#msg").html("该记账人没有记账记录！");
				return;
			}else{
				$("#msg").html("");	
			}
			$(".page-nav").html(navbar);
			btnclick();
			drawTable(data);
			//设置备注
			var maxwidth = 10;
			for(i=0;i<data.length;i++){
				if ($("#text"+i).text().length > maxwidth) {
					$("#text"+i).text($("#text"+i).text().substring(0, maxwidth) + "...");
				}
				else{
					$("#text"+i).text($("#text"+i).text());
				}				
			}
		})
	}
	
	//绘制表格
	function drawTable(data){
		var line = "";
		for(i in data){
			//获取操作
			var operation="";
			operation+="<a herf='#' title='审核' style='text-decoration:none;font-size:16px' class='log' lang='"+data[i].id+","+ data[i].review +"'><i class='Hui-iconfont'>&#xe623;</i>";
			operation+="<a href='javascript:void(0)' class='tit' lang='"+data[i].id+"'>┆&nbsp;&nbsp;详情&nbsp;|</a>";	
			operation+="<a class='icon-delete-middle' href='javascript:;' lang='"+data[i].id+","+ data[i].admin.id +"'title='删除'>";
			operation+="<i class='Hui-iconfont'>&#xe6e2;</i>";
			operation+="</a>";
			operation+="<a href='javascript:void(0)' class='mod' lang='"+data[i].id+","+ data[i].admin.id +"'>|&nbsp;修改</a>";	
			
			line += "<tr>";
			line += "<td>"+ i +"</td>";
			line += "<td>"+ data[i].province.name +"</td>";
			line += "<td>"+ data[i].companyFirm.name +"</td>";
			if(data[i].mtype == 0){
				line += "<td>支出</td>";
			}else{
				line += "<td>收入</td>";
			}
			line += "<td>"+ data[i].money +"</td>";
			line += "<td>"+ data[i].admin.realname +"</td>";
			line += "<td>"+ data[i].formatTime +"</td>";
			line += "<td class='td-status'><a herf='#' class='flag' lang='"+data[i].id+"'>";
			line += showFlag(data[i].review);
			line += "</a></td>";
			if(data[i].remark == ""){
				line +="<td class='text' id='text"+i+"' lang='未填写备注'>无</td>";
			}else{
				line +="<td class='text' id='text"+i+"' lang='"+data[i].remark+"'>"+ data[i].remark +"</td>";
			}
			line += "<td>"+ operation +"</td>";
			line += "</tr>";
		}
		$("#tbody").html(line);
	}
	
	//修改功能
	function modify(){
		$("#tbody").on('click','.mod',function(){
			//解决权限问题 
			var caid  = this.lang.split(",")[0];
			var aid  = this.lang.split(",")[1];
			if("${admin.cauthority}" != "0"){
				if(aid != "${admin.id}"){
					layer.msg("<strong style='color:green;'>只有本人才能修改此费用信息！</strong>", {icon: 6});
					return;
				} 
			}
			$(this).unbind();
			layer.open({
				  type: 2,
				  title: '修改账目',
				  area: ['800px', '600px'],
				  shift: 1,
				  shade: 0.5, //开启遮罩关闭
				  content: '${pageContext.request.contextPath}/admin/companyaccount/modify.jsp?id='+caid+"&ftype=0",
				  end: function(){
					  //location.reload();
					  getData();
				  }
			});
		})
	}
	//删除功能
	function deleteNode(){
		$("#tbody").on('click','.icon-delete-middle',function(){
			var caid  = this.lang.split(",")[0];
			var aid  = this.lang.split(",")[1];
			//解决权限问题 
			if("${admin.cauthority}" != "0"){
				//如果不是本人操作
				if(aid != "${admin.id}"){
					layer.msg("<strong style='color:green;'>只有本人才能删除此费用信息！</strong>", {icon: 6});
					return;
				}
				//如果是本人操作  但是费用已经被审核了
				var review = $(this).siblings(".log").prop("lang").split(",")[1];
				if(review == "1"){
					layer.msg("<strong style='color:green;'>费用信息已经审核,只有管理员才能删除！</strong>", {icon: 6});
					return;
				}
			}
			var s1 = "您确定要<b style='color:red;'>删除</b>此费用信息?<br />";
			layer.confirm(s1,{
				btn : [ '确定', '放弃' ],
				area : [ '570px' ]
			},function() {
				$(this).unbind();
				$.post("${pageContext.request.contextPath}/comAccount/deleteComAccountById.action",{caid:caid},function(data){
					if(data == "1"){
						layer.closeAll();
						getData();
					}else{
						layer.msg("<strong style='color:red;'>删除信息失败！</strong>", {icon: 2});
					}
				})
			});
		})
	}
	/* 查看某一条的费用详情 */
	function show() {
		$("#tbody").on('click','.tit',function(){
			$(this).unbind();
			var id = this.lang;
			layer.open({
				type : 2,
				title : '查看费用详情',
				area : [ '780px', '550px' ],
				shift : 1,
				shade : 0.5, //开启遮罩关闭
				content : '${pageContext.request.contextPath}/admin/companyaccount/lookdetails.jsp?id='+id,
			});
		});
	}
	//备注鼠标悬停事件
	function textOn(){
		$("#tbody").on('click','.text',function(){
			var id="#"+this.id;			
			layer.tips(this.lang, id,{time:5000,closeBtn: 2});
			});
	}
	
	//获取审核状态
	function showFlag(flag){
		if(flag==1){
			status="<span class='label label-success radius'>已审核</span>";
		}else{
			status="<span class='label label-warning radius'>未审核</span>";
		}
		return status;
	}
	//加载审核方法
	function accountReview(){
		$("#tbody").on('click','.log',function(){
			
			var logLang = this.lang.split(",");
			var caid  = logLang[0];
			var review = logLang[1];
			//解决权限问题
			var cauthority = "${admin.cauthority}";
			if(cauthority != "0"){
				layer.msg("<strong style='color:green;'>你没有权限审核此信息！</strong>", {icon: 6});
				return;
			}else{
				if(review == "1"){
					layer.msg("<strong style='color:green;'>已经审核过了,无需再次审核！</strong>", {icon: 6})
					return;
				}
			}
			var s1 = "您确定要<b style='color:red;'>审核</b>此费用信息?<br />";
			layer.confirm(s1,{
				btn : [ '确定', '放弃' ],
				area : [ '570px' ]
			},function() {
				$.post("${pageContext.request.contextPath}/comAccount/ReviewComAccountById.action",{id:caid,review:1},function(data){
					if(data == "1"){
						layer.closeAll();
						getData();
					}else{
						layer.msg("<strong style='color:red;'>审核信息失败！</strong>", {icon: 2});
					}
				})
			});
		})	
	}
	//加载assistant 
	function showAssist(){
		$.post("${pageContext.request.contextPath}/comAccount/showAssist.action",function(data){
			var line ="<option value='0' selected>所有人</option>";
			for( i in data){
				line += "<option value="+ data[i].id +">"+ data[i].realname +"</option>";
			}
			$("[name='assistant']").html(line);
		})
	}
	
})
</script>
</head>
<body>
	 <c:if test="${admin==null}">
	<jsp:forward page="/user/login.jsp"></jsp:forward>
	</c:if>		
	<h1 class="text-c">VIP软件开发账目</h1>
	<div class="panel panel-secondary">
		<div class="panel-header">
			<div style="float: left;">
				<input type="hidden" id="flag" value="0">
				<button class="btn btn-success" id="add">
					<i class="fa fa-plus" aria-hidden="true"></i>添加账目
				</button>
			</div>
			<div class="btn-group" style="float: left">
				<button type="button" class="btn btn-primary radius butname active"
					lang="0">所有信息</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="22">重庆地区</button>
				<button type="button" class="btn btn-primary radius butname"
					lang="1">北京地区</button>
			</div>
			<div class="form-group" style="margin-left: 20px;">
				<span class="select-box radius" style="width: 100px;background : white;">
					<select class="select" name="assistant">
					</select>
				</span>
			</div>
		</div>
		<div class="panel-primary">
			<table class="table table-border table-bg table-bordered radius">
				<thead class="text-c">
					<tr>
						<th>序号</th>
						<th>地区</th>
						<th>费用类型</th>
						<th>支出/收入费用</th>
						<th>费用(元)</th>
						<th>记账人</th>
						<th>账目时间</th>
						<th>审核状态</th>
						<th>备注</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody id="tbody" class='text-c'>
				</tbody>
			</table>
			<div id="msg" style="color: red; font-weight: bold; font-size: 15px; " align="center"></div>
		</div>
	<div class="page-nav" style="float: right; margin-top: 10px;" id="paging"></div>
	</div>
</body>
</html>