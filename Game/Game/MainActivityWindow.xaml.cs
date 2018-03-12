using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
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
    /// Logika interakcji dla klasy MainActivityWindow.xaml
    /// </summary>
    public partial class MainActivityWindow : Window
    {
        private int _userID;

        public MainActivityWindow(int userID)
        {
            InitializeComponent();
            _userID = userID;
        }

        private void EditInfoButton_Click(object sender, RoutedEventArgs e)
        {
            new ChangeAccountPropertiesWindow(_userID).ShowDialog();
            ShowUserInfoInAccountTab();
        }

        private void ChangePasswordButton_Click(object sender, RoutedEventArgs e)
        {
            new PasswordChangeWindow(_userID).ShowDialog();
        }

        private void ShowUserInfoInAccountTab()
        {
            using (var db = new DataBase())
            {
                var user = db.Players.FirstOrDefault(u => u.playerID == _userID);
                NickTextBlock.Text = user.nick;
                AgeTextBlock.Text = user.age.ToString();
                LevelTextBlock.Text = user.playerLevel.ToString();
                TimePlayedTextBlock.Text = (user.timePlayed / 60).ToString() + " godzin";
                GroupTextBlock.Text = user.PlayerGroups.name;
            }

        }

        //Zmiana zakładki
        private void TabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //Otwarcie zakładki "konto"
            if ((sender as TabControl).SelectedItem == AccountTabItem)
            {
                ShowUserInfoInAccountTab();
            }
        }
    }
}
