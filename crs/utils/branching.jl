function branching(X::Model, variable_index::Int)

    l_node_value = floor(Int64, value(X[:x][variable_index]))
    r_node_value = l_node_value + 1
    l_node = child_node_generation(X, variable_index, "<=", l_node_value)
    r_node = child_node_generation(X, variable_index, ">=", r_node_value)

    return l_node, r_node

end
