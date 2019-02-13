<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${daoPackageName}.${table.className?cap_first}Dao">

	<#-- 生成插入记录的方法 -->
	<insert id="insert" parameterType="${entityPackageName}.${table.className?cap_first}" useGeneratedKeys="true" keyProperty="${table.key_fields[0].field_name}">
		insert into ${table.tableName} (
		<#list (table.common_fields) as field>
		<#if field_index == 0>
			${field.field_name}
		<#else>
			,${field.field_name}
		</#if>
		</#list>
		)
		 values
		 (
			<#list (table.common_fields) as field>
			<#if field_index ==0>
			${"#"}{${field.field_name}}
			<#else>
			<#if (field.field_name == 'createDate' || field.field_name == 'updateDate')>
			,now()
			<#else>
			,${"#"}{${field.field_name}}
			</#if>
			</#if>
			</#list>
		)
	</insert>
	
	<#if table.key_fields?size != 0>
	<#-- 主键只有一个时 -->	
	<#if table.key_fields?size == 1>
	<update id="update" parameterType="${entityPackageName}.${table.className?cap_first}" >
		update ${table.tableName} set updateDate = now()
		<#list table.common_fields as field>
			<#if (field.field_name != 'createDate' && field.field_name != 'updateDate')>
			<if test="null != ${field.field_name} <#if field.java_type != 'Integer'>and ''!= ${field.field_name}</#if>">
				,${field.field_name} = ${"#"}{${field.field_name}}
			</if>
			</#if>
		</#list>
		where ${table.key_fields[0].field_name} = ${"#"}{${table.key_fields[0].field_name}}
	</update>
	</#if>
	</#if>
	
	<#-- 根据map查询列表 -->
	<select id="select" parameterType="Map" resultType="${dtoPackageName}.${table.className?cap_first}DTO">
 		select * from ${table.tableName}
 		where 1=1
 		
 		<#list table.common_fields as field>
 			<#if (field.field_name != 'createDate' && field.field_name != 'updateDate')>
 			<if test="null != ${field.field_name} <#if field.java_type != 'Integer'>and ''!= ${field.field_name}</#if>">
				and ${field.field_name} = ${"#"}{${field.field_name}}
			</if> 
			</#if>
 		</#list>
 		
 		order by createDate desc
 		<if test="null != startNo and null != endNo">
 			limit ${"#"}{startNo},${"#"}{endNo}
 		</if>
 	</select>
 	
 	<#-- 根据map查询条数-->
 	<select id="count" parameterType="Map" resultType="int">
 		select count(*) from ${table.tableName}
 		where 1=1
 		<#list table.common_fields as field>
 			<#if (field.field_name != 'createDate' && field.field_name != 'updateDate')>
 			<if test="null != ${field.field_name} <#if field.java_type != 'Integer'>and ''!= ${field.field_name}</#if>">
				and ${field.field_name} = ${"#"}{${field.field_name}}
			</if>
			</#if> 
 		</#list>
 	</select>
 	
 	<#-- 根据id获取对象-->
 	<select id="get" parameterType="Integer" resultType="${dtoPackageName}.${table.className?cap_first}DTO">
 		select * from ${table.tableName} where ${table.key_fields[0].field_name} = ${"#"}{${table.key_fields[0].field_name}} limit 1
 	</select>
 	
 	<select id="getByMap" parameterType="Map" resultType="${dtoPackageName}.${table.className?cap_first}DTO">
 		select  * from ${table.tableName} 
 		WHERE 1=1
	 		<#list table.common_fields as field>
	 			<#if (field.field_name != 'createDate' && field.field_name != 'updateDate')>
	 			<if test="null != ${field.field_name} <#if field.java_type != 'Integer'>and ''!= ${field.field_name}</#if>">
					and ${field.field_name} = ${"#"}{${field.field_name}}
				</if>
				</#if> 
	 		</#list>
	 	limit 1
 	</select>
 	
 	<select id="getListByMap" parameterType="Map" resultType="${dtoPackageName}.${table.className?cap_first}DTO">
 		select * from ${table.tableName} 
 		WHERE 1=1
	 		<#list table.common_fields as field>
	 			<#if (field.field_name != 'createDate' && field.field_name != 'updateDate')>
	 			<if test="null != ${field.field_name} <#if field.java_type != 'Integer'>and ''!= ${field.field_name}</#if>">
					and ${field.field_name} = ${"#"}{${field.field_name}}
				</if> 
				</#if>
	 		</#list>
 	</select>
 	
 	<#-- 获取最大id-->
 	<select id="getMaxId" resultType="java.lang.Integer">
 		select IFNULL(Max(id),0)  from ${table.tableName}
 	</select>
 	
 	<delete id="delete" parameterType="int">
		delete from ${table.tableName} where ${table.key_fields[0].field_name} = ${"#"}{${table.key_fields[0].field_name}}
	</delete>
	
	
	<delete id="deleteByMap" parameterType="Map">
		delete from ${table.tableName} where 1=1
		<#list (table.common_fields + table.key_fields) as field>
			<#if (field.field_name != 'createDate' && field.field_name != 'updateDate')>
			<if test="null != ${field.field_name} <#if field.java_type != 'Integer'>and ''!= ${field.field_name}</#if>">
				and ${field.field_name} = ${"#"}{${field.field_name}}
			</if> 
			</#if>
		</#list>
	</delete>

</mapper>