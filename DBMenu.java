import java.sql.*;
import java.util.Scanner;

public class DBMenu {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/Kuthubdeen_21833753?useSSL=false&allowPublicKeyRetrieval=true";

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter username: ");
        String username = scanner.nextLine();
        System.out.print("Enter password: ");
        String password = scanner.nextLine();

        try (Connection connection = DriverManager.getConnection(DB_URL, username, password)) {
            System.out.println("\nConnected to Oscars Database Successfully!\n");

            boolean exit = false;

            while (!exit) {
                System.out.println("\nOSCARS DATABASE MENU");
                System.out.println("1. Show results from Queries");
                System.out.println("2. Insert a Person with Nomination");
                System.out.println("3. Update Person Name");
                System.out.println("4. Delete Person and Related Records");
                System.out.println("5. Find Films and Awards by Person ID");
                System.out.println("6. Exit");
                System.out.print("Enter your choice: ");

                int choice = scanner.nextInt();
                scanner.nextLine(); // Consume newline

                switch (choice) {
                    case 1:
                        DBQuery.showPredefinedQueries(connection);
                        break;
                    case 2:
                        InsertPerson(scanner, connection);
                        break;
                    case 3:
                        ChangePersonName(scanner, connection);
                        break;
                    case 4:
                        deletePersonData(scanner, connection);
                        break;
                    case 5:
                        FindPersonData(scanner, connection);
                        break;
                    case 6:
                        exit = true;
                        System.out.println("Exiting...");
                        break;
                    default:
                        System.out.println("Invalid option, try again!");
                }
            }

        } catch (SQLException e) {
            System.out.println("Database Error: " + e.getMessage());
        }
    }


    private static void InsertPerson(Scanner scanner, Connection connection) throws SQLException {
          System.out.println("Enter PersonID: ");
          String PersonID=scanner.nextLine();
          System.out.print("Enter Full Name: ");
          String fullName = scanner.nextLine();

          System.out.print("Enter NominationID: ");
          String nominationID = scanner.nextLine();

          System.out.print("Enter CeremonyID: ");
          int ceremonyID = scanner.nextInt();
          scanner.nextLine();

          System.out.print("Is this person a Winner? (true/false): ");
          boolean winner = scanner.nextBoolean();
          scanner.nextLine();

          System.out.print("Enter Film Title (if no film just press ENTER): ");
          String filmTitle = scanner.nextLine();
          
          if (!filmTitle.isBlank()) {
             System.out.print("Enter FilmID: ");
            String filmID = scanner.nextLine();
            DBInsert.insertPersonWithFilm(connection,PersonID, fullName,nominationID,ceremonyID,winner, filmTitle, filmID);
          }else{
            DBInsert.insertPersonNoFilm(connection,PersonID, fullName,nominationID,ceremonyID,winner);
          }
    }



    private static void ChangePersonName(Scanner scanner, Connection connection) throws SQLException {
        System.out.print("Enter PersonID to update: ");
        String personID = scanner.nextLine();

        System.out.print("Enter new Full Name: ");
        String newName = scanner.nextLine();

        DBUpdate.updatePersonName(connection, personID, newName);
    }

    // === 4️⃣ Delete Person and related records ===
    private static void deletePersonData(Scanner scanner, Connection connection) throws SQLException {
        System.out.print("Enter PersonID for deletion: ");
        String personID = scanner.nextLine();

        DBDelete.deletePersonInfo(connection, personID);
    }


    private static void FindPersonData(Scanner scanner, Connection connection) throws SQLException {
        System.out.print("Enter PersonID for searching: ");
        String personID = scanner.nextLine();

        DBFind.FindPersonInfo(connection, personID);
    }

}

