using JuMP, Gurobi, Suppressor

include("types/bnb_model.jl")
include("utils/node_generation.jl")
include("utils/branching.jl")
include("utils/node_selection.jl")
include("bnb_solve.jl")

# testing

# model generation
m = Model(optimizer_with_attributes(Gurobi.Optimizer, "OutputFlag" => 0))
@variable(m, x[1:3]>=0, Int)

@objective(m, Max, 8*x[1] + 5*x[2] + 10*x[3])
@constraint(m, 2*x[1] +4*x[2] + 1*x[3] <= 25)
@constraint(m, x[1] <= 15)
@constraint(m, 2*x[2] <= 10)
@constraint(m, 2*x[3] <= 3)

# optimising the model
@suppress optimize!(m)

# printing the reulsts
print("Gurobi results\n")
print("Optimal objective value: $(objective_value(m))\n")
print("optimal decision variables values: $(value.(m[:x]))\n\n")

# using bnb method
print("BnB results\n")
result = bnb_solve(m)
