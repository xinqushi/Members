package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import dto.CompanyAccountDTO;
import entity.CompanyAccount;
import entity.CompanyFirm;

public interface CompanyAccountMapper {
	public void add(CompanyAccount companyAccount);
	public CompanyAccount getCompanyAccountById(@Param(value="caid")int caid);
	public List<CompanyFirm> getMoneyType(int ftype);
	public int checkExists(String name);
	public List<CompanyAccount> getComAccountByPage(CompanyAccountDTO companyAccountDTO);
	public void deleteComAccountById(@Param(value="id")int caid);
	public String getdetailsById( @Param(value="id")int caid );
	public void modifyCompanyAccountById(CompanyAccount companyAccount);	
	public void ReviewComAccountById(CompanyAccount companyAccount);	
}
