package mapper;

import java.util.List;

import entity.Question;

public interface QuestionMapper {
	List<Question> getQuestions(int cId);
	void addQuestion(Question question);
}
