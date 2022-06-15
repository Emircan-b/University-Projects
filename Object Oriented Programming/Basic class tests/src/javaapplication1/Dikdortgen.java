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
public class Dikdortgen extends GeometrikNesne
{
    private double en, boy;
    public Dikdortgen(){
        super();
        this.en = this.boy = 1.0;
    }

    public Dikdortgen(String etiket, double en, double boy, int month, int day, int year){
        super(etiket, month, day, year);
        this.en = en;
        this.boy = boy;
    }
    public Dikdortgen(Dikdortgen o){
        super(o);
        en = o.getEn();
        boy = o.getBoy();
    }
    public double getEn() {
        return en;
    }

    public void setEn(double en) {
        this.en = en;
    }

    public double getBoy() {
        return boy;
    }

    public void setBoy(double boy) {
        this.boy = boy;
    }
    
  
    @Override
    public double alanHesapla() {
        return en*boy;
    }

    @Override
    public double cevreHesapla() {
        return (double)2*en*boy;
    }

    @Override
    public int compareTo(GeometrikNesne o) {
        if(this.alanHesapla()>((Dikdortgen)o).alanHesapla())
           return 1;
        else if (this.alanHesapla()==((Dikdortgen)o).alanHesapla())
            return 0;
        else
            return -1;
    }
    
    @Override
    public String toString() {
        return super.toString()+" Şekil: Dikdörtgen En: " + this.en +" Boy: "+this.boy +" Çevre: " + Math.round(cevreHesapla()*100.0)/100.0 + " Alan: " + Math.round(alanHesapla()*100.0)/100.0;
    }
    
}
