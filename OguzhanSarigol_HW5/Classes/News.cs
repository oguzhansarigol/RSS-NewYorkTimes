﻿using System;

namespace OguzhanSarigol_HW5.Classes
{
    public class News
    {
        public int NewsID { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }
        public string Author { get; set; }
        public string PubDate { get; set; }
        public string ImageUrl { get; set; }

        public News(int newsID, string title, string description,
                    string category, string author, string pubDate, string imageUrl)
        {
            NewsID = newsID;
            Title = title;
            Description = description;
            Category = category;
            Author = author;
            PubDate = pubDate;
            ImageUrl = imageUrl;
        }
    }
}
