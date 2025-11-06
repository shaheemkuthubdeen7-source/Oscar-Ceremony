import java.sql.*;
import java.util.Scanner;

public class DBUpdate{
  public static void updatePersonName(Connection connection, String personID, String newName) throws SQLException {
  
        String updateQuery = "UPDATE Person SET FullName = ? WHERE PersonID = ?";
        try (PreparedStatement ps = connection.prepareStatement(updateQuery)) {
            ps.setString(1, newName);
            ps.setString(2, personID);
            int rows = ps.executeUpdate();
            if (rows > 0)
                System.out.println("Name updated successfully!");
            else
                System.out.println("No record found for given PersonID.");
        }
    }
}
