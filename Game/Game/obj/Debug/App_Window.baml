   M S B A M L   `   `   `  ����?  ;Game, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullclr-namespace:GameGame  5   	       Game.App_Window   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   $localclr-namespace:Game     5   	     � Title$  
App_Window��5   	   $	��450��6   $	��525��6)   .��5	      � .+�5
   
   �� -   5        $��5q�5
      .@�5      �� -   5        $��MainTabItem��5      ��5      �� 5       �� Orientation$ 
Horizontal=�6!   .+�5      �� $��Karta główna��6$   5      5      �� 5      -   5        $��GameTabItem��5      ��5      �� 5      $ 
Horizontal=�6!   .+�5      �� $	��Gry��6$   5      5#      �� 5$      -   5        $��RankingTabItem��5$      ��5&      �� 5'      $ 
Horizontal=�6!   .+�5(      �� $��Rankingi��6$   5*      .��5/      � $��10q�6   .+�50      &   System.Windows.Controls.DataGrid  -   5        $��
dbDataGrid��59      $��Normal"�50         SelectionMode$ Extended=�51       �� AlternationCount$ 2��52         GridLinesVisibility$	 All=�53         HorizontalGridLinesBrush �	#FF080101   VerticalGridLinesBrush �	#FF0A0101   CanUserAddRows .     
IsReadOnly . ���	#FF245E97	   AutoGenerateColumns	 .  5<      5=      5?      �� 5A      -   5        $��AccountTabItem��5A      ��5C      �� 5D      $ 
Horizontal=�6!   .+�5E      �� $��Konto��6$   5G      .��5K      � $��20q�6   
 � ColumnDefinitions
 5L      �� 5M      $
��Auto �6+   �� 5N      $��* �6+    � RowDefinitions 5P      �� 5Q      $
��Auto �6(   �� 5R      $
��Auto �6(   �� 5S      $
��Auto �6(   �� 5T      $
��Auto �6(   �� 5U      $
��Auto �6(   �� 5V      $
��Auto �6(   .+�5Y      �� $��Nick:��6    $��0��6-   $��0��6=   $��Center=�6J   �� 5Z      -   5        $��NickTextBlock��5Z       $��1��65   $��0��6E   $��5q�6R   �� 5\      $��Poziom:��6    $��0��6/   $��1��6?   $��Center=�6L   �� 5]      -   5        $��LevelTextBlock��5]       $��1��66   $��1��6F   $��5q�6S   �� 5_      $&�� Łączny czas spędzony w grach:��6    $��0��6E   $��2��6U   $��Center=�6b   �� 5`      -	   5        $��TimePlayedTextBlock��5`       $��1��6;   $��2��6K   $��5q�6X   �� 5b      $��Wiek:��6    $��0��6-   $��3��6=   $��Center=�6J   �� 5c      -
   5        $��AgeTextBlock��5c       $��1��64   $��3��6D   $��5q�6Q   �� 5e      $��Grupa:��6    $��0��6.   $��4��6>   $��Center=�6K   �� 5f      -   5        $��GroupTextBlock��5f       $��1��66   $��4��6F   $��5q�6S   �� 5h      $ 
Horizontal=�6!   $��2��6:   $��5��6N   $��Center=�6[   .+�5i      �� -   5        $��EditAccountInfoButton��5i   !   $��Edytuj dane��6>   $��30q�6T   $��80��6�   �� 5j      -   5        $��ChangePasswordButton��5j   !   $��Zmień hasło��6=   $��30q�6S   $��80��6�   5k      5l      5n      5p      5q      5r      