package egovframework.e.mapper;


import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.e.model.UserEDTO;
import egovframework.e.model.grid1DTO;
import egovframework.e.model.grid2DTO;

@Mapper("EMapper")
public interface EMapper {
	int joinUser(UserEDTO dto);

	int duplicate(UserEDTO dto);
			
	UserEDTO findOne(String id);
	
	public List<grid1DTO> grid1(grid1DTO grid1DTO);

	public List<grid1DTO> grid1First(grid1DTO grid1DTO);
	
	public List<grid2DTO> grid2(grid2DTO grid2DTO);

	public int setDcListInfoDelete(Map<String, Object> params);
	
	int setDcListFileDelete(Map<String, Object> params);

    int updateGrid2Row(Map<String, Object> updateMap);

	void clearDcListFileEndDate(Map<String, Object> deleteMap);

	int deleteGrid2Row(Map<String, Object> params);
	
	int insertGrid1Row(Map<String, Object> params);

	int updateGrid1Row(Map<String, Object> params);
	
	int insertGrid2Row(Map<String, Object> params);

	int updateGrid2Rows(Map<String, Object> params);

	


}
