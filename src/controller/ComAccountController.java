package controller;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.ibatis.annotations.Param;
import org.json.JSONObject;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.AdminDAO;
import dao.CompanyAccountDAO;
import dto.CompanyAccountDTO;
import entity.Admin;
import entity.CompanyAccount;
import entity.CompanyFirm;
import tools.NavigationBar;

/**
 * @author 熊杰
 * 公司账目controller
 */
@Controller
@RequestMapping("/comAccount")
public class ComAccountController {
	
	@Resource
	private CompanyAccountDAO companyAccountDAO;
	
	@Resource
	private AdminDAO adminDAO;
	
	/**
	 * 获取业务表(companyfirm)业务类型
	 * 
	 * @param ftype  0 软件开发类型    1 技术培训类型
	 * @return <b>list</b> 开发类型下的叶子节点数组
	 */
	@RequestMapping("/getMoneyType.action")
	@ResponseBody
	public List<CompanyFirm> getMoneyType(Integer ftype) {
		List<CompanyFirm> list = companyAccountDAO.getMoneyType(ftype);
		return list;
	}
	/**
	 * 判断输入的管理员姓名是否存在
	 * 
	 * @param name	输入姓名
	 * @return	<b>String</b> 1 存在  0 不存在
	 */
	@RequestMapping("/checkExists.action")
	@ResponseBody
	public String checkExists(String num) {
		String string = companyAccountDAO.checkExists(num);
		return string;
	}
	
	@RequestMapping("/addForm.action")
	@ResponseBody
	public String addForm( CompanyAccount companyAccount ){
		System.out.println(companyAccount);
		try {
			companyAccountDAO.add(companyAccount);
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
		return "1";
	}
	
	/**
	 * 根据aid获取companyAccount list
	 * 
	 * @param companyAccount	业务类别
	 * @return	List<CompanyAccount>
	 */
	@RequestMapping("/getComAccountByPage.action")
	@ResponseBody
	public String getComAccountByPage( CompanyAccountDTO companyAccountDTO){
		System.out.println(companyAccountDTO);
		int page = companyAccountDTO.getPage().getCurrentPage();
		//设置分页选项
		companyAccountDTO.getPage().setPageSize(3);
		String url = "";
		int btnCount = 5;
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<CompanyAccount> list = companyAccountDAO.getComAccountByPage(companyAccountDTO);
		int pageCount = companyAccountDTO.getPage().getTotalPage();
		String classNavBar = NavigationBar.classNavBar(url, btnCount, page, pageCount);
		for (CompanyAccount account : list) {
			account.setFormatTime(df.format(account.getDate()));
		}
		HashMap<String, Object> returnMap= new HashMap<String, Object>();
		returnMap.put("navbar", classNavBar);
		returnMap.put("list", list);
		JSONObject json=new JSONObject();
		json.put("returnMap", returnMap);
		return json.toString();	
	}
	/**
	 * 根据id获取companyAccount表内容
	 * 
	 * @param caid    companyAccount表id
	 * @return	CompanyAccount	
	 */
	@RequestMapping("/getComAccountById.action")
	@ResponseBody
	public CompanyAccount getComAccountById(Integer caid){
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		CompanyAccount companyAccount = companyAccountDAO.getCompanyAccountById(caid);
		companyAccount.setFormatTime(df.format(companyAccount.getDate()));
		if(companyAccount.getDetails() == null){
			companyAccount.setDetails("");
		}
		return companyAccount;
	}
	

	/**
	 * 根据id删除companyAccount表内容
	 * 
	 * @param caid	 companyAccount表id
	 * @return	String  1 成功  0 失败
	 */
	@RequestMapping("/deleteComAccountById.action")
	@ResponseBody
	public String deleteComAccountById(Integer caid){
		try {
			companyAccountDAO.deleteComAccountById(caid);
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
		
		return "1";
	}
	
	/**
	 * 根据id获取单表 companyAccount表内容
	 * 
	 * @param caid	companyAccount表id
	 * @return	details
	 */
	@RequestMapping("/getdetailsById.action")
	@ResponseBody
	public String getdetailsById(Integer caid){
		return companyAccountDAO.getdetailsById(caid);
	}
	
	/**
	 * 根据id修改单表 companyAccount表内容
	 * 
	 * @param companyAccount
	 * @return	String  1 成功  0 失败
	 */
	@RequestMapping("/modifyForm.action")
	@ResponseBody
	public String modifyForm(CompanyAccount companyAccount){
		try {
			companyAccountDAO.modifyCompanyAccountById(companyAccount);
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
		return "1";
	}
	/**
	 * 根据id修改审核状态  
	 * 
	 * @param companyAccount
	 * @return	String  1 成功  0 失败
	 */
	@RequestMapping("/ReviewComAccountById.action")
	@ResponseBody
	public String ReviewComAccountById(CompanyAccount companyAccount){
		try {
			companyAccountDAO.ReviewComAccountById(companyAccount);
		} catch (Exception e) {
			e.printStackTrace();
			return "0";
		}
		return "1";
	}
	/**
	 * 展示assist 有权限的助教姓名
	 * 
	 * @param companyAccount
	 * @return	String  1 成功  0 失败
	 */
	@RequestMapping("/showAssist.action")
	@ResponseBody
	public List<Admin> showAssist(HttpSession session){
		//加载公司账目系统需要的admin 权限
		Admin admin = (Admin)session.getAttribute("admin");
		admin = adminDAO.getAmById(admin.getId());
		//展示有权限的assist到页面
		List<Admin> comAdmin = adminDAO.getComAdmin();
		return comAdmin;
	}
	
}
