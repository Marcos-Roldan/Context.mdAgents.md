import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Conexion {

    private final Path archivo;
    private final String url;

    public Conexion(Path archivo) {
        this.archivo = archivo;
        this.url = "jdbc:sqlite:" + archivo.toAbsolutePath();
    }

    public boolean primeraConexion() {

        try {
            // Se añade la carga explícita del driver para evitar el error No suitable driver found
            Class.forName("org.sqlite.JDBC");

            try (Connection conexion = DriverManager.getConnection(url)) {
                try (Statement configuracion = conexion.createStatement()) {
                    configuracion.execute("PRAGMA foreign_keys = ON;");

                    String sqlClientes = "CREATE TABLE IF NOT EXISTS clientes (" +
                            "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                            "nombre TEXT NOT NULL);";

                    configuracion.execute(sqlClientes);
                }

                System.out.println("Conexión SQLITE abierta: " + archivo.toAbsolutePath());
                System.out.println("Conexión válida: " + conexion.isValid(5));
                return true;
            }
        } catch (ClassNotFoundException e) {
            System.err.println("No se encuentra el driver de SQLite: " + e.getMessage());
            return false;
        } catch (SQLException e) {
            System.err.println("Error al conectar con SQLite: " + e.getMessage());
            return false;
        }
    }

    public Connection obtenerConexion() throws SQLException {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encuentra el driver de SQLite", e);
        }

        Connection conexion = DriverManager.getConnection(url);
        try (Statement configuracion = conexion.createStatement()) {
            configuracion.execute("PRAGMA foreign_keys = ON;");

            String sqlClientes = "CREATE TABLE IF NOT EXISTS clientes (" +
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                    "nombre TEXT NOT NULL);";

            configuracion.execute(sqlClientes);
        }
        return conexion;
    }
}