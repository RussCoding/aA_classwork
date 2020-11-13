require "byebug"
class PolyTreeNode
    attr_reader :parent, :value, :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = Array.new()
    end

    def parent=(parent_node)
        if parent_node == nil
            @parent = nil
        else
            if self.parent != nil 
                self.parent.children.reject!{|node| self==node}
            end 
            @parent = parent_node
            parent_node.children << self if !parent_node.children.include?(self)
        end
    end 

    def add_child(child)
        child.parent = self
    end
    
    def remove_child(child)
        raise "Not a child" if child.parent == nil
        child.parent = nil
    end

    def dfs(target)
        #debugger
        return self if self.value == target
        #debugger
        self.children.each do |child|
                return child if child.value == target
                child.dfs(target)
            #debugger
        end 
        #debugger
        nil   
    end 


    def bfs(target)
        queue = []
        queue << self
        until queue.empty?
            current = queue.shift
            if current.value == target
                return current
            else
                current.children.each {|child| queue << child}
            end
        end
        nil
    end 

end
