package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Director;
import util.ConexionBD;

public class DirectorDAO {

    public List<Director> listar() throws SQLException {
        String sql = "SELECT idDirector, nombre, apellido, pais FROM director ORDER BY nombre, apellido";
        List<Director> lista = new ArrayList<>();
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Director d = new Director();
                d.setIdDirector(rs.getInt("idDirector"));
                d.setNombre(rs.getString("nombre"));
                d.setApellido(rs.getString("apellido"));
                d.setPais(rs.getString("pais"));
                lista.add(d);
            }
        }
        return lista;
    }

    public Director obtenerPorId(int idDirector) throws SQLException {
        String sql = "SELECT idDirector, nombre, apellido, pais FROM director WHERE idDirector = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idDirector);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Director d = new Director();
                    d.setIdDirector(rs.getInt("idDirector"));
                    d.setNombre(rs.getString("nombre"));
                    d.setApellido(rs.getString("apellido"));
                    d.setPais(rs.getString("pais"));
                    return d;
                }
            }
        }
        return null;
    }

    public void insertar(Director director) throws SQLException {
        String sql = "INSERT INTO director (nombre, apellido, pais) VALUES (?, ?, ?)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, director.getNombre());
            stmt.setString(2, director.getApellido());
            stmt.setString(3, director.getPais());
            stmt.executeUpdate();
        }
    }

    public void actualizar(Director director) throws SQLException {
        String sql = "UPDATE director SET nombre = ?, apellido = ?, pais = ? WHERE idDirector = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, director.getNombre());
            stmt.setString(2, director.getApellido());
            stmt.setString(3, director.getPais());
            stmt.setInt(4, director.getIdDirector());
            stmt.executeUpdate();
        }
    }

    public void eliminar(int idDirector) throws SQLException {
        String sql = "DELETE FROM director WHERE idDirector = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idDirector);
            stmt.executeUpdate();
        }
    }
}
