package egovframework.b.model;

import java.util.HashMap;
import java.util.Map;

public class QcResultDTO {
	private String qcName;
	private String gumsaName1;
	private String qcLevel;
	private String lotNo;
	private Double fixedMean;
	private Double fixedSD;
	private Double fixedCV;
	private Double cumMean;
	private Double cumSD;
	private Double cumCV;
	private Map<String, Double> dynamicColumns;

	public void addDynamicColumn(String columnName, Double columnValue) {
		if (dynamicColumns == null) {
			dynamicColumns = new HashMap<>();
		}
		dynamicColumns.put(columnName, columnValue);
	}

	public Map<String, Double> getDateColumns() {
		return dynamicColumns;
	}

	public void setDateColumns(Map<String, Double> dynamicColumns) {
		this.dynamicColumns = dynamicColumns;
	}

	public String getQcName() {
		return qcName;
	}

	public void setQcName(String qcName) {
		this.qcName = qcName;
	}

	public String getGumsaName1() {
		return gumsaName1;
	}

	public void setGumsaName1(String gumsaName1) {
		this.gumsaName1 = gumsaName1;
	}

	public String getQcLevel() {
		return qcLevel;
	}

	public void setQcLevel(String qcLevel) {
		this.qcLevel = qcLevel;
	}

	public String getLotNo() {
		return lotNo;
	}

	public void setLotNo(String lotNo) {
		this.lotNo = lotNo;
	}

	public Double getFixedMean() {
		return fixedMean;
	}

	public void setFixedMean(Double fixedMean) {
		this.fixedMean = fixedMean;
	}

	public Double getFixedSD() {
		return fixedSD;
	}

	public void setFixedSD(Double fixedSD) {
		this.fixedSD = fixedSD;
	}

	public Double getFixedCV() {
		return fixedCV;
	}

	public void setFixedCV(Double fixedCV) {
		this.fixedCV = fixedCV;
	}

	public Double getCumMean() {
		return cumMean;
	}

	public void setCumMean(Double cumMean) {
		this.cumMean = cumMean;
	}

	public Double getCumSD() {
		return cumSD;
	}

	public void setCumSD(Double cumSD) {
		this.cumSD = cumSD;
	}

	public Double getCumCV() {
		return cumCV;
	}

	public void setCumCV(Double cumCV) {
		this.cumCV = cumCV;
	}

}
