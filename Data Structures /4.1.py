import networkx as nx
import pylab

G = nx.DiGraph()

G.add_weighted_edges_from(
    [(0, 4, 2), (0, 2, 3), (0, 1, 5), (1, 2, 2), (1, 3, 6), (2, 1, 1), (2, 3, 2), (4, 1, 6), (4, 2, 10), (4, 3, 4)])

pos = nx.spring_layout(G)

pylab.figure(2)
nx.draw(G, pos)
edge_labels = dict([((u, v,), d['weight'])
                    for u, v, d in G.edges(data=True)])
nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels)
nx.draw_networkx_labels(G, pos)
pylab.show()
