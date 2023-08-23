package egovframework.b.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import egovframework.b.model.QcResultDTO;
import egovframework.b.model.QcResultDateDTO;
import egovframework.b.model.QcResultRequestDTO;
import egovframework.b.model.UserBDTO;
import egovframework.b.model.QcCodeDTO;

public interface BService {
	int joinUser(UserBDTO dto);

	boolean duplicate(UserBDTO dto);
	UserBDTO findOne(String id);
	List<String> qcResultDate(QcResultDateDTO qcResultDateDTO);
	List<Map<String, Object>> qcResultFindHashMap(QcResultRequestDTO qcResultDTO);

	List<String> gumsapartList();

	List<String> jangbiFindAll();

	List<String> levelList();

	List<QcCodeDTO> qcCodeList();

	int save(List<Map<String, Object>> list);
	
	
}
