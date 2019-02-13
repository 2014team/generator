package ${voPackageName};

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import ${entityPackageName}.${table.className?cap_first};

/**
 * 
 * @author ${author}
 * ${dateTime}
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class ${table.className?cap_first}Vo extends ${table.className?cap_first}{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

}
