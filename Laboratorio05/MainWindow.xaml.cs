using System.Data;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Microsoft.Data.SqlClient;

namespace Laboratorio05
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        string connectionString = "Data Source=LAPTOP-R79EK4NG\\SQLEXPRESS2017;Initial Catalog=Neptuno;User ID =user322; Password =DOTA2wtf; TrustServerCertificate=True; Encrypt=True";
        public MainWindow()
        {
            InitializeComponent();
        }

        private void btnRegistrar_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("USP_InsertarCliente", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@idCliente", txtIdCliente.Text.Trim());
                    command.Parameters.AddWithValue("@NombreCompañia", txtNombreCompania.Text.Trim());
                    command.Parameters.AddWithValue("@NombreContacto", txtNombreContacto.Text.Trim());
                    command.Parameters.AddWithValue("@CargoContacto", txtCargoContacto.Text.Trim());
                    command.Parameters.AddWithValue("@Direccion", txtDireccion.Text.Trim());
                    command.Parameters.AddWithValue("@Ciudad", txtCiudad.Text.Trim());
                    command.Parameters.AddWithValue("@Region", txtRegion.Text.Trim());
                    command.Parameters.AddWithValue("@CodPostal", txtCodPostal.Text.Trim());
                    command.Parameters.AddWithValue("@Pais", txtPais.Text.Trim());
                    command.Parameters.AddWithValue("@Telefono", txtTelefono.Text.Trim());
                    command.Parameters.AddWithValue("@Fax", txtFax.Text.Trim());

                    command.ExecuteNonQuery();
                    MessageBox.Show("Cliente registrado correctamente");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al registrar: " + ex.Message);
            }
        }


        private void btnListar_Click(object sender, RoutedEventArgs e)
        {
            List<Cliente> listaClientes = new List<Cliente>();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand("USP_ListarClientes", connection);
                    command.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Cliente cliente = new Cliente()
                            {
                                IdCliente = reader["idCliente"].ToString(),
                                NombreCompañia = reader["NombreCompañia"].ToString(),
                                NombreContacto = reader["NombreContacto"].ToString(),
                                CargoContacto = reader["CargoContacto"].ToString(),
                                Direccion = reader["Direccion"].ToString(),
                                Ciudad = reader["Ciudad"].ToString(),
                                Region = reader["Region"].ToString(),
                                CodPostal = reader["CodPostal"].ToString(),
                                Pais = reader["Pais"].ToString(),
                                Telefono = reader["Telefono"].ToString(),
                                Fax = reader["Fax"].ToString()

                            };
                            listaClientes.Add(cliente);
                        }
                    }
                }

                dgClientes.ItemsSource = listaClientes;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al listar clientes: " + ex.Message);
            }
        }
    }
}