package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.CompanyAccountDTO;
import entity.CompanyAccount;
import entity.CompanyFirm;
import mapper.CompanyAccountMapper;

@Service
public class CompanyAccountDAO {
	
	@Autowired
	private CompanyAccountMapper companyAccountMapper;
	
	public void add(CompanyAccount companyAccount){
		companyAccountMapper.add(companyAccount);
	}
	
	public List<CompanyFirm> getMoneyType(int ftype){
		return companyAccountMapper.getMoneyType(ftype);
	}
	public String checkExists(String name){
		int count =  companyAccountMapper.checkExists(name);
		if(count > 0 ){
			return "1";
		}else{
			return "0";
		}
	}
	public List<CompanyAccount> getComAccountByPage(CompanyAccountDTO companyAccountDTO){
		return companyAccountMapper.getComAccountByPage(companyAccountDTO);
	}
	public CompanyAccount getCompanyAccountById(int caid){
		return companyAccountMapper.getCompanyAccountById(caid);
	}
	public void deleteComAccountById(int caid){
		companyAccountMapper.deleteComAccountById(caid);
	}
	public String getdetailsById(int caid ){
		return companyAccountMapper.getdetailsById(caid);
	}
	public void modifyCompanyAccountById(CompanyAccount companyAccount){
		companyAccountMapper.modifyCompanyAccountById(companyAccount);
	}
	public void ReviewComAccountById(CompanyAccount companyAccount){
		companyAccountMapper.ReviewComAccountById(companyAccount);
	}
}
