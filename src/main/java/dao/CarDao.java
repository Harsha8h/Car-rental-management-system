package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import model.Car;

public class CarDao {

    Connection connection = null;

    public boolean saveCar(Car car) throws ClassNotFoundException, SQLException {
        connection = ConnectionManager.getConnection();
        PreparedStatement st = connection.prepareStatement(
            "INSERT INTO cars VALUES(?,?,?,?,?,?,?,?,?,?,?)");
        st.setInt(1, car.getCarId());
        st.setString(2, car.getCarName());
        st.setString(3, car.getBrand());
        st.setString(4, car.getModel());
        st.setInt(5, car.getYear());
        st.setString(6, car.getColor());
        st.setDouble(7, car.getRentalPrice());
        st.setString(8, car.getFuelType());
        st.setInt(9, car.getSeatingCapacity());
        st.setString(10, car.getTransmissionType());
        st.setString(11, car.getAvailabilityStatus());

        int status = st.executeUpdate();
        return status == 1;
    }

    public void commit() throws SQLException {
        connection.commit();
        connection.close();
    }

    public void rollback() throws SQLException {
        connection.rollback();
        connection.close();
    }

    public boolean checkAdminLogin(String username, String password) throws ClassNotFoundException, SQLException {
        connection = ConnectionManager.getConnection();
        String query = "SELECT count(*) FROM admin WHERE username = ? AND password = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count == 1;
    }


    public boolean checkCustomerLogin(String email, String password) throws ClassNotFoundException, SQLException {
        connection = ConnectionManager.getConnection();
        String query = "SELECT password FROM customers WHERE email = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setString(1, email.toLowerCase().trim());
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            String storedPassword = rs.getString("password");
            
            if (storedPassword.length() == 64) {
                String inputHashedPassword = hashPassword(password);
                return storedPassword.equals(inputHashedPassword);
            } else {
                return storedPassword.equals(password);
            }
        }
        return false;
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return password; 
        }
    }

    public List<Car> viewAllCars() throws ClassNotFoundException, SQLException {
        connection = ConnectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement("SELECT * FROM cars");
        ResultSet rs = ps.executeQuery();
        List<Car> carList = new ArrayList<Car>();
        
        while (rs.next()) {
            Car car = new Car();
            car.setCarId(rs.getInt(1));
            car.setCarName(rs.getString(2));
            car.setBrand(rs.getString(3));
            car.setModel(rs.getString(4));
            car.setYear(rs.getInt(5));
            car.setColor(rs.getString(6));
            car.setRentalPrice(rs.getDouble(7));
            car.setFuelType(rs.getString(8));
            car.setSeatingCapacity(rs.getInt(9));
            car.setTransmissionType(rs.getString(10));
            car.setAvailabilityStatus(rs.getString(11));
            carList.add(car);
        }
        return carList;
    }

    public List<Car> viewAvailableCars() throws ClassNotFoundException, SQLException {
        connection = ConnectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(
            "SELECT * FROM cars WHERE availabilityStatus = 'Available'");
        ResultSet rs = ps.executeQuery();
        List<Car> carList = new ArrayList<Car>();
        
        while (rs.next()) {
            Car car = new Car();
            car.setCarId(rs.getInt(1));
            car.setCarName(rs.getString(2));
            car.setBrand(rs.getString(3));
            car.setModel(rs.getString(4));
            car.setYear(rs.getInt(5));
            car.setColor(rs.getString(6));
            car.setRentalPrice(rs.getDouble(7));
            car.setFuelType(rs.getString(8));
            car.setSeatingCapacity(rs.getInt(9));
            car.setTransmissionType(rs.getString(10));
            car.setAvailabilityStatus(rs.getString(11));
            carList.add(car);
        }
        return carList;
    }

    public boolean deleteById(int carId) throws SQLException, ClassNotFoundException {
        connection = ConnectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement("DELETE FROM cars WHERE carId = ?");
        ps.setInt(1, carId);
        int status = ps.executeUpdate();
        return status == 1;
    }

    public boolean updateCar(Car car) throws SQLException, ClassNotFoundException {
        connection = ConnectionManager.getConnection();
        PreparedStatement st = connection.prepareStatement(
            "UPDATE cars SET carName = ?, brand = ?, model = ?, year = ?, color = ?, " +
            "rentalPrice = ?, fuelType = ?, seatingCapacity = ?, transmissionType = ?, " +
            "availabilityStatus = ? WHERE carId = ?");
        
        st.setString(1, car.getCarName());
        st.setString(2, car.getBrand());
        st.setString(3, car.getModel());
        st.setInt(4, car.getYear());
        st.setString(5, car.getColor());
        st.setDouble(6, car.getRentalPrice());
        st.setString(7, car.getFuelType());
        st.setInt(8, car.getSeatingCapacity());
        st.setString(9, car.getTransmissionType());
        st.setString(10, car.getAvailabilityStatus());
        st.setInt(11, car.getCarId());

        int status = st.executeUpdate();
        return status == 1;
    }

    public Car searchCar(int carId) throws ClassNotFoundException, SQLException {
        connection = ConnectionManager.getConnection();
        PreparedStatement st = connection.prepareStatement("SELECT * FROM cars WHERE carId = ?");
        st.setInt(1, carId);
        ResultSet rs = st.executeQuery();
        Car car = new Car();
        
        if (rs.next()) {
            car.setCarId(rs.getInt(1));
            car.setCarName(rs.getString(2));
            car.setBrand(rs.getString(3));
            car.setModel(rs.getString(4));
            car.setYear(rs.getInt(5));
            car.setColor(rs.getString(6));
            car.setRentalPrice(rs.getDouble(7));
            car.setFuelType(rs.getString(8));
            car.setSeatingCapacity(rs.getInt(9));
            car.setTransmissionType(rs.getString(10));
            car.setAvailabilityStatus(rs.getString(11));
        }
        return car;
    }

    public boolean rentCar(int carId) throws SQLException, ClassNotFoundException {
        connection = ConnectionManager.getConnection();
        PreparedStatement st = connection.prepareStatement(
            "UPDATE cars SET availabilityStatus = 'Rented' WHERE carId = ?");
        st.setInt(1, carId);
        int status = st.executeUpdate();
        return status == 1;
    }

    public boolean returnCar(int carId) throws SQLException, ClassNotFoundException {
        connection = ConnectionManager.getConnection();
        PreparedStatement st = connection.prepareStatement(
            "UPDATE cars SET availabilityStatus = 'Available' WHERE carId = ?");
        st.setInt(1, carId);
        int status = st.executeUpdate();
        return status == 1;
    }

    public List<Car> searchCarsByBrand(String brand) throws ClassNotFoundException, SQLException {
        connection = ConnectionManager.getConnection();
        PreparedStatement ps = connection.prepareStatement(
            "SELECT * FROM cars WHERE brand LIKE ? AND availabilityStatus = 'Available'");
        ps.setString(1, "%" + brand + "%");
        ResultSet rs = ps.executeQuery();
        List<Car> carList = new ArrayList<Car>();
        
        while (rs.next()) {
            Car car = new Car();
            car.setCarId(rs.getInt(1));
            car.setCarName(rs.getString(2));
            car.setBrand(rs.getString(3));
            car.setModel(rs.getString(4));
            car.setYear(rs.getInt(5));
            car.setColor(rs.getString(6));
            car.setRentalPrice(rs.getDouble(7));
            car.setFuelType(rs.getString(8));
            car.setSeatingCapacity(rs.getInt(9));
            car.setTransmissionType(rs.getString(10));
            car.setAvailabilityStatus(rs.getString(11));
            carList.add(car);
        }
        return carList;
    }
}