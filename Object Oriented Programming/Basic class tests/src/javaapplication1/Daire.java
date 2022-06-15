/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;

import static java.lang.Math.*;

/**
 *
 * @author emircanbahadir
 */
public class Daire extends GeometrikNesne {

    private double yaricap;

    public Daire() {
        super();
        this.yaricap = 1.0;
    }
    public Daire(Daire o){
        super(o);
        yaricap = o.getYaricap();
        
    }
    public double getYaricap() {
        return yaricap;
    }

    public void setYaricap(double yaricap) {
        this.yaricap = yaricap;
    }

    public Daire(String etiket, double yaricap, int month, int day, int year) {
        super(etiket, month, day, year);
        this.yaricap = yaricap;
    }

    @Override
    public String toString() {
        return super.toString()+" Şekil: Daire Yarıçap: " + this.yaricap +" Çevre: " + Math.round(cevreHesapla()*100.0)/100.0 + " Alan: " + Math.round(alanHesapla()*100.0)/100.0;
    }

    @Override
    public double alanHesapla() {
        return (double) PI * Math.pow(yaricap, 2);
    }

    @Override
    public double cevreHesapla() {
        return (double) 2 * PI * yaricap;
    }

    @Override
    public int compareTo(GeometrikNesne o) {
        if(this.yaricap>((Daire)o).getYaricap())
           return 1;
        else if (this.yaricap==((Daire)o).getYaricap())
            return 0;
        else
            return -1;
    }

}
