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
public class Silindir extends GeometrikNesne{
    double yaricap, uzunluk;
    public Silindir(){
        super();
        this.yaricap = this.uzunluk = 1.0;
    }
    public Silindir(String etiket, double yaricap, double uzunluk ,int month, int day, int year){
        super(etiket, month, day, year);
        this.yaricap = yaricap;
        this.uzunluk = uzunluk;
    }
    public Silindir(Silindir o){
        super(o);
        yaricap = o.getYaricap();
        uzunluk = o.getUzunluk();
    }
    public double getYaricap() {
        return yaricap;
    }

    public void setYaricap(double yaricap) {
        this.yaricap = yaricap;
    }

    public double getUzunluk() {
        return uzunluk;
    }

    public void setUzunluk(double uzunluk) {
        this.uzunluk = uzunluk;
    }
    @Override
    public double alanHesapla() {
        return (double)2*yaricap*PI*(yaricap+uzunluk);
    }

    @Override
    public double cevreHesapla() {
        return (double) (2*2*yaricap*PI)+(2*uzunluk);
    }
    
    public double hacimHesapla(){
        return (double)PI*yaricap*yaricap*uzunluk;
    }
    
    @Override
    public String toString() {
        return super.toString()+" Şekil: Silindir Yarıçap: " + this.yaricap +" Uzunluk: "+this.uzunluk +" Çevre: " + Math.round(cevreHesapla()*100.0)/100.0 + " Alan: " + Math.round(alanHesapla()*100.0)/100.0 +" Hacim: "+ Math.round(hacimHesapla()*100.0)/100.0;
    }

    @Override
    public int compareTo(GeometrikNesne o) {
        if(this.hacimHesapla()>((Silindir)o).hacimHesapla())
           return 1;
        else if (this.hacimHesapla()==((Silindir)o).hacimHesapla())
            return 0;
        else
            return -1;
        
    }
    
}
