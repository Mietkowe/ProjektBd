namespace Game
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Players
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Players()
        {
            owns = new HashSet<owns>();
            Reviews = new HashSet<Reviews>();
            scores = new HashSet<scores>();
            unlockedAchievements = new HashSet<unlockedAchievements>();
            Aids = new HashSet<Aids>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int playerID { get; set; }

        [Required]
        [StringLength(30)]
        public string nick { get; set; }

        public byte? age { get; set; }

        public int groupID { get; set; }

        public int timePlayed { get; set; }

        public int playerLevel { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<owns> owns { get; set; }

        public virtual PlayerGroups PlayerGroups { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Reviews> Reviews { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<scores> scores { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<unlockedAchievements> unlockedAchievements { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Aids> Aids { get; set; }
    }
}
