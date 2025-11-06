import java.sql.*;
import java.util.Scanner;


public class DBInsert {


  public static void insertPersonWithFilm(Connection connection, String personID, String fullName, String nominationID,int ceremonyID, boolean winner, String filmTitle, String filmID) throws SQLException {

      


      String insertNomination = "INSERT INTO Nomination (NominationID, CeremonyID, Winner) VALUES (?, ?, ?)";
      try (PreparedStatement ps = connection.prepareStatement(insertNomination)) {
          ps.setString(1, nominationID);
          ps.setInt(2, ceremonyID);
          ps.setBoolean(3, winner);
          ps.executeUpdate();
      }


      String insertPerson = "INSERT INTO Person (PersonID, FullName, NominationID) VALUES (?, ?, ?)";
      try (PreparedStatement ps = connection.prepareStatement(insertPerson)) {
          ps.setString(1, personID);
          ps.setString(2, fullName);
          ps.setString(3, nominationID);
          ps.executeUpdate();
          System.out.println("Person added successfully!");
      }


      if (!filmTitle.equalsIgnoreCase("none") && !filmTitle.isBlank()) {
          // Check if FilmID exists
          String checkFilm = "SELECT COUNT(*) AS count FROM Film WHERE FilmID = ?";
          boolean filmExists = false;
          try (PreparedStatement ps = connection.prepareStatement(checkFilm)) {
              ps.setString(1, filmID);
              ResultSet rs = ps.executeQuery();
              if (rs.next() && rs.getInt("count") > 0) {
                  filmExists = true;
                  System.out.println("FilmID exists. Linking person to existing film.");
              }
          }


          if (!filmExists) {
              String insertFilm = "INSERT INTO Film (FilmID, NominationID, Title) VALUES (?, ?, ?)";
              try (PreparedStatement ps = connection.prepareStatement(insertFilm)) {
                  ps.setString(1, filmID);
                  ps.setString(2, nominationID);
                  ps.setString(3, filmTitle);
                  ps.executeUpdate();
                  System.out.println("New Film added successfully!");
              }
          }


          String insertApartOf = "INSERT INTO Apart_Of (FilmID, PersonID) VALUES (?, ?)";
          try (PreparedStatement ps = connection.prepareStatement(insertApartOf)) {
              ps.setString(1, filmID);
              ps.setString(2, personID);
              ps.executeUpdate();
              System.out.println("Person linked to film successfully!");
          }
      }
  }
  
  
  public static void insertPersonNoFilm(Connection connection, String personID, String fullName, String nominationID,int ceremonyID, boolean winner) throws SQLException {


      String insertNomination = "INSERT INTO Nomination (NominationID, CeremonyID, Winner) VALUES (?, ?, ?)";
      try (PreparedStatement ps = connection.prepareStatement(insertNomination)) {
          ps.setString(1, nominationID);
          ps.setInt(2, ceremonyID);
          ps.setBoolean(3, winner);
          ps.executeUpdate();
      }


      String insertPerson = "INSERT INTO Person (PersonID, FullName, NominationID) VALUES (?, ?, ?)";
      try (PreparedStatement ps = connection.prepareStatement(insertPerson)) {
          ps.setString(1, personID);
          ps.setString(2, fullName);
          ps.setString(3, nominationID);
          ps.executeUpdate();
          System.out.println("Person added successfully!");
      }
  }
}
