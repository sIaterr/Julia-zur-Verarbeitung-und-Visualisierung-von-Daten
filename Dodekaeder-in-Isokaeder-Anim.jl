function körperAnpassen(längereListe, kürzereListe)
    Differenz = length(längereListe) - length(kürzereListe)
    
    for n in 1:Differenz
        push!(kürzereListe, kürzereListe[length(kürzereListe)])
    end

    return kürzereListe
end

animIkosaeder = körperAnpassen(grundDodekaeder, Ikosaeder)

Zeit = length(grundDodekaeder)
Animation1 = @animate for i in 1:(2 * Zeit)
    if i <= Zeit
        plot(
            animIkosaeder[1:i], axis = :off, legend = false, grid = false, camera = (2*i, 30),
            xlim = (-Φ, Φ), ylim = (-Φ, Φ), zlim = (-Φ, Φ)
        )
    else
        plot!(inneresDodekaeder[1:(i - Zeit)], 
        axis = :off, legend = false, grid = false, color="green", camera = (2*i, 30))
    end
end

gif(Animation1, fps = 12)