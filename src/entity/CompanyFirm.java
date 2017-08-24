package entity;

public class CompanyFirm {
	private int id;
	
	private String name;
	
	private int ftype;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getFtype() {
		return ftype;
	}

	public void setFtype(int ftype) {
		this.ftype = ftype;
	}

	@Override
	public String toString() {
		return "CompanyFirm [id=" + id + ", name=" + name + ", ftype=" + ftype + "]";
	}
	
}
