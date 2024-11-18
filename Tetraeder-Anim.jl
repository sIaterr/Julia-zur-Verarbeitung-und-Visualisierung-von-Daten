
Zeit = length(grundTetraeder)
Anim = @animate for i in 1:(2 * Zeit)
    if i <= Zeit
        plot(grundTetraeder[1:i], axis = :off, legend = false, grid = false, camera = (2*i + 10, 30))
    else
        plot!(inneresTetraeder[1:(i - Zeit)], 
        axis = :off, legend = false, grid = false, color ="red", camera = (2*i + 10, 30))
    end
end

gif(Anim, fps = 7)


