<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="modelo.Genero" %>
<%
    Genero genero = (Genero) request.getAttribute("genero");
%>
<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Editar G&eacute;nero" />
</jsp:include>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header bg-warning text-dark">
                    <i class="bi bi-pencil me-2"></i>Editar G&eacute;nero
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/generos" method="post">
                        <input type="hidden" name="action" value="actualizar">
                        <input type="hidden" name="idGenero" value="<%= genero.getIdGenero() %>">

                        <div class="mb-3">
                            <label for="nombre" class="form-label"><i class="bi bi-tag me-1 text-muted"></i>Nombre del G&eacute;nero</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" value="<%= genero.getNombre() %>" required maxlength="50">
                        </div>

                        <hr class="my-4">
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/generos?action=list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-lg"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-warning px-4">
                                <i class="bi bi-save me-1"></i> Actualizar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
