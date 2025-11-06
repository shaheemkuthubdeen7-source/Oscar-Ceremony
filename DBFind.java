import java.sql.*;
import java.util.Scanner;

public class DBFind{
  public static void FindPersonInfo(Connection connection, String personID) throws SQLException {

    String query = """
            SELECT 
                p.PersonID,
                p.FullName,
                f.Title AS Film,
                ac.DisplayName AS AwardName,
                n.Winner
            FROM Person p
            LEFT JOIN Apart_Of ao ON ao.PersonID = p.PersonID
            LEFT JOIN Film f ON ao.FilmID = f.FilmID
            LEFT JOIN Nomination n ON p.NominationID = n.NominationID
            LEFT JOIN Awards aw ON n.NominationID = aw.NominationID
            LEFT JOIN AwardCategory ac ON aw.CategoryID = ac.CategoryID
            WHERE p.PersonID = ?
            """;

    try (PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, personID);
        ResultSet rs = ps.executeQuery();

        boolean found = false;
        while (rs.next()) {
            found = true;
            System.out.println("\nPerson ID: " + rs.getString("PersonID"));
            System.out.println("Name: " + rs.getString("FullName"));

            String film = rs.getString("Film");
            String award = rs.getString("AwardName");

            if (film != null) {
                System.out.println("Film: " + film);
            } else {
                System.out.println("Film: (Not associated with a Film)");
            }

            if (award != null) {
                System.out.println("Award: " + award);
                boolean winner = rs.getBoolean("Winner");
                System.out.println("Winner: " + (winner ? " Yes" : " No"));
            } else {
                System.out.println("Award: (No awards linked)");
            }
        }

        if (!found) {
            System.out.println("No person found with that ID.");
        }
    }
}
}
