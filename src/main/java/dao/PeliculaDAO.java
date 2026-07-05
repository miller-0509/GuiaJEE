package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import modelo.Pelicula;
import util.ConexionBD;

public class PeliculaDAO {

    private static final String COLUMNAS = "p.idPelicula, p.titulo, p.fechaEstreno, "
            + "p.duracion, p.clasificacion, p.precio, p.idGenero, g.nombre AS nombreGenero, "
            + "p.idDirector, d.nombre AS nombreDirector, d.apellido AS apellidoDirector";

    private static final String JOINS = " FROM pelicula p "
            + "INNER JOIN genero g ON p.idGenero = g.idGenero "
            + "INNER JOIN director d ON p.idDirector = d.idDirector";

    public List<Pelicula> listar() throws SQLException {
        String sql = "SELECT " + COLUMNAS + JOINS + " ORDER BY p.titulo";
        List<Pelicula> lista = new ArrayList<>();
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                lista.add(mapearPelicula(rs));
            }
        }
        return lista;
    }

    public Pelicula obtenerPorId(int idPelicula) throws SQLException {
        String sql = "SELECT " + COLUMNAS + JOINS + " WHERE p.idPelicula = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idPelicula);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearPelicula(rs);
                }
            }
        }
        return null;
    }

    public void insertar(Pelicula pelicula) throws SQLException {
        String sql = "INSERT INTO pelicula (titulo, fechaEstreno, duracion, "
                + "clasificacion, idDirector, precio, idGenero) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, pelicula.getTitulo());
            stmt.setDate(2, Date.valueOf(pelicula.getFechaEstreno()));
            stmt.setInt(3, pelicula.getDuracion());
            stmt.setString(4, pelicula.getClasificacion());
            stmt.setInt(5, pelicula.getIdDirector());
            stmt.setBigDecimal(6, pelicula.getPrecio());
            stmt.setInt(7, pelicula.getIdGenero());
            stmt.executeUpdate();
        }
    }

    public void actualizar(Pelicula pelicula) throws SQLException {
        String sql = "UPDATE pelicula SET titulo = ?, fechaEstreno = ?, "
                + "duracion = ?, clasificacion = ?, idDirector = ?, precio = ?, idGenero = ? "
                + "WHERE idPelicula = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, pelicula.getTitulo());
            stmt.setDate(2, Date.valueOf(pelicula.getFechaEstreno()));
            stmt.setInt(3, pelicula.getDuracion());
            stmt.setString(4, pelicula.getClasificacion());
            stmt.setInt(5, pelicula.getIdDirector());
            stmt.setBigDecimal(6, pelicula.getPrecio());
            stmt.setInt(7, pelicula.getIdGenero());
            stmt.setInt(8, pelicula.getIdPelicula());
            stmt.executeUpdate();
        }
    }

    public void eliminar(int idPelicula) throws SQLException {
        String sql = "DELETE FROM pelicula WHERE idPelicula = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idPelicula);
            stmt.executeUpdate();
        }
    }

    private Pelicula mapearPelicula(ResultSet rs) throws SQLException {
        Pelicula p = new Pelicula();
        p.setIdPelicula(rs.getInt("idPelicula"));
        p.setTitulo(rs.getString("titulo"));
        p.setFechaEstreno(rs.getDate("fechaEstreno").toLocalDate());
        p.setDuracion(rs.getInt("duracion"));
        p.setClasificacion(rs.getString("clasificacion"));
        p.setPrecio(rs.getBigDecimal("precio"));
        p.setIdGenero(rs.getInt("idGenero"));
        p.setNombreGenero(rs.getString("nombreGenero"));
        p.setIdDirector(rs.getInt("idDirector"));
        p.setNombreDirector(rs.getString("nombreDirector"));
        p.setApellidoDirector(rs.getString("apellidoDirector"));
        return p;
    }
}
