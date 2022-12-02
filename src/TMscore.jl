module TMscore

import TMscore_jll

function tmscore(
    pdb1::AbstractString, pdb2::AbstractString;
    outfmt=nothing, seq::Bool=false
)
    cmd = `$(TMscore_jll.TMscore())`
    isnothing(outfmt) || `$cmd -outfmt $outfmt`
    seq && `$cmd -seq`

    stdout = tempname()
    stderr = tempname()
    run(pipeline(`$cmd $pdb1 $pdb2`; stdout, stderr))

    return (; stdout, stderr)
end

end # module
