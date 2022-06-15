using System;
using System.Collections;
namespace data_proje_3_part_2
{
    class Program
    {
        static void Main()
        {
            Hashtable DistrictandPopulation = new();
            string[] districtNames = { "Kazımdirik", "Atatürk", "Evka 3", "Barbaros", "Naldöken", "Zafer", "Serintepe", "Tuna", "Merkez", "Çiçekli" };
            int[] populations = { 33934, 28912, 20445, 11598, 9892, 9876, 6905, 7607, 6341, 399 };

            for (int i = 0; i < districtNames.Length; i++)
            {
                DistrictandPopulation.Add(districtNames[i], populations[i]);
            }

            Console.WriteLine("Projeyi yaptığım tarihteki nüfus sayımları: \n");
            for (int i = 0; i < districtNames.Length; i++)
            {
                Console.WriteLine( districtNames[i] + " mahallesinin nüfusu " + DistrictandPopulation[districtNames[i]] + "\n");
            }

            
            while (true)
            {
                Console.Write("Nüfusuna 1 eklemek istediğiniz mahallenin baş harfini giriniz: ");
                string harfInput = Console.ReadLine();
                for (int i = 0; i < districtNames.Length; i++)
                {
                    string tempDistrict = districtNames[i];
                    if (tempDistrict.StartsWith(harfInput))
                    {
                        int j = (int)DistrictandPopulation[tempDistrict];
                        j++;
                        DistrictandPopulation[tempDistrict] = j;

                        Console.WriteLine("\n" + tempDistrict + " mahallesinin nüfusu bir arttırıldıktan sonra: \n");
                        for (int k = 0; k < districtNames.Length; k++)
                        {
                            Console.WriteLine(districtNames[k] + " mahallesinin nüfusu " + DistrictandPopulation[districtNames[k]] + "\n");
                        }
                    }
                }
            }
        }
    }
}
