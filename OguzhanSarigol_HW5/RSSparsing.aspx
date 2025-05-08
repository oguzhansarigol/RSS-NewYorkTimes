<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RSSparsing.aspx.cs" Inherits="OguzhanSarigol_HW5.RSSparsing" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gelen Haberler</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Repeater ID="rptNews" runat="server">
                <HeaderTemplate>
                    <h2>Gelen Haberler</h2>
                    <ul>
                </HeaderTemplate>
                <ItemTemplate>
                    <li>
                        <strong><%# Eval("Title") %></strong><br />
                        <em><%# Eval("PubDate") %></em><br />
                        <img src='<%# Eval("ImageUrl") %>' style="max-width:400px;" /><br />
                        <%# Eval("Description") %><br /><br />
                    </li>
                </ItemTemplate>
                <FooterTemplate>
                    </ul>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
