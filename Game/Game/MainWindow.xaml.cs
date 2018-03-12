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
            using (var db = new Model1())
            {
                if (db.Database.Exists())
                {
                    //Console.WriteLine("daj nowa anzwe");
                    //var name = Console.ReadLine();
                    //DateTime a = DateTime.Now;
                    //var k = new Table_1 { ID = 4, Name = "Mietek", Date = a };
                    //db.Table_1.Add(k);
                    //db.SaveChanges();
                    try {
                    
                     //   ExampleDatagrid.ItemsSource = db.Table_1.Local;
                    }
                    catch(Exception e)
                    {
                        string a = e.Message;
                        
                    }
                }
            }
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {

        }


        private void pnlMainGrid_MouseUp(object sender, MouseButtonEventArgs e)
        {
            MessageBox.Show("You clicked me at " + e.GetPosition(this).ToString());
          //  kek1.TextWrapping = TextWrapping.Wrap;
        }

        private void Login_Button_Click(object sender, RoutedEventArgs e)
        {
            using (var db = new Model1())
            {
                var user = db.Players.SingleOrDefault(u => u.nick == User_name.Text);
                if (user == null)
                {
                    MessageBox.Show("Podany użytkownik nie istnieje!", "Uwaga!", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    string a = Password.Password;
                    if (a != "")
                    {
                        var password = db.Players.Single(u => u.playerID == 1);
                        if (password == null)
                        {
                            MessageBox.Show("Podane hasło jest nieprawidłowe!", "Uwaga!", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                        else
                        {
                            MessageBox.Show("Udało ci się zalogować", "Uwaga!", MessageBoxButton.OK, MessageBoxImage.Information);
                            new App_Window().Show();
                            this.Close();
                        }
                    }
                }
            }
        }
    }


}
