package ${controllerPackageName};

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;

import ${basePackageName}.ResponseDTO;
import ${entityPackageName}.${table.className?cap_first};
import ${voPackageName}.${table.className?cap_first}Vo;
import ${servicePackageName}.${table.className?cap_first}Service;
import ${basePackageName}.BaseController;
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
	public ResponseDTO list(${table.className?cap_first}Vo ${table.className?uncap_first}Vo,Pager page,HttpServletRequest request, HttpServletResponse response){
		ResponseDTO responseDTO = new ResponseDTO();
		
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
		
		responseDTO.success(page);
		
		return responseDTO;
		
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
	public ResponseDTO detail(Integer id,HttpServletRequest request, HttpServletResponse response){
		ResponseDTO responseDTO = new ResponseDTO();
		
		if(null == id){
			responseDTO.failure("id不能为空");
			return responseDTO;
		}
		${table.className?cap_first} ${table.className?uncap_first} = ${table.className?uncap_first}Service.get(id);
		if(null == ${table.className?uncap_first}){
			responseDTO.failure("数据不存在");
			return responseDTO;
		}
		
		responseDTO.success(${table.className?uncap_first});
		return responseDTO;
		
	}
	
	/**
	 * 保存
	 * @param ${table.className?uncap_first}
	 * @param request
	 * @param response
	 * @return
	 * @author ${author}
	 * ${dateTime}
	 */
	@RequestMapping("/${table.className?uncap_first}/save")
	@ResponseBody
	public ResponseDTO save(${table.className?cap_first}Vo ${table.className?uncap_first}Vo,HttpServletRequest request, HttpServletResponse response){
		ResponseDTO responseDTO = new ResponseDTO();
		
		Integer id = ${table.className?uncap_first}Vo.getId();
		if(null == id ){
			//新增
			//int maxId = ${table.className?uncap_first}Service.getMaxId();
			//String ${table.className}Id = IDUtil.get${table.className?cap_first}Num(maxId+1);
			//${table.className?uncap_first}Vo.set${table.className?cap_first}Num(${table.className}Id);
		}
		int count = ${table.className?uncap_first}Service.saveOrUpdate(${table.className?uncap_first}Vo);
		if(count <= 0){
			responseDTO.failure();
			return responseDTO;
			
		}
		//成功
		responseDTO.success();
		return responseDTO;
		
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
	public ResponseDTO delete(${table.className?cap_first}Vo ${table.className?uncap_first}Vo,HttpServletRequest request, HttpServletResponse response){
		ResponseDTO responseDTO = new ResponseDTO();
		
		Integer id = ${table.className?uncap_first}Vo.getId();
		if(null == id ){
			responseDTO.failure("id不能为空");
			return responseDTO;
		}
		int count = ${table.className?uncap_first}Service.delete(id);
		if(count <= 0){
			responseDTO.failure();
			return responseDTO;
			
		}
		//成功
		responseDTO.success();
		return responseDTO;
		
	}
	
}
