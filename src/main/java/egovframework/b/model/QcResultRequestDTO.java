package egovframework.b.model;

import java.util.List;
import lombok.*;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class QcResultRequestDTO {
	private String qcInOut;
	private String ruleResult;
	private String jundalPart;
	private String lotNo;
	private String level;
	private String jangbi;
	private String muljil;
	private String gumsa;
	private List<String> dateList;

}
