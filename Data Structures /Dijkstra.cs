using System;

public class Dijkstra
{
    public static int INFINITY = 1000;
    public static void Main(String[] args)
    {
        var N = 5;
        int[,] cost =
        {
        {1000, 5, 3, 1000, 2},
        {1000, 1000, 2, 6, 1000},
        {1000, 1, 1000, 2, 1000},
        {1000, 1000, 1000, 1000, 1000},
        {1000, 6, 10, 4, 8}};

        int[] distances = new int[N];
        Dijkstra.Distance(N, cost, distances);
        for (int i = 0; i < distances.Length; ++i)
        {
            Console.WriteLine(distances[i]);
        }
    }

    public static void Distance(int N, int[,] cost, int[] D)
    {
        int w;
        int v;
        int min;
        bool[] visited = new bool[N];
        D[0] = 0;
        for (v = 1; v < N; v++)
        {
            visited[v] = false;
            D[v] = cost[0, v];
        }
        ;
        for (int i = 1; i < N; ++i)
        {

            min = Dijkstra.INFINITY;
            for (

            w = 1; w < N; w++)
            {
                if (!visited[w])
                {

                    if (D[w] < min)
                    {

                        v = w;
                        min = D[w];
                    }
                }
            }

            visited[v] = true;
            for (w = 1; w < N; w++)
            {

                if (!visited[w])
                {

                    if (min + cost[v, w] < D[w])
                    {

                        D[w] = min + cost[v, w];
                    }
                }
            }
        }
    }
}


