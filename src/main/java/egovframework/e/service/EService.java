package egovframework.e.service;

import java.util.List;
import java.util.Map;

import egovframework.e.model.UserEDTO;
import egovframework.e.model.grid1DTO;
import egovframework.e.model.grid2DTO;

public interface EService {
	int joinUser(UserEDTO dto);
	
	boolean duplicate(UserEDTO dto);
	
	UserEDTO findOne(String id);

	List<grid1DTO> grid1(grid1DTO grid1DTO);
	
	List<grid1DTO> grid1First(grid1DTO grid1DTO);
	
	List<grid2DTO> grid2(grid2DTO grid2DTO);
	
	int setDcListDelete(Map<String, Object> params);

	int updateGrid2Row(Map<String, Object> updateMap);

	void clearDcListFileEndDate(Map<String, Object> updateMap);

	int deleteGrid2Row(Map<String, Object> updateMap);

}
