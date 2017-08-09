package dto;


import pageinterceptor.PageParameter;

/**
 * @author 左琪
 * 时间：2017-8-8
 * 添加了省份字段名
 */
public class SchoolDTO {
	private PageParameter page;
	private String province;
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public SchoolDTO()
	{
		page=new PageParameter();
	}
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
	}
	@Override
	public String toString() {
		return "SchoolDTO [page=" + page + ", province=" + province + "]";
	}
	
}
