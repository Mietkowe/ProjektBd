namespace Game
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class owns
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int gameID { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int playerID { get; set; }

        [Column(TypeName = "date")]
        public DateTime purchaseDate { get; set; }

        [Column(TypeName = "date")]
        public DateTime lastPlayed { get; set; }

        public int timePlayed { get; set; }

        [Column(TypeName = "text")]
        [Required]
        public string personalPreferences { get; set; }

        public virtual Games Games { get; set; }

        public virtual Players Players { get; set; }
    }
}
