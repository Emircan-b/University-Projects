package com.mycompany.mavenproject1;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.HashMap;
import java.util.Map;

public class BuildHierarchyTree {

    protected Map<String, Employee> employees = new HashMap<>();
    protected Employee root;
    Employee employee = null;

    public void readDataAndCreateMap() throws Exception {

        BufferedReader br = new BufferedReader(new FileReader("girdi.txt"));
        String line = null;
        

        while ((line = br.readLine()) != null) {
            String[] values = line.split("[, ]+");

            if (values[0].equals("D")) {
                int num = Integer.parseInt(values[3]);
                employee = new Director(values[0], values[1], values[2], num, values[4]);
                if (values[4].equals("Root")) {
                    root = employee;

                }

            } else {
                int num = Integer.parseInt(values[3]);
                employee = new Memur(values[0], values[1], values[2], num, values[4]);

            }

            employees.put(employee.ad, employee);
            
            
        }

        br.close();

    }

    public void buildHierarchyTree(Employee root) {

        Director director = (Director) root;
        Employee[] subs = getSubsByAd(director.ad);
        if (subs.length == 0) {
            return;
        }

        employees.get(director.ad).subordinates = subs;

        for (Employee em : subs) {
            buildHierarchyTree(em);
        }

    }

    private Employee[] getSubsByAd(String dirAd) {
        Employee[] subs = new Employee[0];

        for (Employee em : employees.values()) {
            if (em.ust.equals(dirAd)) {
                Employee[] temps = new Employee[subs.length + 1];
                System.arraycopy(subs, 0, temps, 0, subs.length);
                temps[temps.length - 1] = em;
                subs = temps;

            }

        }
        return subs;
    }

    public void printHierarchyTree(Employee root, int level) {
        for (int i = 0; i < level; i++)
            System.out.print("\t");
        System.out.print(root.title);
        System.out.print("(");
        System.out.print(root.ad);
        System.out.print(root.soyad);
        System.out.print(",");
        System.out.print(root.maas);
        System.out.println(")");
        
        Employee[] subs = root.subordinates;


        for (Employee em : subs){
            printHierarchyTree(em, level + 1);
            
        }
    }

    public void printMaliyet(Employee root, int level) {
        
        System.out.print(root.ad);
        System.out.print(" ");
        System.out.print(root.soyad);
        System.out.print(", Maliyet: ");
        System.out.println(root.maliyet());
        
        
        Employee[] subs = root.subordinates;


        for (Employee em : subs){
            printMaliyet(em, level + 1);
            
        }
    }

}
