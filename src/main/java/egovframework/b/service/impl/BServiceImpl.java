package egovframework.b.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.b.mapper.BMapper;
import egovframework.b.model.QcResultDTO;
import egovframework.b.model.QcResultDateDTO;
import egovframework.b.model.QcResultGumsaResponseDTO;
import egovframework.b.model.QcResultRequestDTO;
import egovframework.b.model.UserBDTO;
import egovframework.b.model.QcCodeDTO;
import egovframework.b.service.BService;

@Service("BService")
public class BServiceImpl implements BService {

	@Resource(name = "BMapper")
	private BMapper bMapper;

	@Override
	public int joinUser(UserBDTO dto) {
		return bMapper.joinUser(dto);
	}

	@Override
	public boolean duplicate(UserBDTO dto) {

		int result = bMapper.duplicate(dto);
		if (result == 1)
			return true;
		return false;
	}

	@Override
	public UserBDTO findOne(String id) {
		return bMapper.findOne(id);
	}

	@Override
	public List<String> qcResultDate(QcResultDateDTO qcResultDateDTO) {
		List<String> list = bMapper.qcResultDate(qcResultDateDTO);
		return list;
	}

	@Override
	public List<Map<String, Object>> qcResultFindHashMap(QcResultRequestDTO qcResultDTO) {
		return bMapper.qcResultFindHashMap(qcResultDTO);
	}

	@Override
	public List<String> gumsapartList() {
		return bMapper.gumsapartFindAll();
	}

	@Override
	public List<String> jangbiFindAll() {
		return bMapper.jangbiFindAll();
	}

	@Override
	public List<String> levelList() {
		return bMapper.levelListFindAll();
	}

	@Override
	public List<QcCodeDTO> qcCodeList(String data) {
		return bMapper.qcCodeFindAll(data);
	}

	@Override
	public int save(List<Map<String, Object>> list) {
		int result = 0;
		int updateRow = 0, deleteRow = 0;

		for (Map<String, Object> map : list) {
			String qcCode = bMapper.findQcCode(map.get("QC물질명").toString());
			List<String> testCode = bMapper.findTestCode(String.valueOf(map.get("검사명")));
			map.put("qcCode", qcCode);
			map.put("testCode", testCode);

			switch ((String) map.get("flag")) {
			case "U":
				updateRow = bMapper.update(map);
				break;
			case "D":
				deleteRow = bMapper.delete(map);
				break;
			default:
			}
			result = result + updateRow + deleteRow;
		}

		return result;
	}

	@Override
	public String qcCodeFindOne(String data) {
		return bMapper.qcCodeFindOne(data);
	}

	@Override
	public List<QcResultGumsaResponseDTO> findGumsa() {
		return bMapper.findGumsa();
	}

}
