namespace Game
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class Model1 : DbContext
    {
        public Model1()
            : base("name=Model1")
        {
        }

        public virtual DbSet<Achievements> Achievements { get; set; }
        public virtual DbSet<Aids> Aids { get; set; }
        public virtual DbSet<Games> Games { get; set; }
        public virtual DbSet<gameTypes> gameTypes { get; set; }
        public virtual DbSet<Levels> Levels { get; set; }
        public virtual DbSet<owns> owns { get; set; }
        public virtual DbSet<PlayerGroups> PlayerGroups { get; set; }
        public virtual DbSet<Players> Players { get; set; }
        public virtual DbSet<Reviews> Reviews { get; set; }
        public virtual DbSet<scores> scores { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
        public virtual DbSet<unlockedAchievements> unlockedAchievements { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Achievements>()
                .Property(e => e.name)
                .IsUnicode(false);

            modelBuilder.Entity<Achievements>()
                .Property(e => e.description)
                .IsUnicode(false);

            modelBuilder.Entity<Achievements>()
                .HasMany(e => e.unlockedAchievements)
                .WithRequired(e => e.Achievements)
                .HasForeignKey(e => new { e.achievementID, e.gameID })
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Aids>()
                .Property(e => e.name)
                .IsUnicode(false);

            modelBuilder.Entity<Aids>()
                .Property(e => e.description)
                .IsUnicode(false);

            modelBuilder.Entity<Games>()
                .Property(e => e.name)
                .IsUnicode(false);

            modelBuilder.Entity<Games>()
                .HasMany(e => e.Achievements)
                .WithRequired(e => e.Games)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Games>()
                .HasMany(e => e.Levels)
                .WithRequired(e => e.Games)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Games>()
                .HasMany(e => e.owns)
                .WithRequired(e => e.Games)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Games>()
                .HasMany(e => e.Reviews)
                .WithRequired(e => e.Games)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Games>()
                .HasMany(e => e.gameTypes)
                .WithMany(e => e.Games)
                .Map(m => m.ToTable("sharesTypes").MapLeftKey("gameID").MapRightKey("typeID"));

            modelBuilder.Entity<gameTypes>()
                .Property(e => e.name)
                .IsUnicode(false);

            modelBuilder.Entity<Levels>()
                .Property(e => e.name)
                .IsUnicode(false);

            modelBuilder.Entity<Levels>()
                .Property(e => e.description)
                .IsUnicode(false);

            modelBuilder.Entity<Levels>()
                .HasMany(e => e.scores)
                .WithRequired(e => e.Levels)
                .HasForeignKey(e => new { e.levelID, e.gameID })
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<owns>()
                .Property(e => e.personalPreferences)
                .IsUnicode(false);

            modelBuilder.Entity<PlayerGroups>()
                .Property(e => e.name)
                .IsUnicode(false);

            modelBuilder.Entity<PlayerGroups>()
                .HasMany(e => e.Players)
                .WithRequired(e => e.PlayerGroups)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Players>()
                .Property(e => e.nick)
                .IsUnicode(false);

            modelBuilder.Entity<Players>()
                .HasMany(e => e.owns)
                .WithRequired(e => e.Players)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Players>()
                .HasMany(e => e.Reviews)
                .WithRequired(e => e.Players)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Players>()
                .HasMany(e => e.scores)
                .WithRequired(e => e.Players)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Players>()
                .HasMany(e => e.unlockedAchievements)
                .WithRequired(e => e.Players)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Players>()
                .HasMany(e => e.Aids)
                .WithMany(e => e.Players)
                .Map(m => m.ToTable("uses").MapLeftKey("playerID").MapRightKey("aidID"));

            modelBuilder.Entity<Reviews>()
                .Property(e => e.comment)
                .IsUnicode(false);
        }
    }
}
