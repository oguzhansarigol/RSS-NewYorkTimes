using System;
using System.Collections;
using System.Net;
using System.Xml;
using System.ServiceModel.Syndication;
using System.Data.OleDb;
using System.Text.RegularExpressions; // Görsel çekmek için gerekli
using OguzhanSarigol_HW5.Classes;
using System.Linq;
using NLog;

namespace OguzhanSarigol_HW5
{
    public partial class RSSparsing : System.Web.UI.Page
    {
        private static readonly Logger logger = LogManager.GetCurrentClassLogger();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ParseRSS();

                if (Session["NewsList"] != null)
                {
                    rptNews.DataSource = Session["NewsList"];
                    rptNews.DataBind();
                }
            }
        }

        private void ParseRSS()
        {
            string rssUrl = "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml";
            ArrayList newsList = new ArrayList();
            int id = 1;

            try
            {
                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(rssUrl);

                XmlNamespaceManager nsmgr = new XmlNamespaceManager(xmlDoc.NameTable);
                nsmgr.AddNamespace("media", "http://search.yahoo.com/mrss/");

                XmlNodeList items = xmlDoc.SelectNodes("//item");
                foreach (XmlNode item in items)
                {
                    string title = item["title"]?.InnerText ?? "No Title";
                    string description = item["description"]?.InnerText ?? "No Description";
                    string category = item["category"]?.InnerText ?? "General";
                    string author = item["dc:creator"]?.InnerText ?? "Unknown";
                    string pubDate = item["pubDate"]?.InnerText ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm");

                    string imageUrl = "";
                    XmlNode mediaNode = item.SelectSingleNode("media:content", nsmgr);
                    if (mediaNode != null && mediaNode.Attributes["url"] != null)
                    {
                        imageUrl = mediaNode.Attributes["url"].Value;
                    }

                    if (string.IsNullOrEmpty(imageUrl))
                    {
                        imageUrl = "https://via.placeholder.com/600x400?text=No+Image";
                    }

                    News news = new News(id++, title, description, category, author, pubDate, imageUrl);
                    newsList.Add(news);

                    InsertNewsToDatabase(news); // zaten tekrar kontrolü içeriyor
                }

                Session["NewsList"] = newsList;
            }
            catch (Exception ex)
            {
                logger.Error(ex, "RSS çekilirken hata oluştu.");
                Response.Write("RSS çekilirken hata oluştu: " + ex.Message);
            }
        }



        private void InsertNewsToDatabase(News news)
        {
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Server.MapPath("~/App_Data/News.accdb");

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                conn.Open();

                // 1. Haber zaten var mı? Ve görseli eksik mi?
                string selectQuery = "SELECT ImageUrl FROM News WHERE Title = ?";
                using (OleDbCommand selectCmd = new OleDbCommand(selectQuery, conn))
                {
                    selectCmd.Parameters.AddWithValue("?", news.Title);
                    object result = selectCmd.ExecuteScalar();

                    if (result != null)
                    {
                        string existingImage = result.ToString();
                        // 📌 Eğer eski görsel boşsa veya placeholder'sa, güncelle
                        if (string.IsNullOrEmpty(existingImage) || existingImage.Contains("placeholder"))
                        {
                            string updateQuery = "UPDATE News SET ImageUrl = ? WHERE Title = ?";
                            using (OleDbCommand updateCmd = new OleDbCommand(updateQuery, conn))
                            {
                                updateCmd.Parameters.AddWithValue("?", news.ImageUrl);
                                updateCmd.Parameters.AddWithValue("?", news.Title);
                                updateCmd.ExecuteNonQuery();
                            }
                        }

                        return; // zaten veri var, sadece görsel güncellendi veya gerek yoktu
                    }
                }

                // 2. Yeni ekleme
                string insertQuery = "INSERT INTO News (Title, Description, Category, Author, PubDate, ImageUrl) VALUES (?, ?, ?, ?, ?, ?)";
                using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("?", news.Title);
                    cmd.Parameters.AddWithValue("?", news.Description);
                    cmd.Parameters.AddWithValue("?", news.Category);
                    cmd.Parameters.AddWithValue("?", news.Author);
                    cmd.Parameters.AddWithValue("?", news.PubDate);
                    cmd.Parameters.AddWithValue("?", news.ImageUrl);
                    cmd.ExecuteNonQuery();
                }
            }
        }


    }
}
