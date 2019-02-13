package generator.factory;

import generator.db.DataBaseUtil;
import generator.db.DbConnection;
import generator.db.impl.MySqlConnectionImpl;
import generator.db.impl.SqlserverConnectionImpl;

public class DbConnectionFactory {
	
	public static DbConnection getDbConnection(){
		String dbType = DataBaseUtil.getDbType();
		if(null != dbType){
			if(dbType.equals("mysql")){
				return new MySqlConnectionImpl();
				
			}else if(dbType.equals("sqlserver")){
				return new SqlserverConnectionImpl();
				
			}
		}
		return null;
	}
}
