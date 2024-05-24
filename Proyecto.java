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
                System.out.println("1- Insertar un Cine");
                System.out.println("2- Insertar una Sala en un Cine");
                System.out.println("3- Listar todos los Cines con la informacion de sus Salas");
                System.out.println("4- Salir");
                System.out.print("Ingresa la opcion: ");
            
                opcion = entrada.nextInt();
                Scanner lectura = new Scanner(System.in);
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
                        System.out.print("\033[H\033[2J");
                        System.out.flush();
                        System.out.print("Nombre del cine: ");
                        nombre_cine = lectura.nextLine();
                        System.out.print("Telefono del cine: ");
                        telefono = lectura.nextLine();
                        System.out.print("Direccion del cine: ");
                        direccion = lectura.nextLine();

                        consulta = "insert into proyecto.cine (nombre_cine, telefono, direccion) values ('" + nombre_cine + "', '" + telefono + "', '" + direccion + "')";
                        enviador = connection.prepareStatement(consulta);
                        enviador.executeUpdate();
                        System.out.print("\033[H\033[2J");
                        System.out.flush();
                        break;
                    case 2:
                        System.out.print("\033[H\033[2J");
                        System.out.flush();
                        System.out.println("Ingresando un nuevo cine: \n");
                        System.out.print("Numero de sala: ");
                        numero_sala = lectura.nextInt();
                        lectura.nextLine();
                        System.out.print("Cantidad de butacas: ");
                        cant_butacas = lectura.nextInt();
                        lectura.nextLine();
                        System.out.print("Cine al que pertenece: ");
                        nombre_cine = lectura.nextLine();

                        consulta = "insert into proyecto.sala (numero_sala, cant_butacas, nombre_cine) values (" + numero_sala + ", " + cant_butacas + ", '" + nombre_cine + "')";
                        enviador = connection.prepareStatement(consulta);
                        enviador.executeUpdate();
                        System.out.print("\033[H\033[2J");
                        System.out.flush();
                        break;
                    case 3:
                        System.out.print("\033[H\033[2J");
                        System.out.flush();
                        consulta = "select nombre_cine, numero_sala from proyecto.cine natural join proyecto.sala order by nombre_cine";
                        enviador = connection.prepareStatement(consulta);
                        resultado = enviador.executeQuery();
                        System.out.println("Cines: \n");
                        while (resultado.next()) {
                            nombre_cine = resultado.getString("nombre_cine");
                            numero_sala = resultado.getInt("numero_sala");
                            System.out.println("- " + nombre_cine + " | Numero de Sala: " + numero_sala);
                        }
                        System.out.println("\n");
                        break;
                    case 4:
                        System.out.print("\033[H\033[2J");
                        System.out.flush();
                        System.out.println("Muchas gracias por usar este software");
                        lectura.close();
                        break;
                    default:
                        System.out.print("\033[H\033[2J");
                        System.out.flush();
                        System.out.println("Opción no existente, ingrese una opcion valida");
                }
            } while (opcion != 4);
            entrada.close();
            connection.close();

        } catch (ClassNotFoundException | SQLException lectura) {
            lectura.printStackTrace();
        }
    }
}
