package ${controllerPackageName};

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;

import com.job36.mobile.bean.JsonResult;
import ${entityPackageName}.${table.className?cap_first};
import ${voPackageName}.${table.className?cap_first}Vo;
import ${servicePackageName}.${table.className?cap_first}Service;
import ${controllerPackageName}.BaseController;
import ${basePackageName}.Pager;

/**
 * 
 * @author ${author}
 * ${dateTime}
 */
@Controller
public class ${table.className?cap_first}Controller extends BaseController{
	
	@Autowired
	private ${table.className?cap_first}Service ${table.className?uncap_first}Service;
	
	/**
	 * 列表
	 * @param searchBean
	 * @param request
	 * @param response
	 * @return
	 * @author ${author}
	 * ${dateTime}
	 */
	@RequestMapping("/${table.className?uncap_first}/list")
	@ResponseBody
	public JsonResult list(${table.className?cap_first}Vo ${table.className?uncap_first}Vo,Pager page,HttpServletRequest request, HttpServletResponse response){
		JsonResult jsonResult = new JsonResult();
		
		Map<String,Object> paramMap = new HashMap<String,Object>();
		<#list table.common_fields + table.key_fields as field>
		<#if (field.java_type == 'String')>
		if(isNotEmpty(${table.className?uncap_first}Vo.get${field.field_name?cap_first}())){
			paramMap.put("${field.field_name}", ${table.className?uncap_first}Vo.get${field.field_name?cap_first}());
		}
		<#else>
		if(null != ${table.className?uncap_first}Vo.get${field.field_name?cap_first}()){
			paramMap.put("${field.field_name}", ${table.className?uncap_first}Vo.get${field.field_name?cap_first}());
		}
		</#if>
		</#list>
		
		page  = ${table.className?uncap_first}Service.getPageList(page,paramMap);
		
		jsonResult.success(page);
		
		return jsonResult;
		
	}
	
	/**
	 * 详情
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 * @author ${author}
	 * ${dateTime}
	 */
	@RequestMapping("/${table.className?uncap_first}/detail")
	@ResponseBody
	public JsonResult detail(Integer id,HttpServletRequest request, HttpServletResponse response){
		JsonResult jsonResult = new JsonResult();
		
		if(null == id){
			jsonResult.failure("id不能为空");
			return jsonResult;
		}
		${table.className?cap_first} ${table.className?uncap_first} = ${table.className?uncap_first}Service.get(id);
		if(null == ${table.className?uncap_first}){
			jsonResult.failure("数据不存在");
			return jsonResult;
		}
		
		jsonResult.success(${table.className?uncap_first});
		return jsonResult;
		
	}
	
	/**
	 * 保存
	 * @param ${table.className?uncap_first}Vo
	 * @param request
	 * @param response
	 * @return
	 * @author ${author}
	 * ${dateTime}
	 */
	@RequestMapping("/${table.className?uncap_first}/save")
	@ResponseBody
	public JsonResult save(${table.className?cap_first}Vo ${table.className?uncap_first}Vo,HttpServletRequest request, HttpServletResponse response){
		JsonResult jsonResult = new JsonResult();
		
		
		<#list table.common_fields + table.key_fields as field>
		<#if (field.java_type == 'String')>
		if(isEmpty(${table.className?uncap_first}Vo.get${field.field_name?cap_first}())){
			jsonResult.failure();
			return jsonResult;
		}
		<#else>
		if(null == ${table.className?uncap_first}Vo.get${field.field_name?cap_first}()){
			jsonResult.failure();
			return jsonResult;
		}
		</#if>
		</#list>



		int count = ${table.className?uncap_first}Service.saveOrUpdate(${table.className?uncap_first}Vo);
		if(count <= 0){
			jsonResult.failure();
			return jsonResult;
			
		}
		//成功
		jsonResult.success();
		return jsonResult;
		
	}
	
	/**
	 * 删除
	 * @param searchBean
	 * @param request
	 * @param response
	 * @return
	 * @author ${author}
	 * ${dateTime}
	 */
	@RequestMapping("/${table.className?uncap_first}/delete")
	@ResponseBody
	public JsonResult delete(${table.className?cap_first}Vo ${table.className?uncap_first}Vo,HttpServletRequest request, HttpServletResponse response){
		JsonResult jsonResult = new JsonResult();
		
		Integer id = ${table.className?uncap_first}Vo.getId();
		if(null == id ){
			jsonResult.failure("id不能为空");
			return jsonResult;
		}
		int count = ${table.className?uncap_first}Service.delete(id);
		if(count <= 0){
			jsonResult.failure();
			return jsonResult;
			
		}
		//成功
		jsonResult.success();
		return jsonResult;
		
	}
	
}
