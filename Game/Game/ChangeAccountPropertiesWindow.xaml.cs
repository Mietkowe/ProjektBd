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
    /// Logika interakcji dla klasy ChangeAccountProperties.xaml
    /// </summary>
    public partial class ChangeAccountPropertiesWindow : Window
    {
        private int _userID;

        public ChangeAccountPropertiesWindow(int userID)
        {
            InitializeComponent();
            _userID = userID;
            FillTextBoxesWithUserData();
        }

        private void AcceptButton_Click(object sender, RoutedEventArgs e)
        {
            using (var db = new DataBase())
            {
                var user = db.Players.FirstOrDefault(u => u.playerID == _userID);
                if (HashManager.isPasswordValid(user.saltText, user.passwordHash, PasswordPasswordBox.Password))
                {
                    user.nick = NickTextBox.Text;
                    try
                    {
                        user.age = Convert.ToByte(AgeTextBox.Text);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Wiek musi być liczbą!");
                        return;
                    }

                    user.groupID = db.PlayerGroups.FirstOrDefault(u => u.name == GroupComboBox.SelectedItem.ToString()).groupID;
                    db.SaveChanges();
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Hasło nie jest prawidłowe");
                }
            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void FillTextBoxesWithUserData()
        {
            using (var db = new DataBase())
            {
                var user = db.Players.FirstOrDefault(u => u.playerID == _userID);
                NickTextBox.Text = user.nick;
                AgeTextBox.Text = user.age.ToString();

                //Wypełnianie ComboBoxa opcjami
                var itemList = new List<string>();
                foreach (var group in db.PlayerGroups)
                {
                    itemList.Add(group.name);
                }
                GroupComboBox.ItemsSource = itemList;

                GroupComboBox.SelectedItem = itemList.FirstOrDefault(u => u == user.PlayerGroups.name);
            }
        }

        private void PasswordPasswordBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                AcceptButton_Click(null, null);
            }
        }
    }
}
