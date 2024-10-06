using Plots

function mittelpunkteBerechnen(Seiten)
    Mittelpunkte = Tuple{Real, Real, Real}[]        # direkt in den benötigten Datentyp umwandeln

    for Seite in Seiten
        xSumme = ySumme = zSumme = 0                # für nächste Seite zurücksetzen

        # alle Werte der Eckpunkte der Seiten zusammenrechnen
        for Punkt in Seite
            xSumme += Punkt[1]
            ySumme += Punkt[2]
            zSumme += Punkt[3]
        end

        # durch die Anzahl der Eckpunkte teilen, um Durchschnitt zu bekommen
        Xμ = xSumme/length(Seite)
        Yμ = ySumme/length(Seite)
        Zμ = zSumme/length(Seite)
        Pμ = (Xμ, Yμ, Zμ)

        push!(Mittelpunkte, Pμ)
        
    end

    return Mittelpunkte
end

function tetraederZeichnen(Eckpunkte)
    P1 = Eckpunkte[1]
    P2 = Eckpunkte[2]
    P3 = Eckpunkte[3]
    P4 = Eckpunkte[4]

    return [P1, P2, P3, P1, P4, P2, P3, P4]         # diese Reihenfolge der Punkte verfolgt den Umriss
end

# Eckpunkte des Tetraeders
eckpunkteGrundTetraeder = [
    (0, 0, 0),                          # Ecke am Nullpunkt
    (0.5, sqrt(3)/2, 0),                # zweite Ecke auf der Grundfläche
    (1, 0, 0),                          # dritte Ecke auf der Grundfläche
    (0.5, sqrt(3)/6, sqrt(2/3))         # Spitze des Tetraeders
]

# Seiten des ersten Tetraeders definieren
Ω = eckpunkteGrundTetraeder         # kürzerer Name für den Array für Kompaktheit
seitenGrundTetraeder = [
    (Ω[1], Ω[2], Ω[3]),
    (Ω[1], Ω[2], Ω[4]),
    (Ω[1], Ω[3], Ω[4]),
    (Ω[2], Ω[3], Ω[4])
]

grundTetraeder = tetraederZeichnen(eckpunkteGrundTetraeder)

eckpunkteNeuesTetreaeder = mittelpunkteBerechnen(seitenGrundTetraeder)
neuesTetraeder = tetraederZeichnen(eckpunkteNeuesTetreaeder)

# Teilplot für die Tetraeder-Dualität
tetraederPlot = plot3d(grundTetraeder)
plot3d!(neuesTetraeder)

function würfelZeichnen(Eckpunkte)
    P1 = Eckpunkte[1]
    P2 = Eckpunkte[2]
    P3 = Eckpunkte[3]
    P4 = Eckpunkte[4]
    P5 = Eckpunkte[5]
    P6 = Eckpunkte[6]
    P7 = Eckpunkte[7]
    P8 = Eckpunkte[8]

    return [P1, P2, P3, P4, P1, P5, P6, P2, P6, P7, P3, P7, P8, P4, P8, P5]
end

function oktaederZeichnen(Eckpunkte)
    P1 = Eckpunkte[1]
    P2 = Eckpunkte[2]
    P3 = Eckpunkte[3]
    P4 = Eckpunkte[4]
    P5 = Eckpunkte[5]
    P6 = Eckpunkte[6]

    return [P3, P6, P2, P3, P1, P2, P4, P1, P5, P4, P6, P5, P3]
end

# Eckpunkte des Grundwürfels
eckpunkteGrundWürfel = [
    (0, 0, 0)
    (1, 0, 0)
    (1, 1, 0)
    (0, 1, 0)
    (0, 0, 1)
    (1, 0, 1)
    (1, 1, 1)
    (0, 1, 1)    
]

# Seiten des ersten Würfels definieren
Ψ = eckpunkteGrundWürfel         # kürzerer Name für den Array für Kompaktheit
seitenGrundWürfel = [
    (Ψ[1], Ψ[2], Ψ[3], Ψ[4]),
    (Ψ[1], Ψ[2], Ψ[5], Ψ[6]),
    (Ψ[1], Ψ[4], Ψ[5], Ψ[8]),
    (Ψ[2], Ψ[3], Ψ[6], Ψ[7]),
    (Ψ[3], Ψ[4], Ψ[7], Ψ[8]),
    (Ψ[5], Ψ[6], Ψ[7], Ψ[8])
]

grundWürfel = würfelZeichnen(eckpunkteGrundWürfel)

eckpunkteOktaeder = mittelpunkteBerechnen(seitenGrundWürfel)
Oktaeder = oktaederZeichnen(eckpunkteOktaeder)

# Teilplot für die Würfel-Otaeder-Dualität
würfelOktaederPlot = plot3d(grundWürfel)
plot3d!(Oktaeder, xlims=(0, 1), ylims=(0, 1), zlims=(0, 1))

# Plots zusammen darstellen
plot(tetraederPlot, würfelOktaederPlot, layout=(1, 2))