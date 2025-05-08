<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="OguzhanSarigol_HW5.Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="shortcut icon" type="image/x-icon" href="~/favicon.ico" />

    <title>New York Times - News</title>
    <!-- Modern fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Source+Serif+Pro:wght@400;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f8f8f8;
            color: #222;
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
        }

        /* NAVBAR */
        .navbar {
            background-color: #000;
            color: white;
            padding: 20px 5%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar img {
            height: 42px;
            transition: transform 0.2s;
        }
        
        .navbar img:hover {
            transform: scale(1.05);
        }

        .container {
            max-width: 1200px;
            margin: 60px auto 80px;
            padding: 0 20px;
        }

        .page-title {
            font-family: 'Source Serif Pro', serif;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
            color: #000;
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 15px;
        }

        /* Filter section */
        .filter-container {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .filter-btn {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 20px;
            padding: 8px 16px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .filter-btn:hover {
            background-color: #f0f0f0;
        }

        .filter-btn.active {
            background-color: #000;
            color: #fff;
            border-color: #000;
        }

        .news-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }

        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
            height: 100%;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .card-img-container {
            width: 100%;
            height: 300px;
            overflow: hidden;
        }

        .card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .card:hover img {
            transform: scale(1.05);
        }

        .card-content {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .card h3 {
            font-family: 'Source Serif Pro', serif;
            font-size: 20px;
            margin-bottom: 12px;
            color: #111;
            line-height: 1.3;
        }

        .meta {
            font-size: 13px;
            color: #666;
            margin-bottom: 15px;
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .meta-item i {
            color: #777;
        }

        .card p {
            font-size: 14px;
            color: #444;
            flex-grow: 1;
            margin-bottom: 10px;
        }

        .details-btn {
            display: inline-block;
            font-size: 14px;
            color: #fff;
            background-color: #000;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            letter-spacing: 0.5px;
            margin-top: 0px;
        }

        .details-btn:hover {
            background-color: #333;
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transform: translateY(-2px);
        }

        .btn-container {
            margin-top: auto;
            padding: 0 20px 20px 20px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .news-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }

            .container {
                margin: 40px auto;
            }
        }

        @media (max-width: 480px) {
            .news-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Footer */
        .footer {
            background-color: #f1f1f1;
            text-align: center;
            padding: 20px;
            margin-top: 40px;
            font-size: 12px;
            color: #666;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- NAVBAR -->
        <div class="navbar">
            <img src="nyt-logo.png" alt="NYT Logo" />
        </div>

        <!-- NEWS CONTENT -->
        <div class="container">
            <h1 class="page-title">Latest News</h1>
            
            <!-- Category filter buttons -->
            <div class="filter-container">
                <button type="button" class="filter-btn active" data-category="all">All Categories</button>
                <button type="button" class="filter-btn" data-category="Politics">Politics</button>
                <button type="button" class="filter-btn" data-category="Technology">Technology</button>
                <button type="button" class="filter-btn" data-category="Sports">Sports</button>
                <button type="button" class="filter-btn" data-category="Business">Business</button>
                <button type="button" class="filter-btn" data-category="Health">Health</button>
            </div>
            
            <div class="news-grid">
                <asp:Literal ID="ltNewsList" runat="server" />
            </div>
        </div>

        <!-- FOOTER -->
        <div class="footer">
            <p>© 2025 The New York Times Company. All Rights Reserved.</p>
        </div>

    </form>

    <script>
        // Category filtering functionality
        document.addEventListener('DOMContentLoaded', function() {
            const filterButtons = document.querySelectorAll('.filter-btn');
            const newsCards = document.querySelectorAll('.card');
            
            // Add click event to each filter button
            filterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // Remove active class from all buttons
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    
                    // Add active class to clicked button
                    this.classList.add('active');
                    
                    const category = this.getAttribute('data-category');
                    
                    // Filter the news cards
                    newsCards.forEach(card => {
                        if (category === 'all' || card.getAttribute('data-category') === category) {
                            card.style.display = 'flex';
                        } else {
                            card.style.display = 'none';
                        }
                    });
                });
            });
        });
    </script>
</body>
</html>