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
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace Game
{
    /// <summary>
    /// Interaction logic for App_Window.xaml
    /// </summary>
    public partial class App_Window : Window
    {
        private int dataGridDepth;                                  //Pozwala na przemieszczenie się pomiędzy tabelami
        private List<int> list;                   //Zapamiętuje poprzednie zmienne w zapytaniach(samych zapytań nie można zapisać ;/)
        private List<string> S_list;

        public App_Window()
        {
            InitializeComponent();
            using (var db = new GameContext())
            {
                if (db.Database.Exists())
                {
                    try
                    {
                        db.Games.Load();
                        dbGrid.ItemsSource = db.Games.Local;
                    }
                    catch (Exception e)
                    {
                        string a = e.Message;

                    }
                }
            }
            //Inicjalizacja list
            list = new List<int>();
            S_list = new List<string>();
            for (int i = 0; i < 3; i++)
            {
                list.Add(-1);
                S_list.Add(null);
            }
            dataGridDepth = 0;
            initialize_dataGrid_games();
        }

        private void initialize_dataGrid_levels()
        {
            dbGrid.Columns.Clear();
            DataGridTextColumn textColumn = new DataGridTextColumn();
            textColumn.Header = "Level name";
            textColumn.Binding = new Binding("Level_name");
            dbGrid.Columns.Add(textColumn);
            DataGridTextColumn textColumn2 = new DataGridTextColumn();
            textColumn2.Header = "Description";
            textColumn2.Binding = new Binding("Description");
            dbGrid.Columns.Add(textColumn2);
        }

        private void initialize_dataGrid_games()
        {
            dbGrid.Columns.Clear();
            DataGridTextColumn textColumn = new DataGridTextColumn();
            textColumn.Header = "Game Name";
            textColumn.Binding = new Binding("name");
            dbGrid.Columns.Add(textColumn);
            DataGridTextColumn textColumn2 = new DataGridTextColumn();
            textColumn2.Header = "Release Date";
            textColumn2.Binding = new Binding("releaseDate");
            dbGrid.Columns.Add(textColumn2);
        }

        private void initialize_dataGrid_scores()
        {
            dbGrid.Columns.Clear();
            DataGridTextColumn textColumn = new DataGridTextColumn();
            textColumn.Header = "Player name";
            textColumn.Binding = new Binding("Player_name");
            dbGrid.Columns.Add(textColumn);
            DataGridTextColumn textColumn2 = new DataGridTextColumn();
            textColumn2.Header = "Best result";
            textColumn2.Binding = new Binding("Best_result");
            dbGrid.Columns.Add(textColumn2);
        }

        private void initialize_dataGrid_aids()
        {
            dbGrid.Columns.Clear();
            DataGridTextColumn textColumn = new DataGridTextColumn();
            textColumn.Header = "Aids Name";
            textColumn.Binding = new Binding("name");
            dbGrid.Columns.Add(textColumn);
            DataGridTextColumn textColumn2 = new DataGridTextColumn();
            textColumn2.Header = "Description";
            textColumn2.Binding = new Binding("description");
            dbGrid.Columns.Add(textColumn2);
        }
        private void Load_Level_DataGrid(int game_ID, string Level_name)
        {
            using (var db = new GameContext())
            {
                if (db.Database.Exists())
                {
                    try
                    {
                        var tmp = (from db_L in db.Levels
                                   join db_S in db.scores on db_L.levelID equals db_S.gameID
                                   join db_P in db.Players on db_S.playerID equals db_P.playerID
                                   where db_L.gameID == game_ID && db_L.name == Level_name
                                   select new
                                   {
                                       Best_result = db_S.bestResult,
                                       Player_name = db_P.nick,
                                   });
                        if (list[1] == -1)
                        {

                            list[1] = game_ID;
                            S_list[1] = Level_name;
                        }
                        initialize_dataGrid_scores();
                        tmp.Load();
                        dbGrid.ItemsSource = tmp.ToList();
                    }
                    catch (Exception e2)
                    {
                        string abc = e2.Message;

                    }
                }
            }
        }

        private void Load_Game_DataGrid(int gameID)
        {
            using (var db = new GameContext())
            {
                if (db.Database.Exists())
                {
                    try
                    {
                        var tmp = (from db_L in db.Levels
                                   join db_G in db.Games on db_L.gameID equals db_G.gameID
                                   where db_G.gameID == gameID
                                   select new
                                   {
                                       Game_ID = db_L.gameID,
                                       Level_name = db_L.name,
                                       Description = db_L.description,
                                   });
                        if (list[0] == -1)
                        {

                            list[0] = gameID;
                        }
                        list[1] = -1;
                        initialize_dataGrid_levels();
                        tmp.Load();
                        dbGrid.ItemsSource = tmp.ToList();
                    }
                    catch (Exception e2)
                    {
                        string E_message = e2.Message;

                    }
                }
            }
        }

        private void dbGrid_KeyDown(object sender, KeyEventArgs e)
        {
            //Cofanie jak klikniedz delete
            if (e.Key == Key.Back && dbGrid.SelectedItem != null)
            {
                if (dataGridDepth != 0)
                {
                    dataGridDepth--;
                }
            }
            if (e.Key == Key.Enter && dbGrid.SelectedItem != null)
            {
                if (dataGridDepth != 3)
                {
                    dataGridDepth++;
                }
            }
            if (dbGrid.SelectedItem != null)
            {
                switch (dataGridDepth)
                {
                    case 0:
                        using (var db = new GameContext())
                        {
                            if (db.Database.Exists())
                            {
                                try
                                {
                                    initialize_dataGrid_games();
                                    db.Games.Load();
                                    dbGrid.ItemsSource = db.Games.Local;
                                    list[0] = -1;
                                }
                                catch (Exception e3)
                                {
                                    string e_Message = e3.Message;

                                }
                            }
                        }
                        break;
                    case 1:
                        if (list[0] != -1)
                        {
                            Load_Game_DataGrid(list[0]);
                        }
                        else
                        {
                            var selectedGame = (Games)dbGrid.SelectedItem;
                            Load_Game_DataGrid(selectedGame.gameID);
                        }
                        break;
                    case 2:
                        if (list[1] != -1)
                        {
                            Load_Level_DataGrid(list[1], S_list[1]);
                        }
                        else
                        {
                            var selectedItemScore = dbGrid.SelectedItem;
                            dynamic changedObj = Convert.ChangeType(selectedItemScore, dbGrid.SelectedItem.GetType());
                            int game_ID = changedObj.Game_ID;
                            string level_name = changedObj.Level_name;
                            Load_Level_DataGrid(game_ID, level_name);
                        }        
                        break;
                    case 3:
                        var selectedItemAids = dbGrid.SelectedItem;
                        dynamic changedObj_2 = Convert.ChangeType(selectedItemAids, dbGrid.SelectedItem.GetType());
                        string player_name = changedObj_2.Player_name;
                        using (var db = new GameContext())
                        {
                            if (db.Database.Exists())
                            {
                                try
                                {
                                    var tmp = (from db_P in db.Players
                                               where db_P.nick == player_name
                                               select new
                                               {
                                                   Aids = db_P.Aids
                                               });
                                    initialize_dataGrid_aids();
                                    tmp.Load();
                                    dbGrid.ItemsSource = tmp.ToList();
                                }
                                catch (Exception e2)
                                {
                                    string e_Message = e2.Message;

                                }
                            }
                            break;
                        }

                }

            }
        }
    }
}
