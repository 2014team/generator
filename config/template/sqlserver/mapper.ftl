<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${daoPackageName}.${table.className?cap_first}Dao">

	<sql id="sql_body">
		select 
		<#list (table.common_fields) as field>
		<#if field_index == 0>
			${field.field_name}
		<#else>
			,${field.field_name}
		</#if>
		</#list>
		 from ${table.tableName}
	</sql>
	
	<sql id="sql_body_one">
		select 
		<#list (table.common_fields) as field>
		<#if field_index == 0>
			${field.field_name}
		<#else>
			,${field.field_name}
		</#if>
		</#list>
		 from ${table.tableName}
	</sql>
	

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
			,getDate()
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
		update ${table.tableName} set updateDate = getDate()
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
	<select id="select" parameterType="Map" resultType="${entityPackageName}.${table.className?cap_first}DTO">
 		WITH OrderedResults AS
			  ( SELECT *,Row_number() OVER (ORDER BY ${table.key_fields[0].field_name} DESC) AS RowNumber
			   FROM dbo.${table.tableName}
			   WHERE 1=1
			 		<#list table.common_fields as field>
			 			<#if (field.field_name != 'createDate' && field.field_name != 'updateDate')>
			 			<if test="null != ${field.field_name} <#if field.java_type != 'Integer'>and ''!= ${field.field_name}</#if>">
							and ${field.field_name} = ${"#"}{${field.field_name}}
						</if> 
						</#if>
			 		</#list>
			   )
			SELECT *
			FROM OrderedResults
			WHERE RowNumber BETWEEN ${"#"}{startNo} AND ${"#"}{endNo}	
			
 	</select>
 	<#-- 根据map查询条数-->
 	
 	<#-- 根据Map统计数据 -->
	<select id="count" parameterType="Map" resultType="java.lang.Integer">
	   SELECT count(1)FROM dbo.${table.tableName}
	   WHERE 1=1
 		<#list table.common_fields as field>
 			<#if (field.field_name != 'createDate' && field.field_name != 'updateDate')>
 			<if test="null != ${field.field_name} <#if field.java_type != 'Integer'>and ''!= ${field.field_name}</#if>">
				and ${field.field_name} = ${"#"}{${field.field_name}}
			</if> 
			</#if>
 		</#list>
 	</select>
 	<#-- 根据Map统计数据-->
 	
 	
 	<#-- 根据id获取对象-->
 	<select id="get" parameterType="Integer" resultType="${entityPackageName}.${table.className?cap_first}">
 		select top 1 * from ${table.tableName} where ${table.key_fields[0].field_name} = ${"#"}{${table.key_fields[0].field_name}}
 	</select>
 	
 	<select id="getByMap" parameterType="Map" resultType="${entityPackageName}.${table.className?cap_first}">
 		<include refid="sql_body_one"/>
	 		<#list table.common_fields as field>
	 			<#if (field.field_name != 'createDate' && field.field_name != 'updateDate')>
	 			<if test="null != ${field.field_name} <#if field.java_type != 'Integer'>and ''!= ${field.field_name}</#if>">
					and ${field.field_name} = ${"#"}{${field.field_name}}
				</if>
				</#if> 
	 		</#list>
 	</select>
 	
 	<select id="getListByMap" parameterType="Map" resultType="${entityPackageName}.${table.className?cap_first}">
 		<include refid="sql_body"/>
	 		<#list table.common_fields as field>
	 			<#if (field.field_name != 'createDate' && field.field_name != 'updateDate')>
	 			<if test="null != ${field.field_name} <#if field.java_type != 'Integer'>and ''!= ${field.field_name}</#if>">
					and ${field.field_name} = ${"#"}{${field.field_name}}
				</if> 
				</#if>
	 		</#list>
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