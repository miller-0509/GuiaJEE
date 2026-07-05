<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, modelo.Pelicula" %>
<%
    List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
        session.removeAttribute("mensaje");
    }
%>
<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Gesti&oacute;n de Pel&iacute;culas" />
</jsp:include>

<div class="container">
    <div class="card">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <span><i class="bi bi-camera-reels me-2"></i>Listado de Pel&iacute;culas</span>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/peliculas?action=registrar" class="btn btn-light btn-sm">
                    <i class="bi bi-plus-circle"></i> Nueva
                </a>
                <a href="${pageContext.request.contextPath}/generos?action=list" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-tags"></i>
                </a>
                <a href="${pageContext.request.contextPath}/directores?action=list" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-people"></i>
                </a>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th class="ps-3">#</th>
                            <th>T&iacute;tulo</th>
                            <th>Director</th>
                            <th>Estreno</th>
                            <th>Duraci&oacute;n</th>
                            <th>Clasif.</th>
                            <th>Precio</th>
                            <th>G&eacute;nero</th>
                            <th class="pe-3 text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (peliculas != null && !peliculas.isEmpty()) {
                            int rowNum = 0;
                            for (Pelicula p : peliculas) {
                                rowNum++;
                                String badgeClass = "bg-secondary";
                                String clas = p.getClasificacion();
                                if (clas.equals("ATP")) {
                                    badgeClass = "bg-success";
                                } else if (clas.equals("+13")) {
                                    badgeClass = "bg-warning text-dark";
                                } else if (clas.equals("+16")) {
                                    badgeClass = "bg-primary";
                                } else if (clas.equals("+18")) {
                                    badgeClass = "bg-danger";
                                }
                        %>
                        <tr style="animation: fadeIn 0.4s ease-out <%= rowNum * 0.05 %>s both;">
                            <td class="ps-3"><%= p.getIdPelicula() %></td>
                            <td><strong><%= p.getTitulo() %></strong></td>
                            <td><i class="bi bi-person me-1 text-muted"></i><%= p.getNombreDirector() + " " + p.getApellidoDirector() %></td>
                            <td><i class="bi bi-calendar me-1 text-muted"></i><%= p.getFechaEstreno() %></td>
                            <td><%= p.getDuracion() %> <small class="text-muted">min</small></td>
                            <td><span class="badge <%= badgeClass %> badge-clasificacion"><%= p.getClasificacion() %></span></td>
                            <td><strong class="text-success">$<%= String.format("%,.2f", p.getPrecio()) %></strong></td>
                            <td><span class="badge bg-info text-dark"><%= p.getNombreGenero() %></span></td>
                            <td class="pe-3 text-end">
                                <a href="${pageContext.request.contextPath}/peliculas?action=editar&id=<%= p.getIdPelicula() %>" class="btn btn-outline-warning btn-sm" title="Editar">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/peliculas?action=eliminar&id=<%= p.getIdPelicula() %>" class="btn btn-outline-danger btn-sm" title="Eliminar" onclick="return confirm('¿Eliminar esta película?')">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="9" class="text-center py-5 empty-state">
                                <i class="bi bi-film" style="font-size: 3rem; color: #dee2e6;"></i>
                                <p class="mt-3 text-muted mb-0">No hay pel&iacute;culas registradas</p>
                                <a href="${pageContext.request.contextPath}/peliculas?action=registrar" class="btn btn-primary btn-sm mt-2">
                                    <i class="bi bi-plus-circle"></i> Crear primera pel&iacute;cula
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
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
