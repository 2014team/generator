package ${daoPackageName};

import ${entityPackageName}.${table.className?cap_first};
import ${basePackageName}.GenericDao;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 
 * @author ${author}
 * ${dateTime}
 */
@Repository
public interface ${table.className?cap_first}Dao extends GenericDao<${table.className?cap_first},Integer>{


/**
	* @Title: getByMap
	* @Description: 根据Map查询
	* @author ${author}
	* @date  ${dateTime}
	* @param paramMap
	* @return
	*/
	public ${table.className?cap_first} getByMap(Map<String,Object> paramMap);
	/**
	* @Title: getListByMap
	* @Description: 根据Map查询
	* @author ${author}
	* @date  ${dateTime}
	* @param paramMap
	* @return
	*/
	public List<${table.className?cap_first}> getListByMap(Map<String,Object> paramMap);
	/**
	* @Title: deleteByMap
	* @Description: 根据Map删除
	* @author ${author}
	* @date  ${dateTime}
	* @param paramMap
	* @return
	*/
	public Integer deleteByMap(Map<String,Object> paramMap);
}
