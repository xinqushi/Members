<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>来扒一扒你有哪些校友在新趋势~</title>

<!-- <link href="css/index_style.css" rel="stylesheet" type="text/css"> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-1.9.0.min.js"></script>	
<script type="text/javascript" src='${pageContext.request.contextPath}/jslib/SG_area_select.js'></script>
 <script type="text/javascript" src='${pageContext.request.contextPath}/jslib/iscroll.js'></script>
 <link href="${pageContext.request.contextPath}/tableTemplet/css/H-ui.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/tableTemplet/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.container{width:73%;margin-left:0px}
#scllist{width:68%;margin-left:17px}
#provinceList ul li{margin-left:6px;margin-top:10px;width:75px;} 
#provinceList ul li a{ display:block; width:75px; } 
#provinceList{margin-bottom:30px;text-align:center;}
</style>

</head>
<body>

<!-----HEADER STAR----->

<script type="text/javascript">
	$(document).ready(function(){
		$.areaSelect();
		var page2=1;
		getData(page2);
	});
	//点击省份按钮获取学习信息
	function getData(page2){
		$("#provinceList").on("click","a",function(){
			if($("a").hasClass('.label label-primary')){
				$("a").removeClass('.label label-primary');
			}
			$(this).addClass('.label label-primary');
			getSchool(page2,$(this).text());
		});
	}
	//调用根据省份获取学校
	function getSchool(page2,province){
		$.post("${pageContext.request.contextPath}/member/getSchoolByPage.action",{"province":province,"page2":page2},function(data){
			var dataObj = eval("("+data+")");
			var navbar=dataObj.returnMap.navbar;
			//var tatolCount = dataObj.returnMap.totalCount;
			var list=dataObj.returnMap.list;
			if(list!=null&&list.length>0){
				$(".page-nav").html(navbar);
				//$("#num").html(tatolCount);
				drawTable(list);
				btnclick();
				detailclick();
			}
			else{
				$("#school").html("<h4 align='center'>该省暂无会员</h4>");
			}
		});
	}
	//分页按钮点击事件
	function btnclick(){
		$(".nav-btn").click(function(){
			data=this.lang;
			data=data.split("?");
			getSchool(data[1],data[0]);
		})
	}
		//详情点击事件
	function detailclick(){
		$(".detail").click(function(){
			var school=this.lang;
			layer.open({
				  type: 2,
				  title: '会员详情',
				  area: ['800px', '600px'],
				 // closeBtn: 0, //不显示关闭按钮
				  shift: 1,
				  maxmin: true,
				  shade: 0.5, //开启遮罩关闭
				  content: '${pageContext.request.contextPath}/member/schooldetail.jsp?school='+school,
				  end: function(){
					  getData();
				    }
			});
		})
	}
	function drawTable(data){
		var line="";
		line=line + "<thead>";
		line=line + "<tr class='text-c'>";
		line=line + "<th class='xh'>序号</th>";
		line=line + "<th class='xh'>学校名称</th>";
		line=line + "<th class='yhm'>会员人数</th>";
		line=line + "<th class='xm'>详情</th>";
		line=line + "</tr>";
		line=line + "</thead>";
		line=line + "<tbody>";
		for(i=0;i<data.length;i++){	
			var count;
			$.post("${pageContext.request.contextPath}/member/getSchoolMemberCount.action",{school:data[i]},function(data1){
				count=data1;
			});
			line=line + "<tr class='text-c'>";
			line=line + "<td>" + (i+1) + "</td>";
			line=line + "<td class='text-l'>" + data[i] + "</td>";			
			line=line + "<td>" + count + "</td>";
			line=line + "<td>" + "<a class='detail' href='javascript:;' lang='"+data[i]+"'title='详情'><span class='label label-success radius'>详情</span></a>" + "</td>";
			line=line + "</tr>";
		}
		line=line + "</tbody>";
		$("#school").html(line);
	}
</script>
<!-- 代码 结束 -->
<div id="main">
<div id="provinceList"></div>
<div id="scllist">
	<table class="table table-border table-bordered table-bg table-hover" id="school">
	</table>
	<div class='page-nav' style="margin-top:20px;"></div>
</div>
</div>
</body>
</html>