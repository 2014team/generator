package generator.db.impl;

import generator.MyField;
import generator.MyTable;
import generator.db.DataBaseUtil;
import generator.db.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MySqlConnectionImpl extends DbConnection{

	@Override
	public MyTable getTable(String tableName) {
		Connection connection = getConnection();
		String sql = "show full columns from " + tableName;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		MyTable myTable = null;
		if(connection != null){
			try {
				preparedStatement = connection.prepareStatement(sql);
				rs = preparedStatement.executeQuery();
				
				myTable = new MyTable();
				List<MyField> commonFieldList = new ArrayList<MyField>();
				List<MyField> keyFieldList = new ArrayList<MyField>();
				
				//获取表的结构
				while(rs.next()){
					String field_name = rs.getString("Field");
					//注意：得到的Type可能是varchar(n),也可能是datetime
					String sql_type = rs.getString("Type");						
					String key = rs.getString("Key");
					String commont = rs.getString("Comment");
					String java_type = DataBaseUtil.getJavaTypeFromSQLType(sql_type);
					if(null == java_type){
						System.out.println("java_type==null,"+field_name+",sql_type="+sql_type);
					}
					//设置字段相关信息
					MyField field = new MyField();
					field.setField_name(field_name);
					field.setSql_type(sql_type);
					field.setJava_type(java_type);
					field.setField_comment(commont);						
					if(key != null && key.equalsIgnoreCase("pri")){
						field.setIs_primary(true);
						keyFieldList.add(field);
					}else{
						field.setIs_primary(false);
						commonFieldList.add(field);
					}
					//是否需要导java.math.BigDecimal包
					if(java_type.equalsIgnoreCase("bigdecimal"))
						myTable.setMath_flag(true);
					if(java_type.equalsIgnoreCase("date")||java_type.equalsIgnoreCase("time")||java_type.equalsIgnoreCase("timestamp"))
						myTable.setDate_flag(true);
				}
				myTable.setTableName(tableName);
				myTable.setCommon_fields(commonFieldList);
				myTable.setKey_fields(keyFieldList);
				
				String class_name = DataBaseUtil.getClassName(tableName);
				myTable.setClassName(class_name);
				
				return myTable;
			} catch (SQLException e) {
				e.printStackTrace();
				return myTable;
			} finally{
				try {
					if(rs != null)
						rs.close();
					if(preparedStatement != null)
						preparedStatement.close();
					if(connection != null)
						connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}		
		}else{
			return myTable;
		}
	}

}
