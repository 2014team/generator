package ${daoPackageName};

import ${entityPackageName}.${table.className?cap_first};
import ${basePackageName}.GenericDao;
import org.springframework.stereotype.Repository;

/**
 * 
 * @author ${author}
 * ${dateTime}
 */
@Repository
public interface ${table.className?cap_first}Dao extends GenericDao<${table.className?cap_first},Integer>{

}
