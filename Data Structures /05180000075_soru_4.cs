using System;
using System.Collections.Generic;

namespace data_proje_3_part_2
{
    class Program
    {
        static void Main()
        {
            int[] arr = new int[10] { 45, 92, 12, 16, 26, 82, 61, 33, 73, 6 };
            int n = 10, i, j, val, flag;
            Console.WriteLine("Insertion sort yöntemini kullanmayı tercih ettik.");
            Console.WriteLine("En kötü senaryoda O(n^2), en iyi senaryoda O(n) ");
            Console.WriteLine("ve bununla birlikte ortalama durum için zaman karmaşıklığı üssü büyük olanın domine etmesiyle O(n^2) olacaktır.");
            Console.WriteLine("Insertion sort basit mantığı ve küçük listelerdeki çalışma hızıyla öne çıksa da ");
            Console.WriteLine("büyük listelerde zaman karmaşıklığı nedeniyle diğerlerinin gerisinde kalmaktadır. \n");

            Console.Write("Başlangıçtaki liste: ");
            for (i = 0; i < n; i++)
            {
                Console.Write(arr[i] + " ");
            }
            for (i = 1; i < n; i++)
            {
                val = arr[i];
                flag = 0;
                for (j = i - 1; j >= 0 && flag != 1;)
                {
                    if (val < arr[j])
                    {
                        arr[j + 1] = arr[j];
                        j--;
                        arr[j + 1] = val;
                    }
                    else flag = 1;
                }
            }
            Console.Write("\nListenin sıralanmış hali: ");
            for (i = 0; i < n; i++)
            {
                Console.Write(arr[i] + " ");
            }
        }
    }
}
