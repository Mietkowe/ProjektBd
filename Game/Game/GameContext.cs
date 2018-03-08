namespace Game
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class GameContext : DbContext
    {
        public GameContext()
            : base("name=GameContext")
        {
        }

        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
        public virtual DbSet<Table_1> Table_1 { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Table_1>()
                .Property(e => e.Name)
                .IsFixedLength();
        }
    }
}
