package com.mycompany.mavenproject1;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


/**
 *
 * @author noxwiz
 */
public class Memur extends Director {

    public Memur(String title, String ad, String soyad, int maas, String ust) {
        super(title, ad, soyad, maas, ust);
    }

    @Override
    public int maliyet() {
            return maas;
    }
}
