<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>工作日志</title>
<link
	href="${pageContext.request.contextPath}/resources/uikit-2.25.0/css/uikit.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/bootstrap-3.3.0/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/layer-v2.4/layer.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/uikit-2.25.0/js/uikit.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jslib/currency.js"></script>
</head>
<script type="text/javascript">
	$(function() {
		var id = getUrlParam("id");
		$
				.post(
						"${pageContext.request.contextPath}/comAccount/getdetailsById.action",
						{
							caid : id
						}, function(data) {
							var text="<h3>费用详情</h3>";
							$("#text").html(text);
							if(data != ""){
								$("#context").html(data);
							}
						});
	});
</script>
<body>
<div class="container">
	<div class="bs-example" data-example-id="large-well">
		<div class="page-header" id="text">
		</div>
		<div class="well well-lg" id="context">未添加详情！</div>
	</div>
</div>
</body>
</html>