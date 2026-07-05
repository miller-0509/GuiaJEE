<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Registrar G&eacute;nero" />
</jsp:include>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <i class="bi bi-plus-circle me-2"></i>Registrar G&eacute;nero
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/generos" method="post">
                        <input type="hidden" name="action" value="insertar">

                        <div class="mb-3">
                            <label for="nombre" class="form-label"><i class="bi bi-tag me-1 text-muted"></i>Nombre del G&eacute;nero</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" required maxlength="50" placeholder="Ej: Acci&oacute;n, Comedia, Drama...">
                        </div>

                        <hr class="my-4">
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/generos?action=list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-lg"></i> Cancelar
                            </a>
                            <button type="submit" class="btn btn-success px-4">
                                <i class="bi bi-save me-1"></i> Guardar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
