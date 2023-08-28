package egovframework.d.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.d.mapper.DMapper;
import egovframework.d.model.UserDDTO;
import egovframework.d.model.lisc100DTO;
import egovframework.d.model.lisq100DTO;
import egovframework.d.model.lisq110DTO;
import egovframework.d.model.testPartListDTO;
import egovframework.d.service.DService;

@Service("DService")
public class DServiceImpl implements DService {
	
	@Resource(name="DMapper")
	private DMapper dMapper;

	@Override
	public int joinUser(UserDDTO dto) {
		return dMapper.joinUser(dto);
	}

	@Override
	public int checkUser(String id) {
		return dMapper.checkUser(id);
	}

	@Override
	public UserDDTO loginUser(UserDDTO dto) {
		return dMapper.loginUser(dto);
	}

	@Override
	public List<lisq100DTO> lisq100(Map<String,String> map) {
		return dMapper.lisq100(map);
	}
	
	@Override
	public List<lisq110DTO> lisq110(Map<String,String> map) {
		return dMapper.lisq110(map);
	}

	@Override
	public List<lisc100DTO> lisc100(String jundalPart) {
		return dMapper.lisc100(jundalPart);
	}

	@Override
	public List<testPartListDTO> testPartList() {
		return dMapper.testPartList();
	}

	@Override
	public List<String> qcNameFindAll() {
		return dMapper.qcNameFindAll();
	}

	@Override
	public List<String> qcNameListByTestPart(String jundalPart) {
		return dMapper.qcNameListByTestPart(jundalPart);
	}

	@Override
	public int addData(lisq110DTO dto) {
		return dMapper.addData(dto);
	}

	@Override
	public int updateData(lisq110DTO dto) {
		return dMapper.updateData(dto);
	}
	
	@Override
	public int delData(lisq100DTO dto) {
		return dMapper.delData(dto);
	}

	@Override
	public String getJundalPart(String jundalPart) {
		return dMapper.getJundalPart(jundalPart);
	}
}
