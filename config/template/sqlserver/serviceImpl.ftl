package ${servicePackageName}.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.beans.BeanUtils;

import ${table.package_name_base}.dao.${table.className?cap_first}Dao;
import ${entityPackageName}.${table.className?cap_first};
import ${servicePackageName}.${table.className?cap_first}Service;
import ${basePackageName}.GenericService;
import ${basePackageName}.Pager;
import ${voPackageName}.${table.className?cap_first}Vo;
/**
 * 
 * @author ${author}
 * ${dateTime}
 */
@Service("${table.className?uncap_first}Service")
public class ${table.className?cap_first}ServiceImpl extends GenericService<${table.className?cap_first},Integer>  implements ${table.className?cap_first}Service {
	
	@Autowired
	private ${table.className?cap_first}Dao ${table.className?uncap_first}Dao;
	
	/**
	* @Title: getPageList
	* @Description: 列表
	* @author ${author}
	* @date  ${dateTime}
	* @param pager
	* @param paramMap
	* @return
	*/
	public Pager getPageList(Pager page, Map<String,Object> paramMap){
		// 根据paramMap获取数据条数
		Integer totalSize = ${table.className?uncap_first}Dao.count(paramMap);
		if(totalSize < 1){
			return page;
		}
		page.setTotalSize(totalSize);

		// 根据paramMap获取数据
		paramMap.put("startNo",page.getBegin());
		paramMap.put("endNo",page.getEnd());
		List<${table.className?cap_first}> list = select(paramMap);
		page.setList(list);
		return page;
	}
	
	
	/**
	* @Title: save${table.className?cap_first}
	* @Description: 保存
	* @author ${author}
	* @date  ${dateTime}
	* @param entity
	* @return
	*/
	@Override
	public int save${table.className?cap_first}(${table.className?cap_first} entity) {
		return ${table.className?uncap_first}Dao.insert(entity);
	}

	/**
	* @Title: update${table.className?cap_first}
	* @Description: 更新
	* @author ${author}
	* @date  ${dateTime}
	* @param entity
	* @return
	*/
	@Override
	public int update${table.className?cap_first}(${table.className?cap_first} entity) {
<#list table.common_fields + table.key_fields as field>
	<#if (field.java_type == 'String')>
		if(StrUtils.isNull(entity.get${field.field_name?cap_first}())){
			entity.set${field.field_name?cap_first}("");
		}
	<#elseif (field.java_type == 'Integer')>
		if(null == entity.get${field.field_name?cap_first}()){
			entity.set${field.field_name?cap_first}(0);
		}
	</#if>
</#list>
		return ${table.className?uncap_first}Dao.update(entity);
	}

	/**
	* @Title: conversion
	* @Description: 转换
	* @author ${author}
	* @date  ${dateTime}
	* @param source
	* @return
	*/
	@Override
	public ${table.className?cap_first} conversion(${table.className?cap_first}Vo source) {
		${table.className?cap_first} target = new ${table.className?cap_first}();
        BeanUtils.copyProperties(source, target);
		return target;
	}
	

}
