package generator.factory;

import generator.db.DataBaseUtil;
import generator.go.GeneratorCode;
import generator.go.impl.MysqlGeneratorImpl;
import generator.go.impl.SqlserverGeneratorImpl;

public class GeneratorFactory {
	
	public static GeneratorCode getGenerator(){
		
		String dbType = DataBaseUtil.getDbType();
		if(null != dbType){
			if(dbType.equals("mysql")){
				return new MysqlGeneratorImpl();
				
			}else if(dbType.equals("sqlserver")){
				return new SqlserverGeneratorImpl();
				
			}
		}
		return null;
	}

}
