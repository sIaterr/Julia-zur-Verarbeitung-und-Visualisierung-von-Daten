function körperAnpassen(längereListe, kürzereListe)
    Differenz = length(längereListe) - length(kürzereListe)
    
    for n in 1:Differenz
        push!(kürzereListe, kürzereListe[length(kürzereListe)])
    end

    return kürzereListe
end

animOktaeder = körperAnpassen(grundWürfel, Oktaeder)

Zeit = length(grundWürfel)
Anim = @animate for i in 1:(3 * Zeit)
    if i <= Zeit
        plot(grundWürfel[1:i], axis = :off, legend = false, grid = false, camera = (2*i, 30))
    elseif Zeit < i <= 2 * Zeit
        plot!(animOktaeder[1:(i - Zeit)], 
        axis = :off, legend = false, grid = false, color ="red", camera = (2*i, 30))
    else
        plot!(innererWürfel[1:(i - 2 * Zeit)], 
        axis = :off, legend = false, grid = false, color="green", camera = (2*i, 30))
    end
end

gif(Anim, fps = 15)