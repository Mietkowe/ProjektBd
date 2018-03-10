using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Game
{

    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        public MainWindow()
        {
            InitializeComponent();
            using (var db = new DataBase())
            {
                try
                {
                    if (!db.Database.Exists())
                    {
                        MessageBox.Show("Baza nie istnieje!");
                    }
                }
                catch (Exception e)
                {
                    MessageBox.Show("WYJĄTKIEM W TWARZ!\n" + e.Message);
                }

            }

        }



        private void Login_Button_Click(object sender, RoutedEventArgs e)
        {
            using (var db = new DataBase())
            {
                //var user = (from players in db.Players
                //            where players.nick == User_name.Text
                //            select players).FirstOrDefault();

                var user = db.Players.SingleOrDefault(u => u.nick == User_nameTextBox.Text);


                if (user == null)
                {
                    MessageBox.Show("Podany użytkownik nie istnieje!", "Uwaga!", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    string writtenPassword = PasswordPasswordBox.Password;
                    string salt = user.saltText;
                    if (HashManager.isPasswordValid(salt, user.passwordHash, writtenPassword))
                    {
                        MessageBox.Show("LOGOWANKO!");
                    }
                    else
                    {
                        MessageBox.Show("Błędne hasło");
                    }

                }
            }
        }

        private void PasswordPasswordBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                Login_Button_Click(null, null);
            }
        }

        private void Register_Button_Click(object sender, RoutedEventArgs e)
        {
            this.Hide();
            new RegistrationWindow().ShowDialog();
            this.Show();
        }
    }


}
