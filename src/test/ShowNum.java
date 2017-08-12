package test;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class ShowNum extends TagSupport{
	
	//字母a标签类名
	private String className1;
	
	//姓名a标签类
	private String className2;
	
	//获取全部姓名url
	private String url;
	
	

	public void setClassName1(String className1) {
		this.className1 = className1;
	}



	public void setClassName2(String className2) {
		this.className2 = className2;
	}
	

	public void setUrl(String url) {
		this.url = url;
	}



	@Override
	public int doEndTag() throws JspException {
		
		JspWriter out = pageContext.getOut();
		char nums[] = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
		StringBuilder str = new StringBuilder();
		
		for (char c : nums) {
			str.append("<a href='javascript:void(0)'  class='" + className1 + "'value='" + c + "' id='" + c +"'><font size=5px>" + c + "</font></a>&nbsp;&nbsp;");
		}
		str.append("<script type='text/javascript'>");
		
		str.append("$(function() {");
	    str.append("$('.num').click(function(){"
				+ "$('.num').css('color','#BFBFBF');"
				+ "$(this).css('color','#212122');"
	        	+ "var letter=$(this).text();"
	        	+ "var className = '" + className2 + "';"
	        	+ "var url = '" + url + "';"
	       /* 	+ "var className = 'setMember';"
	        	+ "var url ='/Member/member/getAllNames.action';"*/
				+ "getName(letter,className,url)" 
	        	//+className2 + ");"
				+ "})");
	    str.append("})");
	    str.append("</script>");
		try {
			out.print(str);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return super.doEndTag();
	}
	
	
}
