package controlador;

import dao.GeneroDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import modelo.Genero;

@WebServlet("/generos")
public class GeneroServlet extends HttpServlet {

    private GeneroDAO generoDAO = new GeneroDAO();

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
                    request.getRequestDispatcher("views/registrarGenero.jsp").forward(request, response);
                    break;
                case "editar":
                    mostrarFormularioEdicion(request, response);
                    break;
                case "eliminar":
                    eliminarGenero(request, response);
                    break;
                default:
                    listarGeneros(request, response);
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
                    insertarGenero(request, response);
                    break;
                case "actualizar":
                    actualizarGenero(request, response);
                    break;
                default:
                    response.sendRedirect("generos?action=list");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en la base de datos", e);
        }
    }

    private void listarGeneros(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        request.setAttribute("generos", generoDAO.listar());
        request.getRequestDispatcher("views/listarGeneros.jsp").forward(request, response);
    }

    private void mostrarFormularioEdicion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Genero genero = generoDAO.obtenerPorId(id);
        if (genero == null) {
            response.sendRedirect("generos?action=list");
            return;
        }
        request.setAttribute("genero", genero);
        request.getRequestDispatcher("views/editarGenero.jsp").forward(request, response);
    }

    private void insertarGenero(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        Genero g = new Genero();
        g.setNombre(request.getParameter("nombre"));
        generoDAO.insertar(g);
        request.getSession().setAttribute("mensaje", "Género registrado correctamente");
        response.sendRedirect("generos?action=list");
    }

    private void actualizarGenero(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        Genero g = new Genero();
        g.setIdGenero(Integer.parseInt(request.getParameter("idGenero")));
        g.setNombre(request.getParameter("nombre"));
        generoDAO.actualizar(g);
        request.getSession().setAttribute("mensaje", "Género actualizado correctamente");
        response.sendRedirect("generos?action=list");
    }

    private void eliminarGenero(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        generoDAO.eliminar(id);
        request.getSession().setAttribute("mensaje", "Género eliminado correctamente");
        response.sendRedirect("generos?action=list");
    }


}
