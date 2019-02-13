package ${servicePackageName}.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ${table.package_name_base}.dao.${table.className?cap_first}Dao;
import ${entityPackageName}.${table.className?cap_first};
import ${servicePackageName}.${table.className?cap_first}Service;
import ${basePackageName}.GenericService;

/**
 * 
 * @author ${author}
 * ${dateTime}
 */
@Service("${table.className?uncap_first}Service")
public class ${table.className?cap_first}ServiceImpl extends GenericService<${table.className?cap_first},Integer>  implements ${table.className?cap_first}Service {
	
	@Autowired
	private ${table.className?cap_first}Dao ${table.className?uncap_first}Dao;

}
