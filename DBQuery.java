import java.sql.*;
import java.util.Scanner;

public class DBQuery{
  public static void showPredefinedQueries(Connection connection) {
        String[] queries = {
            "SELECT NominationID FROM Nomination WHERE Winner = TRUE",
            "SELECT PersonID, FullName FROM Person WHERE FullName LIKE 'D%'",
            "SELECT CeremonyID, Year FROM Ceremony WHERE CAST(Year AS UNSIGNED) > 2020 ORDER BY Year",
            "SELECT FilmID, UPPER(Title) AS UppercaseTitle FROM Film",
            "SELECT CategoryID, DisplayName FROM AwardCategory WHERE DisplayName LIKE '%Best%'",
            "SELECT ac.DisplayName AS Category, COUNT(a.NominationID) AS NominationCount FROM AwardCategory ac LEFT JOIN Awards a ON ac.CategoryID = a.CategoryID GROUP BY ac.DisplayName ORDER BY NominationCount DESC",
            "SELECT p.FullName, COUNT(ao.FilmID) AS FilmCount FROM Apart_Of ao JOIN Person p ON ao.PersonID = p.PersonID GROUP BY p.PersonID HAVING COUNT(ao.FilmID) > 1 ORDER BY FilmCount DESC",
            "SELECT ac.DisplayName AS AwardCategory, ac.AwardClass FROM Film f JOIN Nomination n ON f.NominationID = n.NominationID JOIN Awards a ON n.NominationID = a.NominationID JOIN AwardCategory ac ON a.CategoryID = ac.CategoryID WHERE f.Title = 'Ford v Ferrari' AND n.Winner = TRUE",
            "SELECT DISTINCT f.Title AS Film, c.Year AS YearWon FROM Film f JOIN Nomination n ON f.NominationID = n.NominationID JOIN Ceremony c ON n.CeremonyID = c.CeremonyID WHERE n.Winner = TRUE AND f.Title IS NOT NULL AND TRIM(f.Title) <> '' ORDER BY f.Title, c.Year",
            "SELECT p.FullName AS Person, f.Title AS Film, ac.DisplayName AS AwardCategory FROM Person p JOIN Apart_Of ao ON p.PersonID = ao.PersonID JOIN Film f ON ao.FilmID = f.FilmID JOIN Nomination n ON f.NominationID = n.NominationID JOIN Awards a ON n.NominationID = a.NominationID JOIN AwardCategory ac ON a.CategoryID = ac.CategoryID WHERE n.Winner = TRUE ORDER BY p.FullName, f.Title, ac.DisplayName"
        };

        String[] descriptions = {
            "1. Nomination IDs of Winners:",
            "2. People whose name starts with 'D':",
            "3. Ceremonies after 2020:",
            "4. Films with Title in Uppercase:",
            "5. Awards containing 'Best':",
            "6. Nomination count per Award Category:",
            "7. People involved in more than one film:",
            "8. What award did 'Ford v Ferrari' win:",
            "9. Films that have won awards and their years:",
            "10. People who won awards and their related films:"
        };

        for (int i = 0; i < queries.length; i++) {
            System.out.println("\n========================================");
            System.out.println(descriptions[i]);
            System.out.println("========================================");
            try (PreparedStatement ps = connection.prepareStatement(queries[i]);
                 ResultSet rs = ps.executeQuery()) {

                ResultSetMetaData meta = rs.getMetaData();
                int columnCount = meta.getColumnCount();

                while (rs.next()) {
                    for (int j = 1; j <= columnCount; j++) {
                        System.out.print(meta.getColumnLabel(j) + ": " + rs.getString(j) + "   ");
                    }
                    System.out.println();
                }

            } catch (SQLException e) {
                System.out.println("❌ Error running query: " + e.getMessage());
            }
        }
    }
}
