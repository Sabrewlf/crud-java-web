<%-- 
    Document   : usuarios
    Created on : 10/10/2020, 18:48:29
    Author     : marco
--%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="config.Conexao"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="./css/estilos.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

        <!---<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>---->
        <!----<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>---->

        <!------ Include the above in your HEAD tag ---------->

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de usuários</title>
    </head>
    <body>

        <%

            Statement st = null;
            ResultSet rs = null;

            String usuario = request.getParameter("txtusuario");
            String senha = request.getParameter("txtsenha");
            String nivel = request.getParameter("txtnivel");
            String nome = request.getParameter("txtnome");

            String user = "", pass = "";
        %>

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Lista de usuários</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#conteudoNavbarSuportado" aria-controls="conteudoNavbarSuportado" aria-expanded="false" aria-label="Alterna navegação">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="conteudoNavbarSuportado">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(página atual)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Link</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Dropdown
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Ação</a>
                            <a class="dropdown-item" href="#">Outra ação</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Algo mais aqui</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" href="#">Desativado</a>
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <span> 
                        <small>

                            <%
                                String nomeUsuario = (String) session.getAttribute("nomeUsuario");//casting com nomeUsuario
                                out.print(nomeUsuario);

                                if (nomeUsuario == null) {
                                    response.sendRedirect("index.jsp");

                                }
                            %>

                        </small>>
                    </span>

                    <a href="logout.jsp"><i class="fas fa-sign-out-alt ms-1"></i></a>

                </form>
            </div>
        </nav>
        <div class="container">

            <div class="row" mt-4 mb-4>
                <a type="button" class="btn-info btn-sm" href="usuarios.jsp?funcao=novo">Novo Usuário</a> 
                <form class="form-inline my-2 my-lg-0 direita" method="post">
                    <input class="form-control form-control-sm mr-sm-2" type="search" name="txtbuscar" placeholder="Pesquise aqui pelo nome..." aria-label="Buscar">
                    <button class="btn btn-outline-info btn-sm my-2 my-sm-0" type="submit" name="btn-buscar">Buscar</button>
                </form>
            </div>

            <table class="table table-sm table-striped">
                <thead>
                    <tr>
                        <th scope="col">Nome</th>
                        <th scope="col">Usuário</th>
                        <th scope="col">Senha</th>
                        <th scope="col">Nível de acesso</th>
                        <th scope="col">Ações</th>
                    </tr>
                </thead>
                <tbody>


                </tbody>

                <%
                    try {
                        st = new Conexao().conectar().createStatement();

                        if (request.getParameter("btn-buscar") != null) {

                            String busca = '%' + request.getParameter("txtbuscar") + '%';

                            rs = st.executeQuery("select * from usuarios where nome like '" + busca + "' order by nome asc");

                        } else {
                            rs = st.executeQuery("select * from usuarios order by nome asc");

                        }

                        while (rs.next()) {%>

                <tr>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getString(3)%></td>
                    <td><%=rs.getString(4)%></td>
                    <td><%=rs.getString(5)%></td>
                    <td>
                        <a href="usuarios.jsp?funcao=editar&id=<%=rs.getString(1)%>" class="text-info"><i class="far fa-edit"></i></a>
                        <a href="usuarios.jsp?funcao=excluir&id=<%=rs.getString(1)%>" class="text-danger"><i class="far fa-trash-alt"></i></a>

                    </td>

                </tr>

                <% }

                    } catch (Exception e) {

                        out.print(e);
                    }

                    if (usuario == null || senha == null) {
                        //out.println("Preencha os dados");

                    } else {

                        if (usuario.equals(user) && senha.equals(pass)) {
                            session.setAttribute("nomeUsuario", nomeUsuario);
                            response.sendRedirect("usuarios.jsp");
                            //out.println(usuario);

                        } else {

                            out.println("Dados Incorretos");
                        }
                    }

                %>
            </table>

        </div>

    </body>
</html>

<!-- Modal -->
<div class="modal fade" id="ModalInserir" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">

                <%                    String titulo = "";
                    String xid = "";
                    String xnome = "";
                    String xusuario = "";
                    String xsenha = "";
                    String xnivel = "";

                    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {

                        titulo = "Editar Usuário";
                        xid = request.getParameter("id");

                        try {

                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("select * from usuarios where id = '" + xid + "'");
                            while (rs.next()) {

                                xnome = rs.getString(2);
                                xusuario = rs.getString(3);
                                xsenha = rs.getString(4);
                                xnivel = rs.getString(5);
                            }

                        } catch (Exception e) {

                            out.print(e);
                        }

                    } else {

                        titulo = "Inserir Usuário";
                    }

                %>
                <h5 class="modal-title" id="exampleModalLabel"><%=titulo%></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <form id="cadastro-form" class="form" action="" method="post"><%//comentário   %>
                <div class="modal-body">


                    <div class="form-group">
                        <label for="txtnome" class="text-info">Nome</label><br>
                        <input value="<%=xnome%>" type="text" name="txtnome" id="txtnome" class="form-control" required>
                    </div> 
                    <div class="form-group">
                        <label for="txtusuario" class="text-info">Usuário</label><br>
                        <input value="<%=xusuario%>" type="text" name="txtusuario" id="txtnome" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="txtsenha" class="text-info">Senha</label><br>
                        <input value="<%=xsenha%>"type="text" name="txtsenha" id="password" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlSelect2">Nível de Acesso</label>

                        <select class="form-control" name="txtnivel" id="txtnivel">
                            
                            <option value="<%=xnivel%>"><%=xnivel%></option>

                            <%
                                if (!xnivel.equals ("Comum")) {
                                    out.print("<option>Comum</option>");
                                }

                                if (!xnivel.equals ("Administrador")) {
                                    out.print("<option>Administrador</option>");
                                }


                            %>
                           

                        </select>

                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                    <button type="submit" name="btn-salvar" class="btn btn-primary">Salvar Alterações</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%    if (request.getParameter("btn-salvar") != null) {

        try {

            //validação de duplicidade por email
            st = new Conexao().conectar().createStatement();
            rs = st.executeQuery("SELECT * FROM usuarios where usuario = '" + usuario + "'");

            while (rs.next()) {
                rs.getRow();

                if (rs.getRow() > 0) {

                    out.print("<script>alert('Usuário já cadastrado.')</script>");
                    return;
                }
            }

            //Inserir
            st.executeUpdate("insert into usuarios (nome, usuario, senha, nivel) values('" + nome + "', '" + usuario + "', '" + senha + "', '" + nivel + "')");
            response.sendRedirect("usuarios.jsp");

        } catch (Exception e) {

            out.print(e);
        }
    }

%>

<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("excluir")) {

        xid = request.getParameter("id");

        try {

            //Exclusão de usuário
            st = new Conexao().conectar().createStatement();
            st.executeUpdate("delete from usuarios where id = '" + xid + "'");

            response.sendRedirect("usuarios.jsp");

        } catch (Exception e) {

            out.print(e);
        }

    }


%>

<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {

        //chamada da modal
        out.print("<script>$('#ModalInserir').modal('show');</script>");

    }


%>

<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("novo")) {

        //chamada da modal
        out.print("<script>$('#ModalInserir').modal('show');</script>");

    }


%>


