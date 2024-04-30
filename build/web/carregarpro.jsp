<%@page import="java.sql.*" %>
<%@page import="java.sql.DriverManager" %>
 
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Alteração de produto</title>
</head>
<body>
        <%
            //Recebe o codigo fo produto a alterar e armazena na variavel
            int c;
            c = Integer.parseInt(request.getParameter("codigo"));
 
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
 
            String url = "jdbc:mysql://localhost:3306/bancojsp";
            String user = "root";
            String password = "";
            conecta = DriverManager.getConnection(url, user, password);
 
            //bucar o produto pelo codigo digitado no form
            String sql = ("SELECT * FROM tbl_produto WHERE codigo=?");
            st = conecta.prepareStatement(sql);
            st.setInt(1, c);
 
            ResultSet resultado = st.executeQuery();
            //verifica se o produto de codigo informado
            //foi encontrado na tabela produto
 
            if (!resultado.next()) {
                //Se não econtrou o produto na tabela 
                //impresso o texto abaixo
                out.print("Este produto não foi localizado");
 
            } else {
                //Se encontrou o produto na tabela vamos carregar estes dados dentro do formulario
 
 
        %>
<form method="post" action="alterar_produto.jsp">
<p>
<label for="codigo">Codigo</label>
<input type="number" name="codigo" id="codigo" value="<%=resultado.getString("codigo")%>">
</p>
 
            <p>
<label for="nome">Nome do produto</label>
<input type="text" name="nome" id="nome" value="<%=resultado.getString("nome")%>">
</p>
 
            <p>
<label for="marca">Marca: </label>
<input type="text" name="marca" id="marca" value="<%=resultado.getString("marca")%>">
</p>
 
            <p>
<label for="preco">Preço: </label>
<input type="number" name="preco" id="preco" value="<%=resultado.getString("preco")%>">
</p>
 
            <p>
<input type="submit" value="Salvar alterações">
</p>
 
        </form>
<% }%>
</body>
</html>