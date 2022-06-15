using System;
using System.Collections.Generic;

namespace DS_p3
{
    class Mahalle
    {
        public Mahalle leftChild;
        public Mahalle rightChild;
        public string ad;
        public List<OrderInfo> orderList = new();

        public Mahalle(string mahalleAd)
        {
            this.ad = mahalleAd;
            Random random = new Random();
            int sayi = random.Next(5, 11);
            for (int i = 0; i < sayi; i++)
            {
                OrderInfo order = new();
                orderList.Add(order);
            }
        }

        public void Print()
        {
            Console.WriteLine("Mahalle adı:  " + ad);
            for (int i = 0; i < orderList.Count; i++)
            {
                int j = i + 1;
                Console.WriteLine(j + ". sipariş:");
                orderList[i].Print();


            }
        }

    }

    public class Products
    {
        public string ad;
        public int adet;
        public int priceIndex;
        private static readonly string[] productList = { "Kola", "Sarı kola", "Şeffaf kola", "Ayran", "Tavuk Dürüm", "Kuşbaşı kaşarlı pide", "Mercimek çorbası", "Hamburger", "Kokoreç", "Lahmacun", "Çiğköfte", "Künefe" };
        public static readonly double[] priceList = { 8, 8, 8, 6, 24, 44, 18, 52, 27, 20, 16, 25 };
        public static readonly int[] soldCount = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

        public Products()
        {
            Random random = new();
            int num = random.Next(1, 9);
            adet = num;
            num = random.Next(12);
            ad = productList[num];
            priceIndex = num;
            soldCount[num] = soldCount[num] + adet;
        }

        public string ProductInf()
        {
            return ad + " adındaki üründen " + adet + " adet istenmiş ve " + Price() + " TL tutmuştur";
        }

        public double Price()
        {
            return adet * priceList[priceIndex];
        }

        public static int DiscountProduct(string temProduct) //ürünün kaç kere satıldığını döndürüp %10 indirim uygular
        {
            for (int i = 0; i < productList.Length; i++)
            {
                if (productList[i] == temProduct)
                {
                    priceList[i] *= 9 / 10;
                    return soldCount[i];

                }

            }
            return 0;

        }

    }


    class OrderTree
    {
        public Mahalle root;
        private int level = 0;

        public OrderTree()
        {
            root = null;
        }

        public void AddMahal(String mahalAd)
        {
            Mahalle tempMahal = new(mahalAd);
            if (root == null)
            {
                root = tempMahal;
            }
            else
            {
                Mahalle current = root;
                Mahalle currentCheckPoint;
                while (true)
                {
                    currentCheckPoint = current;
                    if (string.Compare(mahalAd, current.ad) == 1) //alfabetik olarak hangi tarafına yerleşmesi gerektiğine bakar
                    {
                        current = current.rightChild;
                        if (current == null) //sağ çocuk boş ise yerleşir değil ise while döngüsü tekrar başlar ve kaldığı yerden kontrol eder
                        {
                            currentCheckPoint.rightChild = tempMahal;
                            return;
                        }
                    }
                    else
                    {
                        current = current.leftChild;
                        if (current == null)
                        {
                            currentCheckPoint.leftChild = tempMahal;
                            return;
                        }
                    }
                }
            }
        }

        public void AlphabeticalPrintFrom()
        {
            AlphabeticalPrint(root);
        }

        public void AlphabeticalPrint(Mahalle mahal) //ağaç zaten alfabede önce geleni sola yazmak üzerine olduğundan bu şekilde yazdırıldığında alfabetik yazdırılmış olacaktır
        {
            if (mahal != null)
            {
                AlphabeticalPrint(mahal.leftChild);
                mahal.Print();
                AlphabeticalPrint(mahal.rightChild);
            }
        }

        public int GetLevelFrom()
        {
            GetLevel(root, 0);
            return level;
        }

        public int GetLevel(Mahalle mahal, int tempLvl)
        {
            if (tempLvl > level && mahal != null) //bulunduğu en derin yeri tutar
            {
                level = tempLvl;
            }
            if (mahal != null)
            {
                GetLevel(mahal.leftChild, tempLvl + 1);
                GetLevel(mahal.rightChild, tempLvl + 1);
            }

            return level;
        }

        public Mahalle ReturnMahalle(Mahalle mahal, string searchedMahal)
        {
            if (mahal != null && string.Compare(mahal.ad, searchedMahal) == 0)
            {
                return mahal;
            }
            else
            {
                if (mahal != null)
                {
                    ReturnMahalle(mahal.leftChild, searchedMahal);
                    ReturnMahalle(mahal.rightChild, searchedMahal);
                }
            }
            return null;
        }

        public void PrintOP(string mahalleAd) //150 TL'den daha pahalı olan siparişleri listeler
        {
            Console.WriteLine(mahalleAd + " mahallesinde 150TL'yi geçen siparişler: ");
            for (int i = 0; i < ReturnMahalle(root, mahalleAd).orderList.Count; i++)
            {

                if (ReturnMahalle(root, mahalleAd).orderList[i].Overpriced())
                {
                    Console.WriteLine("Sipariş " + i + " :");
                    ReturnMahalle(root, mahalleAd).orderList[i].Print();
                }
            }
        }

        public static int CountandDiscount(string ürünAdı)
        {
            return Products.DiscountProduct(ürünAdı);
        }

    }

    class OrderInfo
    {
        public List<Products> OrderInf = new();
        readonly double orderCost = 0;

        public OrderInfo()
        {
            Random random = new Random();
            int num = random.Next(3, 6);
            for (int i = 0; i < num; i++)
            {
                Products product = new Products();
                OrderInf.Add(product);
                orderCost += product.Price();
            }

        }

        public void Print()
        {
            double OrderCost = 0;
            for (int i = 0; i < OrderInf.Count; i++)
            {
                Console.WriteLine(OrderInf[i].ProductInf());
                OrderCost += OrderInf[i].Price();
            }
            Console.WriteLine("Sipariş tutarı: " + OrderCost + "TL");
            Console.WriteLine("\n");
        }

        public bool Overpriced()
        {
            if (orderCost > 150)//pahalı sipariş kontrolü 
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }

    class Program
    {
        static void Main()
        {
            string[] mahalleler = { "Kazımdirik", "Bostanlı", "Göztepe", "Mansuroğlu", "Kültür" };
            OrderTree myorderTree = new();
            for (int i = 0; i < mahalleler.Length; i++)
            {
                myorderTree.AddMahal(mahalleler[i]);
            }
            myorderTree.AlphabeticalPrintFrom();
            Console.WriteLine("Mahalle ağacının derinliği: " + myorderTree.GetLevelFrom());
            myorderTree.PrintOP("Kazımdirik");
            Console.WriteLine("Kokoreç adlı ürün " + OrderTree.CountandDiscount("Kokoreç") + " kez söylendi");
            Console.WriteLine("İndirim sonrası yenilenmiş hali ile siparişler: ");
            myorderTree.AlphabeticalPrintFrom();


        }

    }

}
