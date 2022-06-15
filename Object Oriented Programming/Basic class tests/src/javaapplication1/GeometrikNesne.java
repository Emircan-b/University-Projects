/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;

/**
 *
 * @author emircanbahadir
 */
public abstract class GeometrikNesne implements Comparable<GeometrikNesne>{
    private String etiket;
    private Date tarih;

    public GeometrikNesne(){
        this.tarih = new Date();
    }
    public GeometrikNesne(String etiket, int month, int day, int year){
        this.etiket = etiket;
        this.tarih = new Date(month, day, year);
    }
    public abstract double alanHesapla();
    
    public GeometrikNesne(GeometrikNesne o){
        etiket = o.getEtiket();
        tarih = o.getTarih();
    }
    public String getEtiket() {
        return etiket;
    }

    public void setEtiket(String etiket) {
        this.etiket = etiket;
    }

    public Date getTarih() {
        return new Date(tarih);
    }

    public void setTarih(Date tarih) {
        this.tarih = tarih;
    }

    public abstract double cevreHesapla();
    
    @Override
    public abstract int compareTo(GeometrikNesne o);
    
    public String toString(){
        return "Etiket: " + this.etiket + " Tarih: " + this.tarih.getMonth()+"."+this.tarih.getDay()+"."+this.tarih.getYear();
}
}
