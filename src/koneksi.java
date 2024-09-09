
  
  import java.sql.Connection;
  import java.sql.DriverManager;
  import java.sql.Statement;
  import java.sql.PreparedStatement;
  import java.sql.SQLException;
  
          
public class koneksi {
    private static Connection con;
    
//    public static PreparedStatement ps;
//    public static Statement stm;
//    public static Exception exc;
//      public static void main(String args[]){
    public static Connection configDB() throws SQLException{
          try{
              String url ="jdbc:mysql://localhost/laundry";
              String user ="root";
              String pass = "";
              DriverManager.registerDriver(new com.mysql.jdbc.Driver());
              con=DriverManager.getConnection(url,user,pass);        

//              Class.forName("com.mysql.jdbc.Driver");
              System.out.println("Koneksi Berhasil !");
          }catch (Exception e) {
              System.out.println("Koneksi Gagal !"+e.getMessage());
              
          }
      return con;
    }
    
}
    
    

