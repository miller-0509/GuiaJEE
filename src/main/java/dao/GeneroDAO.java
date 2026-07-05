package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.Genero;
import util.ConexionBD;

public class GeneroDAO {

    public List<Genero> listar() throws SQLException {
        String sql = "SELECT idGenero, nombre FROM genero ORDER BY nombre";
        List<Genero> lista = new ArrayList<>();
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Genero g = new Genero();
                g.setIdGenero(rs.getInt("idGenero"));
                g.setNombre(rs.getString("nombre"));
                lista.add(g);
            }
        }
        return lista;
    }

    public Genero obtenerPorId(int idGenero) throws SQLException {
        String sql = "SELECT idGenero, nombre FROM genero WHERE idGenero = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGenero);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Genero g = new Genero();
                    g.setIdGenero(rs.getInt("idGenero"));
                    g.setNombre(rs.getString("nombre"));
                    return g;
                }
            }
        }
        return null;
    }

    public void insertar(Genero genero) throws SQLException {
        String sql = "INSERT INTO genero (nombre) VALUES (?)";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, genero.getNombre());
            stmt.executeUpdate();
        }
    }

    public void actualizar(Genero genero) throws SQLException {
        String sql = "UPDATE genero SET nombre = ? WHERE idGenero = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, genero.getNombre());
            stmt.setInt(2, genero.getIdGenero());
            stmt.executeUpdate();
        }
    }

    public void eliminar(int idGenero) throws SQLException {
        String sql = "DELETE FROM genero WHERE idGenero = ?";
        try (Connection conn = ConexionBD.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGenero);
            stmt.executeUpdate();
        }
    }
}
