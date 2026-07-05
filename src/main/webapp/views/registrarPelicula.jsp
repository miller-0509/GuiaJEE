<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, modelo.Genero, modelo.Director" %>
<%
    List<Genero> generos = (List<Genero>) request.getAttribute("generos");
    List<Director> directores = (List<Director>) request.getAttribute("directores");
%>
<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Registrar Pel&iacute;cula" />
</jsp:include>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <i class="bi bi-plus-circle me-2"></i>Registrar Pel&iacute;cula
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/peliculas" method="post">
                        <input type="hidden" name="action" value="insertar">

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="titulo" class="form-label"><i class="bi bi-card-heading me-1 text-muted"></i>T&iacute;tulo</label>
                                <input type="text" class="form-control" id="titulo" name="titulo" required maxlength="100" placeholder="Ej: El Padrino">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="idDirector" class="form-label"><i class="bi bi-person me-1 text-muted"></i>Director</label>
                                <select class="form-select" id="idDirector" name="idDirector" required>
                                    <option value="">Seleccione un director...</option>
                                    <% if (directores != null) {
                                        for (Director d : directores) { %>
                                    <option value="<%= d.getIdDirector() %>"><%= d.getNombre() + " " + d.getApellido() %></option>
                                    <% } } %>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="fechaEstreno" class="form-label"><i class="bi bi-calendar me-1 text-muted"></i>Estreno</label>
                                <input type="date" class="form-control" id="fechaEstreno" name="fechaEstreno" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="duracion" class="form-label"><i class="bi bi-clock me-1 text-muted"></i>Duraci&oacute;n (min)</label>
                                <input type="number" class="form-control" id="duracion" name="duracion" required min="1" placeholder="Ej: 120">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="precio" class="form-label"><i class="bi bi-currency-dollar me-1 text-muted"></i>Precio</label>
                                <input type="number" step="0.01" class="form-control" id="precio" name="precio" required min="0" placeholder="Ej: 25000">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="clasificacion" class="form-label"><i class="bi bi-shield me-1 text-muted"></i>Clasificaci&oacute;n</label>
                                <select class="form-select" id="clasificacion" name="clasificacion" required>
                                    <option value="">Seleccione...</option>
                                    <option value="ATP">ATP &mdash; Todo p&uacute;blico</option>
                                    <option value="+13">+13 &mdash; Mayores de 13</option>
                                    <option value="+16">+16 &mdash; Mayores de 16</option>
                                    <option value="+18">+18 &mdash; Mayores de 18</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="idGenero" class="form-label"><i class="bi bi-tag me-1 text-muted"></i>G&eacute;nero</label>
                                <select class="form-select" id="idGenero" name="idGenero" required>
                                    <option value="">Seleccione un g&eacute;nero...</option>
                                    <% if (generos != null) {
                                        for (Genero g : generos) { %>
                                    <option value="<%= g.getIdGenero() %>"><%= g.getNombre() %></option>
                                    <% } } %>
                                </select>
                            </div>
                        </div>

                        <hr class="my-4">
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/peliculas?action=list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-lg"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success px-4">
                                <i class="bi bi-save me-1"></i> Guardar Pel&iacute;cula
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
