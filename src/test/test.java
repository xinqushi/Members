package test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import entity.Social;
import mapper.SocialMapper;
@RunWith(SpringJUnit4ClassRunner.class)  
@ContextConfiguration(locations = {"classpath*:applicationContext.xml","classpath*:spring-servlet.xml"})  
public class test extends AbstractJUnit4SpringContextTests{

	SocialMapper sociaMapper;
	


	public SocialMapper getSociaMapper() {
		return sociaMapper;
	}


	@Resource
	public void setSociaMapper(SocialMapper sociaMapper) {
		this.sociaMapper = sociaMapper;
	}



}
