<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, modelo.Genero" %>
<%
    List<Genero> generos = (List<Genero>) request.getAttribute("generos");
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        session.removeAttribute("mensaje");
    }
%>
<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Gesti&oacute;n de G&eacute;neros" />
</jsp:include>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                    <span><i class="bi bi-tags me-2"></i>Listado de G&eacute;neros</span>
                    <a href="${pageContext.request.contextPath}/generos?action=registrar" class="btn btn-light btn-sm">
                        <i class="bi bi-plus-circle"></i> Nuevo
                    </a>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th class="ps-3">#</th>
                                    <th>Nombre</th>
                                    <th class="pe-3 text-end">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (generos != null && !generos.isEmpty()) {
                                    int rowNum = 0;
                                    for (Genero g : generos) {
                                        rowNum++; %>
                                <tr style="animation: fadeIn 0.4s ease-out <%= rowNum * 0.08 %>s both;">
                                    <td class="ps-3"><%= g.getIdGenero() %></td>
                                    <td><strong><%= g.getNombre() %></strong></td>
                                    <td class="pe-3 text-end">
                                        <a href="${pageContext.request.contextPath}/generos?action=editar&id=<%= g.getIdGenero() %>" class="btn btn-outline-warning btn-sm" title="Editar">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/generos?action=eliminar&id=<%= g.getIdGenero() %>" class="btn btn-outline-danger btn-sm" title="Eliminar" onclick="return confirm('¿Eliminar este género?')">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                                <% } } else { %>
                                <tr>
                                    <td colspan="3" class="text-center py-5 empty-state">
                                        <i class="bi bi-tags" style="font-size: 3rem; color: #dee2e6;"></i>
                                        <p class="mt-3 text-muted mb-0">No hay g&eacute;neros registrados</p>
                                        <a href="${pageContext.request.contextPath}/generos?action=registrar" class="btn btn-primary btn-sm mt-2">
                                            <i class="bi bi-plus-circle"></i> Crear primer g&eacute;nero
                                        </a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer bg-transparent text-end">
                    <a href="${pageContext.request.contextPath}/peliculas?action=list" class="btn btn-outline-primary btn-sm">
                        <i class="bi bi-arrow-left"></i> Volver a Pel&iacute;culas
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<% if (mensaje != null) { %>
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div class="toast show align-items-center text-bg-success border-0" role="alert">
        <div class="d-flex">
            <div class="toast-body">
                <i class="bi bi-check-circle-fill me-2"></i><%= mensaje %>
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>
<script>
    setTimeout(function() {
        var toast = document.querySelector('.toast');
        if (toast) {
            var bsToast = new bootstrap.Toast(toast);
            bsToast.hide();
        }
    }, 4000);
</script>
<% } %>

<jsp:include page="footer.jsp" />
