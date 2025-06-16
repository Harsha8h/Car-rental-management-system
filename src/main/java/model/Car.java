package model;


public class Car {
    private int carId;
    private String carName;
    private String brand;
    private String model;
    private int year;
    private String color;
    private double rentalPrice;
    private String fuelType;
    private int seatingCapacity;
    private String transmissionType;
    private String availabilityStatus;

    public Car() {
    }

    public Car(int carId, String carName, String brand, String model, int year, 
               String color, double rentalPrice, String fuelType, int seatingCapacity, 
               String transmissionType, String availabilityStatus) {
        this.carId = carId;
        this.carName = carName;
        this.brand = brand;
        this.model = model;
        this.year = year;
        this.color = color;
        this.rentalPrice = rentalPrice;
        this.fuelType = fuelType;
        this.seatingCapacity = seatingCapacity;
        this.transmissionType = transmissionType;
        this.availabilityStatus = availabilityStatus;
    }

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getRentalPrice() {
        return rentalPrice;
    }

    public void setRentalPrice(double rentalPrice) {
        this.rentalPrice = rentalPrice;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public int getSeatingCapacity() {
        return seatingCapacity;
    }

    public void setSeatingCapacity(int seatingCapacity) {
        this.seatingCapacity = seatingCapacity;
    }

    public String getTransmissionType() {
        return transmissionType;
    }

    public void setTransmissionType(String transmissionType) {
        this.transmissionType = transmissionType;
    }

    public String getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    @Override
    public String toString() {
        return "Car{" +
                "carId=" + carId +
                ", carName='" + carName + '\'' +
                ", brand='" + brand + '\'' +
                ", model='" + model + '\'' +
                ", year=" + year +
                ", color='" + color + '\'' +
                ", rentalPrice=" + rentalPrice +
                ", fuelType='" + fuelType + '\'' +
                ", seatingCapacity=" + seatingCapacity +
                ", transmissionType='" + transmissionType + '\'' +
                ", availabilityStatus='" + availabilityStatus + '\'' +
                '}';
    }
}