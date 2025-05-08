using System;
using System.Collections;
using System.Data.OleDb;
using System.Text;
using OguzhanSarigol_HW5.Classes;

namespace OguzhanSarigol_HW5
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNewsFromDatabase();
            }
        }

        private void LoadNewsFromDatabase()
        {
            ArrayList newsList = new ArrayList();

            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("~/App_Data/News.accdb");

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT * FROM News ORDER BY PubDate DESC";

                using (OleDbCommand cmd = new OleDbCommand(query, conn))
                using (OleDbDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        News news = new News(
                            0,
                            reader["Title"].ToString(),
                            reader["Description"].ToString(),
                            reader["Category"].ToString(),
                            reader["Author"].ToString(),
                            reader["PubDate"].ToString(),
                            reader["ImageUrl"].ToString()
                        );

                        newsList.Add(news);
                    }
                }
            }

            Session["allNews"] = newsList;
            PrintNews(newsList);
        }

        private void PrintNews(ArrayList newsList)
        {
            StringBuilder html = new StringBuilder();

            foreach (News news in newsList)
            {
                string img = !string.IsNullOrEmpty(news.ImageUrl)
                    ? news.ImageUrl
                    : "https://via.placeholder.com/400x200?text=No+Image";

                html.Append($"<div class='card' data-category='{news.Category}'>");

                // Image container
                html.Append($"<div class='card-img-container'>");
                html.Append($"<img src='{img}' onerror='this.src=\"https://via.placeholder.com/400x200?text=No+Image\"' />");
                html.Append("</div>");

                // Content container
                html.Append("<div class='card-content'>");
                html.Append($"<h3>{news.Title}</h3>");

                // Metadata with icons
                html.Append("<div class='meta'>");
                html.Append($"<div class='meta-item'><i class='fas fa-folder'></i> {news.Category}</div>");
                html.Append($"<div class='meta-item'><i class='fas fa-user'></i> {news.Author}</div>");
                html.Append($"<div class='meta-item'><i class='fas fa-calendar'></i> {news.PubDate}</div>");
                html.Append("</div>");

                // Description
                html.Append($"<p>{news.Description}</p>");
                html.Append("</div>");

                // Button container
                html.Append("<div class='btn-container'>");
                html.Append($"<a href='NewsDetail.aspx?title={Server.UrlEncode(news.Title)}' class='details-btn'>Read More</a>");
                html.Append("</div>");

                html.Append("</div>");
            }

            ltNewsList.Text = html.ToString();
        }
    }
}
