package egovframework.b.mapper;


import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.b.model.QcResultDTO;
import egovframework.b.model.QcResultDateDTO;
import egovframework.b.model.QcResultRequestDTO;
import egovframework.b.model.UserBDTO;
import egovframework.b.model.QcCodeDTO;

@Mapper("BMapper") // 네임값 지정해줌, 일치시켜주는 것이 좋음
public interface BMapper {
	int joinUser(UserBDTO dto);

	int duplicate(UserBDTO dto);
	
	UserBDTO findOne(String id);
	
	List<Map<String, Object>> qcResultFindHashMap(QcResultRequestDTO qcResultDTO);
	List<String> qcResultDate(QcResultDateDTO qcResultDateDTO);

	List<String> gumsapartFindAll();

	List<String> jangbiFindAll();

	List<String> levelListFindAll();

	List<QcCodeDTO> qcCodeFindAll();

	int delete(Map<String, Object> map);

	int update(Map<String, Object> map);
	
	List<String> findTestCode(@Param("gumsaName") String gumsaName);
	String findQcCode(@Param("qcName") String qcName);
	
}
