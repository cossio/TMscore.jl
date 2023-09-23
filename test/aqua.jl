import Aqua
import TMscore
using Test: @testset

@testset "aqua" begin
    Aqua.test_all(TMscore)
end
