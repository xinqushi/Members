package dto;

import entity.Admin;
import entity.Province;
import pageinterceptor.PageParameter;

public class CompanyAccountDTO {
	private PageParameter page;
	private Province province;
	private Admin admin;
	private int ftype;
	public PageParameter getPage() {
		return page;
	}
	public void setPage(PageParameter page) {
		this.page = page;
	}
	public Province getProvince() {
		return province;
	}
	public void setProvince(Province province) {
		this.province = province;
	}
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	public int getFtype() {
		return ftype;
	}
	public void setFtype(int ftype) {
		this.ftype = ftype;
	}
	@Override
	public String toString() {
		return "CompanyAccountDTO [page=" + page + ", province=" + province + ", admin=" + admin + ", ftype=" + ftype
				+ "]";
	} 
	
}
