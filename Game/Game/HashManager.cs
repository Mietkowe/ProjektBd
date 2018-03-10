using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Game
{
    class HashManager
    {
        public static string createSalt()
        {
            var rng = new System.Security.Cryptography.RNGCryptoServiceProvider();
            var buff = new byte[12];
            rng.GetBytes(buff);
            return Convert.ToBase64String(buff);
        }

        public static bool isPasswordValid(string salt, byte[] hash, string password)
        {
            if (salt == null)
            {
                salt = String.Empty;
            }
            if (generateHash(password, salt).SequenceEqual(hash))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static byte[] generateHash(string password, string salt)
        {
            byte[] bytes = Encoding.UTF8.GetBytes(password + salt);
            var hasher = new System.Security.Cryptography.SHA256Managed();
            byte[] hash = hasher.ComputeHash(bytes);
            return hash;
        }
    }
}
