package entity;

import java.util.Date;

public class CompanyAccount {
	private int id;
	private Province province;
	public Province getProvince() {
		return province;
	}
	public void setProvince(Province province) {
		this.province = province;
	}
	private Admin admin;
	private int ftype;
	public int getFtype() {
		return ftype;
	}
	public void setFtype(int ftype) {
		this.ftype = ftype;
	}
	private CompanyFirm companyFirm;
	private Date date;
	private String formatTime;
	private float money;
	private String remark;
	private String details;
	//收入 支出类型
	private int mtype;
	
	//审核状态
	private int review;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	public CompanyFirm getCompanyFirm() {
		return companyFirm;
	}
	public void setCompanyFirm(CompanyFirm companyFirm) {
		this.companyFirm = companyFirm;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public float getMoney() {
		return money;
	}
	public void setMoney(float money) {
		this.money = money;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	public int getMtype() {
		return mtype;
	}
	public void setMtype(int mtype) {
		this.mtype = mtype;
	}
	public String getFormatTime() {
		return formatTime;
	}
	public void setFormatTime(String formatTime) {
		this.formatTime = formatTime;
	}
	public int getReview() {
		return review;
	}
	public void setReview(int review) {
		this.review = review;
	}
	@Override
	public String toString() {
		return "CompanyAccount [id=" + id + ", province=" + province + ", admin=" + admin + ", ftype=" + ftype
				+ ", companyFirm=" + companyFirm + ", date=" + date + ", formatTime=" + formatTime + ", money=" + money
				+ ", remark=" + remark + ", details=" + details + ", mtype=" + mtype + ", review=" + review + "]";
	}
	
	
}
