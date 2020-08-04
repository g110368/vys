using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using Npgsql;

namespace zilan2
{
    class Database
    {
        NpgsqlConnection connection = new NpgsqlConnection("Server=localhost; Port=5432; Database=zilan; User Id=postgres; Password=admin;");

        public void dataekle(string adsoyad, string email, string sifre, int favkitap, int favyazar, int istekno)
        {
            try { connection.Open(); } catch (Exception e) { }
            string sql = "INSERT INTO Kullanici (adSoyad,email,sifre,favKitapListeNo,favYazarListeNo,IstekListeNo) values ('" + adsoyad + "','" + email + "','" + sifre + "','" + favkitap + "','" + favyazar + "','" + istekno + "')";
            NpgsqlCommand cmd = new NpgsqlCommand(sql, connection);
            cmd.ExecuteNonQuery();
            connection.Close();
        }

        public string giris(int no)
        {
            // Connect to a PostgreSQL database
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5432; Database=zilan; User Id=postgres; Password=admin;");
            conn.Open();
            string sql = "SELECT sifre FROM kullanici WHERE kullanicino ='" + no + "'";
            // Define a query returning a single row result set
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);

            // Execute the query and obtain the value of the first column of the first row
            string sifre = command.ExecuteScalar().ToString();
            conn.Close();
            return sifre;

        }

        public void kitaplistele()
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5432; Database=zilan; User Id=postgres; Password=admin;");
            conn.Open();
            string sql = "SELECT kitapadi,sayfasayisi FROM kitap";
            // Define a query returning a single row result set
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);

            NpgsqlDataReader dr = command.ExecuteReader();
            int count = 1;
            while (dr.Read())
            {
                Console.WriteLine(count + "-){0}\t{1}\n", dr[0], dr[1]);
                count++;
            }
            conn.Close();

        }

        public void uyeligimiSil(int no)
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5432; Database=zilan; User Id=postgres; Password=admin;");
            try { conn.Open(); } catch (Exception e) { }

            string sql = "DELETE FROM kullanici WHERE kullanicino ='" + no + "'";
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);
            command.ExecuteNonQuery();
            conn.Close();
        }

        public void uyeligimiGuncelle(string adsoyad, string sifre, string email, int favkitap, int favyazar, int istekliste, int no)
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5432; Database=zilan; User Id=postgres; Password=admin;");
            try { conn.Open(); } catch (Exception e) { }

            string sql = "UPDATE \"kullanici\" SET \"adsoyad\"=\'" + adsoyad + "\', \"sifre\"=\'" + sifre + "\',\"email\"=\'" + email + "\',\"favkitaplisteno\"=\'" + favkitap + "\',\"favyazarlisteno\"=\'" + favyazar + "\' ,\"isteklisteno\"=\'" + istekliste + "\' WHERE \"kullanicino\"=\'" + no + "\'";
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);
            command.ExecuteNonQuery();
            conn.Close();
        }

        public int toplamkayit()
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5432; Database=zilan; User Id=postgres; Password=admin" +
                ";");
            try { conn.Open(); } catch (Exception e) { }

            string sql = "SELECT COUNT(*) FROM kullanici";
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);
            command.ExecuteNonQuery();
            return Convert.ToInt32(command.ExecuteScalar());
            conn.Close();

        }
    }
}
