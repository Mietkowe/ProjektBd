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
    /// Logika interakcji dla klasy RegistrationWindow.xaml
    /// </summary>
    public partial class RegistrationWindow : Window
    {
        public RegistrationWindow()
        {
            InitializeComponent();
            NickTextBox.Focus();

            using (var db = new DataBase())
            {
                var itemList = new List<string>();
                foreach (var group in db.PlayerGroups)
                {
                    itemList.Add(group.name);
                }
                GroupComboBox.ItemsSource = itemList;
            }
        }

        private void AcceptButton_Click(object sender, RoutedEventArgs e)
        {
            if (isAccountInfoValid())
            {
                var newPlayer = new Players();
                newPlayer.nick = NickTextBox.Text;

                try
                {
                    newPlayer.age = Convert.ToByte(AgeTextBox.Text);
                }
                catch
                {
                    MessageBox.Show("Wiek musi być liczbą!");
                    return;
                }
                    

                using (var db = new DataBase())
                {
                    var groupID = (from item in db.PlayerGroups
                                    where item.name == GroupComboBox.SelectedItem.ToString()
                                    select item.groupID).FirstOrDefault();

                    newPlayer.groupID = groupID;
                }

                var salt = HashManager.createSalt();
                newPlayer.saltText = salt;

                var passwordHash = HashManager.generateHash(PasswordPasswordBox.Password, salt);
                newPlayer.passwordHash = passwordHash;

                using (var db = new DataBase())
                {
                    db.Players.Add(newPlayer);
                    db.SaveChanges();
                }
                this.Close();

            }
        }

        private void PasswordConfirmationPasswordBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                AcceptButton_Click(null, null);
            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private bool isAccountInfoValid()
        {
            if (NickTextBox.Text == null || NickTextBox.Text == string.Empty)
            {
                MessageBox.Show("Pole 'Nick' musi być wypełnione");
                return false;
            }

            using (var db = new DataBase())
            {
                var existingNicks = from player in db.Players
                                    select player.nick;
                if (existingNicks.Contains(NickTextBox.Text))
                {
                    MessageBox.Show("onto z takim nickiem już istnieje!");
                    return false;
                }
            }

            if (GroupComboBox.SelectedItem == null)
            {
                MessageBox.Show("Pole 'grupa' musi zostać wypełnione");
                return false;
            }

            if (PasswordPasswordBox.Password == null || PasswordPasswordBox.Password == string.Empty)
            {
                MessageBox.Show("Pole 'hasło' musi zostać wypełnione");
                return false;
            }

            if (PasswordPasswordBox.Password != PasswordConfirmationPasswordBox.Password)
            {
                MessageBox.Show("Hasło wpisane w rubrykę 'Hasło' oraz 'Powtórz hasło' nie są identyczne!");
                return false;
            }

            return true;
        }
    }
}
