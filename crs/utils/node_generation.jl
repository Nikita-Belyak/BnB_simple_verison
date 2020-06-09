"""a
    child_node_generation(parent_node::Model, var_index::Int, inequality::String, value::Int)
returns a child node generated from a parent_node by copying it
and addinbg auxiliary constraint x[var_index] "<=" or ">=" value.

"""
function child_node_generation(parent_node::Model, var_index::Int, inequality::String, value::Int)
    child_node = copy(parent_node)
    @suppress set_optimizer(child_node, Gurobi.Optimizer)
    inequality == "<=" ? @constraint(child_node, child_node[:x][var_index] <= value) : @constraint(child_node, child_node[:x][var_index] >= value)
    return child_node
end

"""
    zero_node_generation(model::Model)
returns zero node by relaxing integrality conditions
in the original problem

"""
function zero_node_generation(model::Model)
    zero_node = copy(model)
    @suppress set_optimizer(zero_node, optimizer_with_attributes(Gurobi.Optimizer, "OutputFlag" => 0))
    JuMP.unset_integer.(JuMP.all_variables(zero_node))
    return zero_node
end
