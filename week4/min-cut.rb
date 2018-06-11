FIXNUM_MAX = (2**(0.size * 8 -2) -1)

class Node
    attr_reader :name
    attr_reader :successors
  
    def initialize(name)
      @name = name
      @successors = []
    end
  
    def add_edge(successor)
      @successors << successor
    end

    def remove_edge(name)
      @successors -= [name]
    end

    def n_of_edges
      @successors.length
    end

    def sample
      @successors.sample(1).first
    end

    def [](position)
      @successors[position]
    end

    def include?(name)
      @successors.include?(name)
    end

    def to_s
      "#{@name} -> [#{@successors.join(' ')}]"
    end
end

class Graph

    def initialize
      @nodes = {}
    end
  
    def add_node(node)
      @nodes[node.name] = node
    end

    def remove_node(node_name)
      @nodes.delete(node_name)
    end
  
    def add_edge(predecessor_name, successor_name)
      @nodes[predecessor_name].add_edge(successor_name)
    end

    def contraption(node_name, other_node_name)
      @nodes[other_node_name].successors.each{ |successor|
        add_edge(node_name, successor)
        add_edge(successor, node_name)
        @nodes[successor].remove_edge(other_node_name)
      }
      self.remove_node(other_node_name)
    end

    def remove_self_loops
      @nodes.each{|node|
        if node[1].include?(node[1].name)
          node[1].remove_edge(node[1].name)
        end
      }
    end
  
    def [](name)
      @nodes[name]
    end

    def empty?
      @nodes.length == 0
    end

    def n_of_nodes
      @nodes.length
    end

    def n_of_edges
      length = 0
      @nodes.each{|node|
        length += node[1].n_of_edges
      }
      # Directed graph
      length / 2
    end

    def sample
      @nodes.to_a.sample(1)
    end

    def sample_edge
      node_name = sample.first[0]
      return node_name, @nodes[node_name].sample
    end

    def to_s
      "Graph"
    end
end

def read_graph
  graph = Graph.new
  File.open("kargerMinCut.txt", "r") do |f|
      f.each_line do |line|
          node_array = line.split(/\s/).reject(&:empty?)
  
          node_name = node_array.first
          graph.add_node(Node.new(node_name))
          node_array.shift
  
          node_array.each { |other_node_name| 
              graph.add_edge(node_name, other_node_name)
          }
      end
  end
  return graph
end

def min_cut(graph)

  while graph.n_of_nodes > 2
    (node,other_node) = graph.sample_edge
    graph.contraption(node, other_node)
    graph.remove_self_loops
  end

  return graph
end

def sample_min_cut 
  min = FIXNUM_MAX
  results = []
  for i in 1..20
    graph = read_graph
    a  = min_cut(graph).n_of_edges
    results.push(a)
    min = [min, a].min
  end
  # Minimun cut is 17
  puts min
end

sample_min_cut