<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsDetail.aspx.cs" Inherits="OguzhanSarigol_HW5.NewsDetail" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="icon" type="image/x-icon" href="~/favicon.ico" />

    <title>News Detail - NYT</title>
    <!-- Modern fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Source+Serif+Pro:wght@400;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
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
            max-width: 800px;
            margin: 60px auto;
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .title {
            font-family: 'Source Serif Pro', serif;
            font-size: 32px;
            font-weight: 700;
            line-height: 1.2;
            margin-bottom: 15px;
            color: #111;
        }

        .meta {
            font-size: 14px;
            color: #666;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
            display: flex;
            flex-wrap: wrap;
        }

        .meta span {
            margin-right: 15px;
            display: flex;
            align-items: center;
        }

        .meta span::after {
            content: "•";
            margin-left: 15px;
            opacity: 0.6;
        }

        .meta span:last-child::after {
            content: "";
        }

        .image-container {
            width: 100%;
            max-height: 450px;
            overflow: hidden;
            border-radius: 8px;
            margin: 25px 0;
        }

        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .description {
            font-family: 'Source Serif Pro', serif;
            font-size: 18px;
            line-height: 1.8;
            color: #333;
            margin-bottom: 30px;
        }

        .description p {
            margin-bottom: 20px;
        }

        .back-btn {
            display: inline-block;
            margin-top: 30px;
            font-size: 15px;
            color: #fff;
            background-color: #000;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: 500;
            transition: background-color 0.2s;
        }

        .back-btn:hover {
            background-color: #333;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                padding: 25px;
                margin: 40px 20px;
            }
            
            .title {
                font-size: 28px;
            }
            
            .description {
                font-size: 16px;
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

        <!-- NEWS DETAIL -->
        <div class="container">
            <div class="title">
                <asp:Label ID="lblTitle" runat="server" />
            </div>

            <div class="meta">
                <span><asp:Label ID="lblCategory" runat="server" /></span>
                <span><asp:Label ID="lblAuthor" runat="server" /></span>
                <span><asp:Label ID="lblPubDate" runat="server" /></span>
            </div>

            <div class="image-container">
                <asp:Image ID="imgNews" runat="server" />
            </div>

            <div class="description">
                <asp:Label ID="lblDescription" runat="server" />
            </div>

            <a class="back-btn" href="Home.aspx">&larr; Back to News</a>
        </div>

        <!-- FOOTER -->
        <div class="footer">
            <p>© 2025 The New York Times Company. All Rights Reserved.</p>
        </div>

    </form>
</body>
</html>