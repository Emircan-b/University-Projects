/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

/**
 *
 * @author emircanbahadir
 */
public class Main {
public static void main(String[] args) throws FileNotFoundException{
    

        File input = new File("input.txt");
        Scanner reader = new Scanner(input);
        int counter = 0;

        while (reader.hasNextLine()){
            reader.nextLine();
            counter++;
        }
        reader.close();

        GeometrikNesne[] objects = new GeometrikNesne[counter+3];
        counter = 0;
        reader = new Scanner(input);

        while (reader.hasNextLine()){
            String objectData = reader.nextLine();
            String[] objectDataArray = objectData.split(" ");

            switch(objectDataArray[0]){
                case "daire":
                    for(int i = objectDataArray.length-4; i>-1;i--){
                        if(objectDataArray[i].equalsIgnoreCase("date")){
                            int month = Integer.parseInt(objectDataArray[i+1]);
                            int day = Integer.parseInt(objectDataArray[i+2]);
                            int year = Integer.parseInt(objectDataArray[i+3]);
                            GeometrikNesne temp = new Daire(objectDataArray[1],Double.parseDouble(objectDataArray[2]),month,day,year);
                            objects[counter++] = temp;
                            break;
                        }
                    }
                    break;

                case "dikdortgen":
                    for(int i = objectDataArray.length-4; i>-1;i--){
                        if(objectDataArray[i].equalsIgnoreCase("date")){
                            int month = Integer.parseInt(objectDataArray[i+1]);
                            int day = Integer.parseInt(objectDataArray[i+2]);
                            int year = Integer.parseInt(objectDataArray[i+3]);
                            GeometrikNesne temp = new Dikdortgen(objectDataArray[1],Double.parseDouble(objectDataArray[2]),Double.parseDouble(objectDataArray[3]),month,day,year);
                            objects[counter++] = temp;
                            break;
                        }
                    }
                    break;

                case "silindir":
                    for(int i = objectDataArray.length-4; i>-1;i--){
                        if(objectDataArray[i].equalsIgnoreCase("date")){
                            int month = Integer.parseInt(objectDataArray[i+1]);
                            int day = Integer.parseInt(objectDataArray[i+2]);
                            int year = Integer.parseInt(objectDataArray[i+3]);
                            GeometrikNesne temp = new Silindir(objectDataArray[1],Double.parseDouble(objectDataArray[2]),Double.parseDouble(objectDataArray[3]),month,day,year);
                            objects[counter++] = temp;
                            break;
                        }
                    }
                    break;
                    
            }
            
        }
        reader.close();

        for(int i = 0; i<objects.length-3;i++){
                if(objects[i].getEtiket().equalsIgnoreCase("dai3")){
                    GeometrikNesne daire = new Daire((Daire)objects[i]);
                    objects[counter++] = daire;
                }
                else if (objects[i].getEtiket().equalsIgnoreCase("dik2")){
                    GeometrikNesne dikdortgen = new Dikdortgen((Dikdortgen)objects[i]);
                    objects[counter++] = dikdortgen;
                }
                else if (objects[i].getEtiket().equalsIgnoreCase("sil2")){
                    GeometrikNesne silindir = new Silindir((Silindir)objects[i]);
                    objects[counter++] = silindir;
                }
            }

            for(int i = 0; i<objects.length; i++)
                polymorphicYazdir(objects[i]);
            
            int ikinciDaire, ucuncuDaire, dorduncuDaire, birinciDikdortgen,ikinciDikdortgen,ucuncuDikdortgen,birinciSilindir,ikinciSilindir,ucuncuSilindir;
            int daireCounter, dikdortgenCounter, silindirCounter;
            daireCounter = dikdortgenCounter = silindirCounter = 0;
            ikinciDaire = ucuncuDaire = dorduncuDaire = birinciDikdortgen = ikinciDikdortgen = ucuncuDikdortgen = birinciSilindir = ikinciSilindir = ucuncuSilindir = 0;

            for(int i = 0; i<objects.length;i++){

                if(objects[i] instanceof Daire){
                    daireCounter++;
                    switch(daireCounter){
                        case 2:
                            ikinciDaire = i;
                            break;
                        case 3:
                            ucuncuDaire = i;
                            break;
                        case 4:
                            dorduncuDaire = i;
                            break;
                    }
                }
                else if(objects[i] instanceof Dikdortgen){
                    dikdortgenCounter++;
                    switch(dikdortgenCounter){
                        case 1:
                            birinciDikdortgen = i;
                            break;
                        case 2:
                            ikinciDikdortgen = i;
                            break;
                        case 3:
                            ucuncuDikdortgen = i;
                            break;
                    }
                }
                else if(objects[i] instanceof Silindir){
                    silindirCounter++;
                    switch(silindirCounter){
                        case 1:
                            birinciSilindir = i;
                            break;
                        case 2:
                            ikinciSilindir = i;
                            break;
                        case 3:
                            ucuncuSilindir = i;
                            break;
                    }
                }
            }

            System.out.println("");
            karsilastir(objects[ikinciDaire],objects[ucuncuDaire]);
            karsilastir(objects[ucuncuDaire],objects[dorduncuDaire]);
            karsilastir(objects[birinciDikdortgen],objects[ikinciDikdortgen]);
            karsilastir(objects[ikinciDikdortgen],objects[ucuncuDikdortgen]);
            karsilastir(objects[birinciSilindir],objects[ikinciSilindir]);
            karsilastir(objects[ikinciSilindir],objects[ucuncuSilindir]);
            
            double[] values = new double[9];
            double minCevre, maxCevre, ortCevre, minAlan, maxAlan, ortAlan, minHacim, maxHacim, ortHacim;
            minCevre = minAlan = minHacim = Double.MAX_VALUE;
            maxCevre = maxAlan = maxHacim = Double.MIN_VALUE;
            ortCevre = ortAlan = ortHacim = 0;
            silindirCounter = 0;

            for(int i = 0;i<objects.length;i++){

                if(objects[i] instanceof Daire){
                    GeometrikNesne daire = new Daire((Daire)objects[i]);
                    if(daire.cevreHesapla() < minCevre)
                        minCevre = daire.cevreHesapla();
                    if(daire.cevreHesapla() > maxCevre)
                        maxCevre = daire.cevreHesapla();
                    if(daire.alanHesapla() < minAlan)
                        minAlan = daire.alanHesapla();
                    if(daire.alanHesapla() > maxAlan)
                        maxAlan = daire.alanHesapla();
                    ortCevre += daire.cevreHesapla();
                    ortAlan += daire.alanHesapla();
                }
                else if(objects[i] instanceof Dikdortgen){
                    GeometrikNesne dikdortgen = new Dikdortgen((Dikdortgen)objects[i]);
                    if(dikdortgen.cevreHesapla() < minCevre)
                        minCevre = dikdortgen.cevreHesapla();
                    if(dikdortgen.cevreHesapla() > maxCevre)
                        maxCevre = dikdortgen.cevreHesapla();
                    if(dikdortgen.alanHesapla() < minAlan)
                        minAlan = dikdortgen.alanHesapla();
                    if(dikdortgen.alanHesapla() > maxAlan)
                        maxAlan = dikdortgen.alanHesapla();
                    ortCevre += dikdortgen.cevreHesapla();
                    ortAlan += dikdortgen.alanHesapla();
                }
                else{
                    GeometrikNesne silindir = new Silindir((Silindir)objects[i]);
                    silindirCounter++;
                    if(silindir.cevreHesapla() < minCevre)
                        minCevre = silindir.cevreHesapla();
                    if(silindir.cevreHesapla() > maxCevre)
                        maxCevre = silindir.cevreHesapla();
                    if(silindir.alanHesapla() < minAlan)
                        minAlan = silindir.alanHesapla();
                    if(silindir.alanHesapla() > maxAlan)
                        maxAlan = silindir.alanHesapla();
                    Silindir newSilindir = (Silindir)silindir;
                    if(newSilindir.hacimHesapla() < minHacim)
                        minHacim = newSilindir.hacimHesapla();
                    if(newSilindir.hacimHesapla() > maxHacim)
                        maxHacim = newSilindir.hacimHesapla();
                    
                    ortCevre += silindir.cevreHesapla();
                    ortAlan += silindir.alanHesapla();
                    ortHacim += newSilindir.hacimHesapla();
                }
            }
            ortCevre /= objects.length;
            ortAlan /= objects.length;
            ortHacim /= silindirCounter;
            values[0] = ortCevre;
            values[1] = ortAlan;
            values[2] = ortHacim;
            values[3] = minCevre;
            values[4] = maxCevre;
            values[5] = minAlan;
            values[6] = maxAlan;
            values[7] = minHacim;
            values[8] = maxHacim;
            System.out.println("");
            System.out.println("Ortalama Çevre: " + Math.round(values[0]*100.0)/100.0 + " Ortalama Alan: "+ Math.round(values[1]*100.0)/100.0 +" Ortalama Hacim: " + Math.round(values[2]*100.0)/100.0 + " En Küçük Çevre: "+ Math.round(values[3]*100.0)/100.0 + " En Büyük Çevre: " + Math.round(values[4]*100.0)/100.0 + " En Küçük Alan: " + Math.round(values[5]*100.0)/100.0 + " En Büyük Alan: " + Math.round(values[6]*100.0)/100.0 + " En Küçük Hacim: " + Math.round(values[7]*100.0)/100.0 + " En Büyük Hacim: " + Math.round(values[8]*100.0)/100.0);
            
    }
    public static void polymorphicYazdir(GeometrikNesne o){
        if(o instanceof Daire){
            Daire temp = (Daire)o;
            System.out.println(temp.toString());
        }
        else if (o instanceof Dikdortgen){
            Dikdortgen temp = (Dikdortgen)o;
            System.out.println(temp.toString());
        }
        else{
            Silindir temp = (Silindir)o;
            System.out.println(temp.toString());
        }
    }

    public static void karsilastir(GeometrikNesne a, GeometrikNesne b){
        if(a instanceof Daire && b instanceof Daire){
            GeometrikNesne first = new Daire((Daire)a);
            int result = first.compareTo(b);
            switch(result){
                case 1:
                    System.out.println("İlk girilen dairenin yarıçapı ikinci girilen dairenin yarıçapından büyüktür.");
                    break;
                case 0:
                    System.out.println("İki dairenin yarıçapları eşittir.");
                    break;
                case -1:
                    System.out.println("İlk girilen dairenin yarıçapı ikinci girilen dairenin yarıçapından küçüktür.");
                    break;
            }
        }
        else if(a instanceof Dikdortgen && b instanceof Dikdortgen){
            GeometrikNesne first = new Dikdortgen((Dikdortgen)a);
            int result = first.compareTo(b);
            switch(result){
                case 1:
                    System.out.println("İlk girilen dikdörtgenin alanı ikinci girilen dikdörtgenin alanından büyüktür.");
                    break;
                case 0:
                    System.out.println("İki dikdörtgenin alanları eşittir.");
                    break;
                case -1:
                    System.out.println("İlk girilen dikdörtgenin alanı ikinci girilen dikdörtgenin alanından küçüktür.");
                    break;
            }
        }
        else if(a instanceof Silindir && b instanceof Silindir){
            GeometrikNesne first = new Silindir((Silindir)a);
            int result = first.compareTo(b);
            switch(result){
                case 1:
                    System.out.println("İlk girilen silindirin hacmi ikinci girilen silindirin hacminden büyüktür.");
                    break;
                case 0:
                    System.out.println("İki silindirin hacimleri eşittir.");
                    break;
                case -1:
                    System.out.println("İlk girilen silindirin hacmi ikinci girilen silindirin hacminden küçüktür.");
                    break;
            }
        }

        else{
            System.out.println("İki farklı türde nesneyi karşılaştıramazsınız.");
        }
    }
}
