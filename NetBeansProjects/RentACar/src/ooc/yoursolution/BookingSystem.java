/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ooc.yoursolution;

import java.io.BufferedReader;
import java.io.IOException;

/**
 *
 * @author alessandracaballero
 */
public class BookingSystem implements BookingSystemInterface{

    //implementation of all abstract methods
    @Override
    public RentACarInterface setupRentACar(BufferedReader in) throws IOException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
   
        String title = in.readLine();
        String content = "";
        
        CarInterface car = new car();
    
        for(int n = 1; n <= 5; n++){
            content += in.readLine();
        }
        
        return null;
    }
}