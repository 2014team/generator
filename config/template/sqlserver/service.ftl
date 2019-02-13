package ${servicePackageName};

import ${entityPackageName}.${table.className?cap_first};
import ${basePackageName}.Pager;
import java.util.Map;
import ${voPackageName}.${table.className?cap_first}Vo;


/**
 * 
 * @author ${author}
 * ${dateTime}
 */
public interface ${table.className?cap_first}Service extends BaseService<${table.className?cap_first},Integer>{

	/**
	* @Title: getPageList
	* @Description: 列表
	* @author ${author}
	* @date  ${dateTime}
	* @param pager
	* @param paramMap
	* @return
	*/
	public Pager getPageList(Pager pager, Map<String,Object> paramMap);
	
	/**
	* @Title: save${table.className?cap_first}
	* @Description: 保存
	* @author ${author}
	* @date   ${dateTime}
	* @param entity
	* @return
	*/
	public int save${table.className?cap_first}(${table.className?cap_first} entity);

	/**
	* @Title: updateCrmPushResumeHistory
	* @Description: 更新
	* @author ${author}
	* @date   ${dateTime}
	* @param entity
	* @return
	*/
	public int update${table.className?cap_first}(${table.className?cap_first} entity);
	
	/**
	* @Title: conversion
	* @Description: 转换
	* @author ${author}
	* @date   ${dateTime}
	* @param source
	* @return
	*/
	public CrmPushResumeHistory conversion(${table.className?cap_first}Vo source);
}
