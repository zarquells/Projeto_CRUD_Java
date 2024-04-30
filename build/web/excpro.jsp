<%@page import="java.sql.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exclusão de Produtos</title>
    </head>
    <body>
        <%
            int cod = Integer.parseInt(request.getParameter("codigo"));
            //conecta o valor recebido para o correspondente nos registros
            try{
                Connection Conexao;
                PreparedStatement PrepararConexao;
                Class.forName("com.mysql.cj.jdbc.Driver");

                String url  = "jdbc:mysql://localhost:3306/bancojsp";
                String user = "root";
                String pwd  = "";

                Conexao = DriverManager.getConnection(url, user, pwd);

                String comandoSQL     =("DELETE FROM tbl_produto WHERE codigo=?");
                PrepararConexao       = Conexao.prepareStatement(comandoSQL);
                PrepararConexao.setInt(1, cod);
                
                int responseSQL = PrepararConexao.executeUpdate();
                
                if (responseSQL == 0){
                    out.print("Este produto não está cadastrado!");
                }else{
                    out.print("O produto de código " + cod + " foi excluído com sucesso!");
                }
                
            }catch(Exception e){
                String msgerro = e.getMessage();
                out.print("Ops, algo deu errado! Confira o erro: " + msgerro);
            }
        %>
    </body>
</html>
