<#-- 生成实体类 -->
package ${entityPackageName};
 
<#if table.date_flag>
import java.util.Date;
</#if>
<#if table.math_flag>
import java.math.BigDecimal;
</#if>
import ${entityPackageName}.BaseBean;
 
/**
 * 
 * @author ${author}
 * ${dateTime}
 */
public class ${table.className?cap_first} extends BaseBean{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	<#-- 生成字段属性 -->
	<#list table.common_fields + table.key_fields as field>
	<#if (field.field_name != 'id' && field.field_name != 'createDate' && field.field_name != 'updateDate')>
	/**
	 * ${field.field_comment}
	 */
	private ${field.java_type} ${field.field_name};
	</#if>
	</#list>
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}	
 
	<#-- 生成字段get方法 -->
	<#list table.common_fields + table.key_fields as field>
	<#if (field.field_name != 'id' && field.field_name != 'createDate' && field.field_name != 'updateDate')>
	public ${field.java_type} get${field.field_name?cap_first}(){
		return this.${field.field_name};
	}
	</#if>
	</#list>
	
	<#-- 生成字段set方法 -->
	<#list table.common_fields + table.key_fields as field>
	<#if (field.field_name != 'id' && field.field_name != 'createDate' && field.field_name != 'updateDate')>
	public void set${field.field_name?cap_first}(${field.java_type} ${field.field_name}){
		this.${field.field_name} = ${field.field_name};
	}
	</#if>
	</#list>	
 
}