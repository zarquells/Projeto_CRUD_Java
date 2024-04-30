<%@page import="java.sql.*" %>
<%@page import="java.sql.DriverManager" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            int codigo;
            String nome;
            String marca;
            double preco;
            
            codigo = Integer.parseInt(request.getParameter("codigo"));
            nome = request.getParameter("nome");
            marca = request.getParameter("marca");
            preco = Double.parseDouble(request.getParameter("preco"));
            
            try{
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");

                String url = "jdbc:mysql://localhost:3306/bancojsp";
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url,user,password);

                //insere os dados na tabela produto do banco de dados aberto

                String sql = "INSERT INTO tbl_produto VALUES(?,?,?,?)";
                st = conecta.prepareStatement(sql);
                st.setInt(1,codigo);//indica que será inserido no primeiro campo 
                st.setString(2,nome);
                st.setString(3,marca);
                st.setDouble(4,preco);
                st.executeUpdate();
                out.print("<p><strong>Produto cadastrado com sucesso...</strong></p>");
            }catch(Exception x){
                String erro = x.getMessage();
                
                if (erro.contains("Duplicate entry")) {
                    out.print("<p style='color: red; font-size: 24px;'> Algum campo do produto já foi cadastrado no banco! </p>");
                }else{
                    out.print("<p style='color: red; font-size: 24px;'> Algo deu errado! Por favor, confira: " + erro +   "</p>");
                }
            }
        %>
    </body>
</html>
