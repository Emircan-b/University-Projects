/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.mavenproject1;

/**
 *
 * @author noxwiz
 */
public class Director extends Employee implements Container{

    public Director(String title, String ad, String soyad, int maas, String ust){
        super(title, ad, soyad, maas, ust);
        this.subordinates = new Employee[0];
    }

    public void ekle(Employee newItem){
        Employee[] temp = new Employee[subordinates.length+1];
        System.arraycopy(subordinates, 0, temp, 0, subordinates.length);
        temp[temp.length-1] = newItem;
        subordinates = temp;
    }
    
    @Override
    public Iterator getIterator() {
        return new DirectorIterate() ;
    }
    private class DirectorIterate implements Iterator{
        int i;
        @Override
        public boolean hasNext() {
            if (i<subordinates.length){
                return true;
            }
            return false;
        }
        @Override
        public Object next() {
            if(this.hasNext()){
                return subordinates[i++];
            }
            return null;
        }
    }

    @Override
    public int maliyet() {
        int total = 0;
        
        for (Iterator iter = this.getIterator(); iter.hasNext();) {
            total += ((Employee)iter.next()).maliyet();

        }
        total += maas;
        return total;

    }

    

}
