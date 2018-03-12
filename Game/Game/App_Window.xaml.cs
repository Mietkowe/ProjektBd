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
using System.Data.Entity;

namespace Game
{
    /// <summary>
    /// Interaction logic for App_Window.xaml
    /// </summary>
    public partial class App_Window : Window
    {
        public App_Window()
        {
            InitializeComponent();
            using (var db = new Model1())
            {
                if (db.Database.Exists())
                {
                    try
                    {
                       db.Games.Load();
                       dbGrid.ItemsSource = db.Games.Local;
                       var a = dbGrid.CurrentCell.ToString();
                    }
                    catch (Exception e)
                    {
                        string a = e.Message;

                    }
                }
            }
        }
    }


}
