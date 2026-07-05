package controlador;

import dao.DirectorDAO;
import dao.GeneroDAO;
import dao.PeliculaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import modelo.Pelicula;

@WebServlet("/peliculas")
public class PeliculaServlet extends HttpServlet {

    private PeliculaDAO peliculaDAO = new PeliculaDAO();
    private GeneroDAO generoDAO = new GeneroDAO();
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
                    mostrarFormularioRegistro(request, response);
                    break;
                case "editar":
                    mostrarFormularioEdicion(request, response);
                    break;
                case "eliminar":
                    eliminarPelicula(request, response);
                    break;
                default:
                    listarPeliculas(request, response);
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
                    insertarPelicula(request, response);
                    break;
                case "actualizar":
                    actualizarPelicula(request, response);
                    break;
                default:
                    response.sendRedirect("peliculas?action=list");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Error en la base de datos", e);
        }
    }

    private void listarPeliculas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        request.setAttribute("peliculas", peliculaDAO.listar());
        request.getRequestDispatcher("views/listarPeliculas.jsp").forward(request, response);
    }

    private void mostrarFormularioRegistro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        request.setAttribute("generos", generoDAO.listar());
        request.setAttribute("directores", directorDAO.listar());
        request.getRequestDispatcher("views/registrarPelicula.jsp").forward(request, response);
    }

    private void mostrarFormularioEdicion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Pelicula pelicula = peliculaDAO.obtenerPorId(id);
        if (pelicula == null) {
            response.sendRedirect("peliculas?action=list");
            return;
        }
        request.setAttribute("pelicula", pelicula);
        request.setAttribute("generos", generoDAO.listar());
        request.setAttribute("directores", directorDAO.listar());
        request.getRequestDispatcher("views/editarPelicula.jsp").forward(request, response);
    }

    private void insertarPelicula(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        Pelicula p = new Pelicula();
        p.setTitulo(request.getParameter("titulo"));
        p.setFechaEstreno(LocalDate.parse(request.getParameter("fechaEstreno")));
        p.setDuracion(Integer.parseInt(request.getParameter("duracion")));
        p.setClasificacion(request.getParameter("clasificacion"));
        p.setIdDirector(Integer.parseInt(request.getParameter("idDirector")));
        p.setPrecio(new BigDecimal(request.getParameter("precio")));
        p.setIdGenero(Integer.parseInt(request.getParameter("idGenero")));
        peliculaDAO.insertar(p);
        request.getSession().setAttribute("mensaje", "Película registrada correctamente");
        response.sendRedirect("peliculas?action=list");
    }

    private void actualizarPelicula(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        Pelicula p = new Pelicula();
        p.setIdPelicula(Integer.parseInt(request.getParameter("idPelicula")));
        p.setTitulo(request.getParameter("titulo"));
        p.setFechaEstreno(LocalDate.parse(request.getParameter("fechaEstreno")));
        p.setDuracion(Integer.parseInt(request.getParameter("duracion")));
        p.setClasificacion(request.getParameter("clasificacion"));
        p.setIdDirector(Integer.parseInt(request.getParameter("idDirector")));
        p.setPrecio(new BigDecimal(request.getParameter("precio")));
        p.setIdGenero(Integer.parseInt(request.getParameter("idGenero")));
        peliculaDAO.actualizar(p);
        request.getSession().setAttribute("mensaje", "Película actualizada correctamente");
        response.sendRedirect("peliculas?action=list");
    }

    private void eliminarPelicula(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        peliculaDAO.eliminar(id);
        request.getSession().setAttribute("mensaje", "Película eliminada correctamente");
        response.sendRedirect("peliculas?action=list");
    }
}
