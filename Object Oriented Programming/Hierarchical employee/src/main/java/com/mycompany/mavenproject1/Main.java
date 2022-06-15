package com.mycompany.mavenproject1;


/**
 *
 * @author noxwiz
 */

public class Main {
  public static void main(String[] args) throws Exception {
    
    BuildHierarchyTree tree = new BuildHierarchyTree();
    tree.readDataAndCreateMap();
    tree.buildHierarchyTree(tree.root);
	  tree.printHierarchyTree(tree.root, 0);
    tree.printMaliyet(tree.root, 0);

    

  }
}

