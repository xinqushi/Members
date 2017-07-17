package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.Question;
import mapper.QuestionMapper;

/**
 * 
 * 提取问题分享信息 
 * @author admin
 *
 */
@Service
public class QuestionDAO {
	
	@Autowired
	private QuestionMapper questionMapper;
	/**
	 * 
	 * 提取问题分享信息
	 * @param cId
	 * @return
	 */
	@SuppressWarnings("unused")
	public List<Question> getQuestions(int cId)
	{
		List<Question> list = null;
		try {
			list = questionMapper.getQuestions(cId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 
	 * 添加问题分享的信息
	 */
	public void addQuestion(Question question)
	{
		try {
			questionMapper.addQuestion(question);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
}
