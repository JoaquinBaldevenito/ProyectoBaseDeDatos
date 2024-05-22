import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;


public class Proyecto {

    public static void main(String[] args) {
        Connection connection = null;

        String driver = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost/proyecto";
        String username = "root";
        String password = "root";

        try{

            // carga el driver de la base de datos si no se cargo.
            Class.forName(driver);

            // establece la conexión de red a la base de datos.
            connection = DriverManager.getConnection(url, username, password);

            int opcion;
            Scanner entrada = new Scanner(System.in);

            do {
                System.out.println("1. Insertar un Cine");
                System.out.println("2. Insertar una Sala en un Cine");
                System.out.println("3. Listar todos los Cines con la informacion de sus Salas");
                System.out.println("4. Salir");
                System.out.print("Ingresa la opcion que desee: ");
            
                opcion = entrada.nextInt();
                Scanner e = new Scanner(System.in);
                String consulta;
                PreparedStatement enviador;
                ResultSet resultado;
                String nombre_cine;
                String telefono;
                String direccion;
                int numero_sala;
                int cant_butacas;
                switch(opcion) {
                    case 1:
                        System.out.print("Ingrese el nombre del cine: ");
                        nombre_cine = e.nextLine();
                        System.out.print("Ingrese el telefono del cine: ");
                        telefono = e.nextLine();
                        System.out.print("Ingrese la direccion del cine: ");
                        direccion = e.nextLine();

                        consulta = "insert into proyecto.cine (nombre_cine, telefono, direccion) values ('" + nombre_cine + "', '" + telefono + "', '" + direccion + "')";
                        enviador = connection.prepareStatement(consulta);
                        enviador.executeUpdate();
                        break;
                    case 2:
                        System.out.print("Ingrese el numero de la sala: ");
                        numero_sala = e.nextInt();
                        e.nextLine();
                        System.out.print("Ingrese la cantidad de butacas de la sala: ");
                        cant_butacas = e.nextInt();
                        e.nextLine();
                        System.out.print("Ingrese el cine al que pertenece la sala: ");
                        nombre_cine = e.nextLine();

                        consulta = "insert into proyecto.sala (numero_sala, cant_butacas, nombre_cine) values (" + numero_sala + ", " + cant_butacas + ", '" + nombre_cine + "')";
                        enviador = connection.prepareStatement(consulta);
                        enviador.executeUpdate();
                        break;
                    case 3:
                        consulta = "select nombre_cine, numero_sala from proyecto.cine natural join proyecto.sala order by nombre_cine";
                        enviador = connection.prepareStatement(consulta);
                        resultado = enviador.executeQuery();
                        while (resultado.next()) {
                            nombre_cine = resultado.getString("nombre_cine");
                            numero_sala = resultado.getInt("numero_sala");
                            System.out.println("Cine: " + nombre_cine + " | Numero de Sala: " + numero_sala);
                        }
                        break;
                    case 4:
                        e.close();
                        System.out.println("Muchas gracias por usar este software");
                        break;
                    default:
                        System.out.println("Opción no existente, ingrese una opcion valida");
                }
            } while (opcion != 5);
            entrada.close();
            connection.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
