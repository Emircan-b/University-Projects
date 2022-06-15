/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.mavenproject1;

/**
 *
 * @author noxwiz
 */
public abstract class Employee {
    protected Employee[] subordinates = null;

    protected abstract int maliyet();

    protected String title;
    protected String ad;
    protected String soyad;
    protected int maas;
    protected String ust;

    public Employee(String title, String ad, String soyad, int maas, String ust) {
        this.title = title;
        this.ad = ad;
        this.soyad = soyad;
        this.maas = maas;
        this.ust = ust;
        
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAd() {
        return ad;
    }

    public String getSoyad() {
        return soyad;
    }

    public int getMaas() {
        return maas;
    }

    public String getUst() {
        return ust;
    }

    public void setAd(String ad) {
        this.ad = ad;
    }

    public void setSoyad(String soyad) {
        this.soyad = soyad;
    }

    public void setMaas(int maas) {
        this.maas = maas;
    }

    public void setUst(String ust) {
        this.ust = ust;
    }


}
