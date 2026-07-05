package controlador;

import dao.DirectorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import modelo.Director;

@WebServlet("/directores")
public class DirectorServlet extends HttpServlet {

    private DirectorDAO directorDAO = new DirectorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "registrar":
                    request.getRequestDispatcher("views/registrarDirector.jsp").forward(request, response);
                    break;
                case "editar":
                    mostrarFormularioEdicion(request, response);
                    break;
                case "eliminar":
                    eliminarDirector(request, response);
                    break;
                default:
                    listarDirectores(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en la base de datos", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "insertar":
                    insertarDirector(request, response);
                    break;
                case "actualizar":
                    actualizarDirector(request, response);
                    break;
                default:
                    response.sendRedirect("directores?action=list");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en la base de datos", e);
        }
    }

    private void listarDirectores(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        request.setAttribute("directores", directorDAO.listar());
        request.getRequestDispatcher("views/listarDirectores.jsp").forward(request, response);
    }

    private void mostrarFormularioEdicion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Director director = directorDAO.obtenerPorId(id);
        if (director == null) {
            response.sendRedirect("directores?action=list");
            return;
        }
        request.setAttribute("director", director);
        request.getRequestDispatcher("views/editarDirector.jsp").forward(request, response);
    }

    private void insertarDirector(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        Director d = new Director();
        d.setNombre(request.getParameter("nombre"));
        d.setApellido(request.getParameter("apellido"));
        d.setPais(request.getParameter("pais"));
        directorDAO.insertar(d);
        request.getSession().setAttribute("mensaje", "Director registrado correctamente");
        response.sendRedirect("directores?action=list");
    }

    private void actualizarDirector(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        Director d = new Director();
        d.setIdDirector(Integer.parseInt(request.getParameter("idDirector")));
        d.setNombre(request.getParameter("nombre"));
        d.setApellido(request.getParameter("apellido"));
        d.setPais(request.getParameter("pais"));
        directorDAO.actualizar(d);
        request.getSession().setAttribute("mensaje", "Director actualizado correctamente");
        response.sendRedirect("directores?action=list");
    }

    private void eliminarDirector(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        directorDAO.eliminar(id);
        request.getSession().setAttribute("mensaje", "Director eliminado correctamente");
        response.sendRedirect("directores?action=list");
    }
}
