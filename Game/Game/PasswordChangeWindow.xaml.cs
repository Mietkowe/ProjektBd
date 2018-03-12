using System;
using System.Collections.Generic;
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
using System.Windows.Shapes;

namespace Game
{
    /// <summary>
    /// Logika interakcji dla klasy PasswordChangeWindow.xaml
    /// </summary>
    public partial class PasswordChangeWindow : Window
    {
        private int _userID;

        public PasswordChangeWindow(int userID)
        {
            InitializeComponent();
            _userID = userID;
            OldPasswordPasswordBox.Focus();
        }

        private void AcceptButton_Click(object sender, RoutedEventArgs e)
        {
            using (var db = new DataBase())
            {
                var user = db.Players.FirstOrDefault(u => u.playerID == _userID);
                if (!HashManager.isPasswordValid(user.saltText, user.passwordHash, OldPasswordPasswordBox.Password))
                {
                    MessageBox.Show("Błędne hasło!");
                    return;
                }
                else
                {
                    if (NewPasswordPasswordBox.Password != NewPasswordConfirmationPasswordBox.Password)
                    {
                        MessageBox.Show("Hasła w polach 'Nowe hasło' oraz 'Powtórz nowe hasło' musz być identyczne");
                        return;
                    }
                    else
                    {
                        var salt = HashManager.createSalt();
                        user.saltText = salt;
                        user.passwordHash = HashManager.generateHash(NewPasswordPasswordBox.Password, salt);
                        db.SaveChanges();
                        this.Close();
                    }
                }
            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void NewPasswordConfirmationPasswordBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                AcceptButton_Click(null, null);
            }
        }
    }
}
