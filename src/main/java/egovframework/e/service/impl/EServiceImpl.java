package egovframework.e.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.e.mapper.EMapper;
import egovframework.e.model.UserEDTO;
import egovframework.e.model.grid1DTO;
import egovframework.e.model.grid2DTO;
import egovframework.e.service.EService;

@Service("EService")
public class EServiceImpl implements EService {

	@Resource(name="EMapper")
	private EMapper eMapper;
	
	@Override
	public int joinUser(UserEDTO dto) {
		System.out.println("serviceimpl");
		return eMapper.joinUser(dto);
	}

	@Override
	public boolean duplicate(UserEDTO dto) {
		
		int result = eMapper.duplicate(dto);
		if(result == 1) return true;
		return false;
	}

	@Override
	public UserEDTO findOne(String id) {
		
		return eMapper.findOne(id);
	}
	
	@Override
	public List<grid1DTO> grid1(grid1DTO grid1DTO) {
		
		System.out.println("grid1DTO service >>>" + grid1DTO.getItem1());
	    List<grid1DTO> data = eMapper.grid1(grid1DTO);
	    //데이터확인용 코드
	    //for (grid1DTO item : data) {
	        //System.out.println("item1: " + item.getitem1());
	        //System.out.println("item1: " + item.getitem1());
	        
	    //}
	    
	    return data;
	}

	@Override
	public List<grid1DTO> grid1First(grid1DTO grid1DTO) {
		
		System.out.println("grid1DTO service >>>" + grid1DTO.getItem1());
		List<grid1DTO> data = eMapper.grid1First(grid1DTO);
		//데이터확인용 코드
		//for (grid1DTO item : data) {
		//System.out.println("item1: " + item.getitem1());
		//System.out.println("item1: " + item.getitem1());
		
		//}
		
		return data;
	}
	
	@Override
	public List<grid2DTO> grid2(grid2DTO grid2DTO) {
		
		System.out.println("grid2DTO service >>>" + grid2DTO.getFileName());
	    List<grid2DTO> data = eMapper.grid2(grid2DTO);
	    //데이터확인용 코드
	    //for (grid2DTO item : data) {
	        //System.out.println("DOC_CODE: " + item.getDOC_CODE());
	        //System.out.println("DOC_NAME: " + item.getFILE_NM());
	        
	    //}
	    
	    return data;
	}

	@Override
	public int setDcListDelete(Map<String, Object> params) {
		int result = 0;
		
		try {
			System.out.println("setDcListDelete params >>>" + params);
			// 상위테이블, 하위 테입르 모두 삭제 시
			if("true".equals(params.get("isAll"))) {
//				result = eMapper.setDcListFileDelete(params);
				result = eMapper.setDcListInfoDelete(params);
			}else {
				result = eMapper.setDcListFileDelete(params);
				System.out.println("하위 테이블만 삭제 333 >>> " + result);
			}
			
			System.out.println("최종 결과 333 > " + result);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
		
	}
	
	  @Override
	    public int updateGrid2Row(Map<String, Object> updateMap) {
	        try {
	            String code = (String) updateMap.get("code");
	            String codeNo = (String) updateMap.get("codeNo");
	            String fileDate = (String) updateMap.get("file_date");

	            Map<String, Object> params = new HashMap<>();
	            params.put("code", code);
	            params.put("codeNo", codeNo);
	            params.put("fileDate", fileDate);

	            int result = eMapper.updateGrid2Row(params);
	            return result;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return 0;
	        }
	    }

	    @Override
	    public void clearDcListFileEndDate(Map<String, Object> deleteMap) {
	        try {
	            // 종료일자 컬럼값 비우기
	            eMapper.clearDcListFileEndDate(deleteMap);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

		@Override
		public int deleteGrid2Row(Map<String, Object> updateMap) {
			try {
	            String code = (String) updateMap.get("code");
	            String codeNo = (String) updateMap.get("codeNo");
	            String fileEnddt = (String) updateMap.get("file_enddt");

	            Map<String, Object> params = new HashMap<>();
	            params.put("code", code);
	            params.put("codeNo", codeNo);
	            params.put("fileEnddt", fileEnddt);

	            int result = eMapper.deleteGrid2Row(params);
	            return result;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return 0;
	        }
		}
	}

		

