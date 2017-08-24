<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui-v1.0.9_rls/layui/css/layui.css"  media="all">
<link
	href="${pageContext.request.contextPath}/resources/plugin/jeDate/css/jedate.css"
	rel="stylesheet" type="text/css" />
<style>

.table>tr>th{
 	line-height:2.428571;
}
</style>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/ueditor/ueditor.config.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.11.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/layer/layer-v2.0/layer/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugin/jeDate/jedate/jquery.jedate.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/myfile.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">		

$(function(){
	//接受参数
	var ftype = "${param.ftype}";
	//设置同步
	$.ajaxSetup({async:false});
	//UE富文本编辑器加载
	var ue = UE.getEditor('editor', {
		enableAutoSave : false,
		UEDITOR_HOME_URL : "${pageContext.request.contextPath}/resources/plugin/ueditor/",
		serverUrl : "${pageContext.request.contextPath}/resources/plugin/ueditor/jsp/controller.jsp"  
	})
	//设置选择时间插件
		$("#date").jeDate({
			isinitVal : true,
			festival : true,
			ishmsVal : false,
			festival : false,
			isClear :false,
			format : "YYYY-MM-DD hh:mm:ss",
			zIndex : 3000
		});
	
	getMoneyType();
	showProvinces();
	function getMoneyType(){
		//设置费用类型
	 	$.post("${pageContext.request.contextPath}/comAccount/getMoneyType.action",{ftype:ftype},function(data){
	 		showdata(data);
		}); 
	}
	function showProvinces(){
		var line="";
		line = line + "<option value='1' selected='selected'>";
		line = line + "北京";
		line = line + "</option>";
		line = line + "<option value='22'>";
		line = line + "重庆";
		line = line + "</option>";
		$("[name='province']").append(line);
	}
	function showdata(data){
		var line="";
		for( i in data){
			line = line + "<option value="+data[i].id+">";
			line = line + data[i].name;
			line = line + "</option>";
		}
		$("[name='moneyType']").append(line);
	}
	//判断金额是否为空
	function checkMoney(){
		if($.trim($("[name='money']").val()) == ""){
			$("#msg").html("请输入费用金额!");
			return true;
		}else{
			//正则判断金钱是否合法
			var reg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
			if (!reg.test($.trim($("[name='money']").val()))) {
				$("#msg").html("你输入的金额不合法!");
				return false;
			}
			$("#msg").html("");
			return false;
		}
	}

	//费用类型判断必须选择
	function checkMoneyType(){
		if($("[name='mtype']").val() == ""){
			$("#msg").html("请选择费用种类!");
			return true;
		}else{
			$("#msg").html("");
			return false;
		}
	}

	//费用判断合法
	$("[name='mtype']").blur(function(){
		checkMoneyType();
	})
	$("[name='money']").blur(function(){
		checkMoney()
	})
	
	$("[name='mtype']").change(function(){
		checkMoneyType();
	})
	$("[name='money']").change(function(){
		checkMoney()
	})
	
	//提交表单
	$("#add").click(function(){	
		if(checkMoneyType()) return;
		if(checkMoney()) return;
		var contents = UE.getEditor('editor').getContent();
		$.post("${pageContext.request.contextPath}/comAccount/addForm.action",
		{"admin.id":"${admin.id}","province.id":$("[name='province']").val(),"companyFirm.id":$("[name='moneyType']").val(),
			date:new Date($("[name='date']").val()),mtype:$("[name='mtype']").val(),money:$.trim($("[name='money']").val()),
			remark:$("[name='remark']").val(),ftype:ftype,details:contents
		},
		function(data){
			if(data == "1"){
				layer.msg('提交成功', {
				    icon: 1,
				    time: 1000
				}, function(){
	 				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index);
				});
			}else{
				layer.msg('提交失败', {
				    icon: 1,
				    time: 1000
				}, function(){
	 				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index);
				});
			}
			
		})
	})
	
});
</script>
</head>
<body>
<div class="container">
	<div class="well well-sm text-center">账目信息</div>
	<div class="panel panel-default">
		<div class="panel-body">
			<form name="addForm">
			<table class="table table-hover">
				<tr>
					<th>记账人</th>
					<td>
						<input name="name" type="text" placeholder="必填项"  style="width: 200px" class="form-control" required readonly="readonly" value="${admin.realname}"/> 
					</td>
				</tr>
				<tr>
					<th>所在省份</th>
					<td>
						<select name="province" class="form-control" style="width: 200px"></select>
					</td>
				</tr>
				<tr>
					<th>费用种类</th>
					<td>
						<div>
							<select name="moneyType" class="form-control" style="width: 200px">
							</select> 
						</div> 
                    </td>
				</tr>
				<tr>
					<th>时间</th>
					<td>
						<input name="date" id="date" type="text" placeholder="必填项"  style="width: 200px" class="form-control" required /> 
                    </td>
				</tr>
				<tr>
					<th>费用类型</th>
					<td>
						<div>
							<select name="mtype" class="form-control" style="width: 200px">
							  <option value="">请选择记账类型</option>
							  <option value="0">支出</option>
							  <option value="1">收入</option>
							</select> 
						</div> 
                    </td>
				</tr>
				<tr>
					<th>费用</th>
					<td>
						<input type="text" name="money" placeholder="必填项" class="form-control" style="width: 200px" /> 
                    </td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="msg" style="color: red; font-weight: bold; font-size: 15px; " align="center"></div>
					</td>
				</tr>
				<tr>
					<th align="center"><span style="margin-top: 40px; display: block;">备注</span></th>
					<td colspan="1">
						 <div class="layui-form-item layui-form-text">
						      <textarea placeholder="请输入内容" class="layui-textarea" name="remark"></textarea>
						 </div>
					</td>
				</tr>
			</table>
				<div>
					<script id="editor" type="text/plain" style="height: 260px;"></script>
				</div>
				<br>
				<div style="margin-left: 600px">
					<button type="button" class="btn btn-default" id="add">提交</button>
				</div>
	
			</form>
		</div>
	</div>

</div>
</body>
</html>