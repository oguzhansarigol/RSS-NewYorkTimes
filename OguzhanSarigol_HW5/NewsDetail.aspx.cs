using System;
using System.Data.OleDb;

namespace OguzhanSarigol_HW5
{
    public partial class NewsDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["title"] != null)
            {
                string title = Request.QueryString["title"];
                LoadNewsDetail(title);
            }
        }

        private void LoadNewsDetail(string title)
        {
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("~/App_Data/News.accdb");

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();

                string query = "SELECT * FROM News WHERE Title = ?";
                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);

                    using (OleDbDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTitle.Text = reader["Title"].ToString();
                            lblCategory.Text = reader["Category"].ToString();
                            lblAuthor.Text = reader["Author"].ToString();
                            lblPubDate.Text = reader["PubDate"].ToString();
                            lblDescription.Text = reader["Description"].ToString();
                            imgNews.ImageUrl = reader["ImageUrl"].ToString();
                        }
                    }
                }
            }
        }
    }
}
