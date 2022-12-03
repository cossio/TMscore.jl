module TMscore

import TMscore_jll

function tmscore(
    pdb1::AbstractString, pdb2::AbstractString;
    outfmt=nothing, seq::Bool=false, split=nothing,
    wait::Bool=true
)
    cmd = `$(TMscore_jll.TMscore())`
    isnothing(outfmt) || `$cmd -outfmt $outfmt`
    isnothing(split) || `$cmd -split $split`
    seq && `$cmd -seq`

    stdout = tempname()
    stderr = tempname()
    process = run(pipeline(`$cmd $pdb1 $pdb2`; stdout, stderr); wait=false)
    wait && Base.wait(process)

    return (; process, stdout, stderr)
end

end # module
