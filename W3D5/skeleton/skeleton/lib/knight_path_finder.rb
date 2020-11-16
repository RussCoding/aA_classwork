require_relative "00_tree_node"

class KnightPathFinder

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [@root_node.value]
        self.build_move_tree
    end

    def self.valid_moves(pos)
        valid_moves = []
        moves = [[1, -1], [2, -2]]
        moves[0].each do |i|
            moves[1].each do |j|
                first_move = pos[0] + i    
                second_move = pos[1] + j
                if first_move.between?(0, 7) && second_move.between?(0, 7)
                    valid_moves << [first_move, second_move]
                end
                third_move = pos[0] + j    
                fourth_move = pos[1] + i
                if third_move.between?(0, 7) && fourth_move.between?(0, 7)
                    valid_moves << [third_move, fourth_move]
                end
            end 
        end 
        valid_moves
    end 
    

    def new_move_positions(pos)
        arr = KnightPathFinder.valid_moves(pos).reject {|ele| @considered_positions.include?(ele) }
        arr.each {|coordinate| considered_positions << coordinate}
        arr
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty? 
            current_position = queue.shift
            move_nodes = self.new_move_positions(current_position.value).map {|ele| PolyTreeNode.new(pos)}
            move_nodes.each {|node| current_position.add_child(node)}
            queue += move_nodes
            #queue.each {|pos| pos.parent = current_position}
        end 
    end

end