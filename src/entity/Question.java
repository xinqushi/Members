package entity;

import java.io.Serializable;
import java.util.Date;

public class Question implements Serializable {
	private int Id;
	private int cId;
	private String question;
	private String qperson;
	private String solution;
	private Date time;
	private String sperson;
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public int getcId() {
		return cId;
	}
	public void setcId(int cId) {
		this.cId = cId;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getQperson() {
		return qperson;
	}
	public void setQperson(String qperson) {
		this.qperson = qperson;
	}
	public String getSolution() {
		return solution;
	}
	public void setSolution(String solution) {
		this.solution = solution;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getSperson() {
		return sperson;
	}
	public void setSperson(String sperson) {
		this.sperson = sperson;
	}
	@Override
	public String toString() {
		return "Question [Id=" + Id + ", cId=" + cId + ", question=" + question + ", qperson=" + qperson + ", solution="
				+ solution + ", time=" + time + ", sperson=" + sperson + "]";
	}
	
	
}
