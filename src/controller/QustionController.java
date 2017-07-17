package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dao.CourseDAO;
import dao.QuestionDAO;
import entity.Course;
import entity.Question;
import entity.User;

/**
 * 发布图区问题分享服务
 * @author admin
 *
 */
@Controller
public class QustionController {
	 
	@Autowired
	private QuestionDAO questionDAO;
	@Autowired
	private CourseDAO courseDAO;
	@RequestMapping("/question/getQuestion")
	public ModelAndView getQuestion(int cId,String title,HttpSession session)
	{
		List<Question> list = null;
		try {
			list = questionDAO.getQuestions(cId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		List<Course> data=courseDAO.getcachapter(7);
		courseDAO.getCourseById(7);
		int chid=0;
		for(int i=0;i<data.size();i++){
			chid=data.get(i).getChid();
		}
		courseDAO.getLessons(chid);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list",list);
		session.setAttribute("list", list);
		session.setAttribute("cId", cId);
		session.setAttribute("data", data);
		session.setAttribute("lession", courseDAO.getLessons(chid));
		modelAndView.setViewName("/question/questions");
		return modelAndView;
	}
	@RequestMapping("/question/getQuestions")
	public ModelAndView getQuestions(int cId,String title,HttpSession session)
	{
		List<Question> list = null;
		try {
			list = questionDAO.getQuestions(cId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list",list);
		session.setAttribute("list", list);
		session.setAttribute("cId", cId);
		return modelAndView;
	}
	/**
	 * 
	 * 发布添加问题分享的服务
	 */
	@RequestMapping("/question/addQuestion")
	public ModelAndView addQuestion(Question question,HttpSession session)
	{
		try {
			User user = (User) session.getAttribute("myuser");
			question.setcId((int) session.getAttribute("cId"));
			question.setQperson(user.getName());
			questionDAO.addQuestion(question);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/question/questions");
		return modelAndView;
		
	}

}
