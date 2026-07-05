<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Registrar Director" />
</jsp:include>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <i class="bi bi-plus-circle me-2"></i>Registrar Director
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/directores" method="post">
                        <input type="hidden" name="action" value="insertar">

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="nombre" class="form-label"><i class="bi bi-person me-1 text-muted"></i>Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required maxlength="50" placeholder="Ej: Francis">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="apellido" class="form-label"><i class="bi bi-person me-1 text-muted"></i>Apellido</label>
                                <input type="text" class="form-control" id="apellido" name="apellido" required maxlength="50" placeholder="Ej: Ford Coppola">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="pais" class="form-label"><i class="bi bi-globe me-1 text-muted"></i>Pa&iacute;s</label>
                            <input type="text" class="form-control" id="pais" name="pais" required maxlength="50" placeholder="Ej: Estados Unidos">
                        </div>

                        <hr class="my-4">
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/directores?action=list" class="btn btn-outline-secondary">
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
