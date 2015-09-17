class Binary_Search_Tree
  attr_accessor :root

  def build(ary = [])
    shuffled_ary = ary.shuffle
    @root = Node.new(shuffled_ary.pop)

    until shuffled_ary.empty?
      new_node = Node.new(shuffled_ary.pop)
      insert(new_node) unless new_node.value.nil?
    end
  end

  def insert(new_node, current_node = @root)
    if new_node.value <= current_node.value
      if current_node.left.nil?
        current_node.left = new_node
        new_node.parent = current_node
        return
      else
        insert(new_node, current_node.left)
      end
    else
      if current_node.right.nil?
        current_node.right = new_node
        new_node.parent = current_node
        return
      else
        insert(new_node, current_node.right)
      end
    end
  end

  def breadth_first_search(value)
    queue = []
    queue.unshift(@root) unless @root.nil?

    until queue.empty?
      current_node = queue.pop
      # puts "CURRENT NODE: #{current_node.value}"
      # puts "QUEUE: #{queue.inspect}"
      return current_node if current_node.value == value
      queue.unshift(current_node.left) unless current_node.left.nil?
      queue.unshift(current_node.right) unless current_node.right.nil?
    end

    nil
  end

  def depth_first_search(value)
    stack = []
    stack.push(@root) unless root.nil?

    until stack.empty?
      current_node = stack.pop
      return current_node if current_node.value == value
      stack.push current_node.left unless current_node.left.nil?
      stack.push current_node.right unless current_node.right.nil?
    end

    nil
  end

  def dfs_rec(value, current_node = @root)
    return nil if current_node.nil?
    result ||= dfs_rec(value, current_node.left)
    return current_node if current_node.value == value
    result ||= dfs_rec(value, current_node.right)
    result
  end

  def inspect
    str = "["
    print_node(@root, str)
    str = str[0..-3]
    str << "]"
    str
  end

  def empty?
    @root.nil?
  end

  private

  def print_node(current_node, str)
    return str if current_node.nil?
    print_node(current_node.left, str)
    str << current_node.value.to_s
    str << ", "
    print_node(current_node.right, str)
  end
end

class Node
  attr_accessor :value, :parent, :left, :right

  def initialize(value = nil, parent = nil, left = nil, right = nil)
    @value = value
    @parent = parent
    @left = left
    @right = right
  end

  def children
    ary = []
    ary << @left unless @left.nil?
    ary << @right unless @right.nil?
    ary
  end
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Binary_Search_Tree.new
tree.build(arr)
p tree
puts tree.breadth_first_search(1)
p tree.breadth_first_search(10)
puts tree.depth_first_search(1)
puts tree.depth_first_search(324)
p tree.depth_first_search(10)
puts tree.dfs_rec(1)
puts tree.dfs_rec(324)
p tree.dfs_rec(10)
