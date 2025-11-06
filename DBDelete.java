import java.sql.*;
import java.util.Scanner;

public class DBDelete{
    public static void deletePersonInfo(Connection connection, String personID) throws SQLException {

    // Delete from Apart_Of first (foreign key)
    String deleteFromApartOf = "DELETE FROM Apart_Of WHERE PersonID = ?";
    try (PreparedStatement ps = connection.prepareStatement(deleteFromApartOf)) {
        ps.setString(1, personID);
        ps.executeUpdate();
    }

    // Get NominationID before deleting
    String getNomination = "SELECT NominationID FROM Person WHERE PersonID = ?";
    String nominationID = null;
    try (PreparedStatement ps = connection.prepareStatement(getNomination)) {
        ps.setString(1, personID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            nominationID = rs.getString("NominationID");
        }
    }

    if (nominationID != null) {
        // Delete from Awards first
        try (PreparedStatement ps = connection.prepareStatement("DELETE FROM Awards WHERE NominationID = ?")) {
            ps.setString(1, nominationID);
            ps.executeUpdate();
        }

        // Delete from Film (foreign key on Nomination)
        try (PreparedStatement ps = connection.prepareStatement("DELETE FROM Film WHERE NominationID = ?")) {
            ps.setString(1, nominationID);
            ps.executeUpdate();
        }
    }

    // Delete from Person
    String deletePerson = "DELETE FROM Person WHERE PersonID = ?";
    try (PreparedStatement ps = connection.prepareStatement(deletePerson)) {
        ps.setString(1, personID);
        ps.executeUpdate();
    }

    // Delete from Nomination
    if (nominationID != null) {
        try (PreparedStatement ps = connection.prepareStatement("DELETE FROM Nomination WHERE NominationID = ?")) {
            ps.setString(1, nominationID);
            ps.executeUpdate();
        }
    }

    System.out.println("Deleted Person and related records successfully.");
}

}
