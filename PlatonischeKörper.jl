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

eckpunkteInneresTetreaeder = mittelpunkteBerechnen(seitenGrundTetraeder)
inneresTetraeder = tetraederZeichnen(eckpunkteInneresTetreaeder)

# Teilplot für die Tetraeder-Dualität
tetraederPlot = plot3d(grundTetraeder, axis = :off, legend = false, grid = false)
plot3d!(inneresTetraeder)

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
Ψ = eckpunkteGrundWürfel
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

# Seiten des Oktaeders definieren
Σ = eckpunkteOktaeder
seitenOktaeder = [
    (Σ[1], Σ[2], Σ[3]),
    (Σ[1], Σ[2], Σ[4]),
    (Σ[1], Σ[4], Σ[5]),
    (Σ[1], Σ[3], Σ[5]),
    (Σ[6], Σ[2], Σ[3]),
    (Σ[6], Σ[2], Σ[4]),
    (Σ[6], Σ[4], Σ[5]),
    (Σ[6], Σ[3], Σ[5])
]

eckpunkteInnererWürfel = mittelpunkteBerechnen(seitenOktaeder)
innererWürfel = würfelZeichnen(eckpunkteInnererWürfel)

# Teilplot für die Würfel-Otaeder-Dualität
würfelOktaederPlot = plot3d(grundWürfel, axis = :off, legend = false, grid = false)
plot3d!(Oktaeder)
plot3d!(innererWürfel)

function dodekaederZeichnen(Eckpunkte)
    P1 = Eckpunkte[1]; P2 = Eckpunkte[2]
    P3 = Eckpunkte[3]; P4 = Eckpunkte[4]
    P5 = Eckpunkte[5]; P6 = Eckpunkte[6]
    P7 = Eckpunkte[7]; P8 = Eckpunkte[8]
    P9 = Eckpunkte[9]; P10 = Eckpunkte[10]
    P11 = Eckpunkte[11]; P12 = Eckpunkte[12]
    P13 = Eckpunkte[13]; P14 = Eckpunkte[14]
    P15 = Eckpunkte[15]; P16 = Eckpunkte[16]
    P17 = Eckpunkte[17]; P18 = Eckpunkte[18]
    P19 = Eckpunkte[19]; P20 = Eckpunkte[20]

    return [
        P1, P9, P2, P14, P13, P1,
        P17, P4, P10, P9, P10,
        P3, P18, P2, P18,
        P19, P6, P14, P6,
        P12, P5, P13, P5,
        P20, P17,
        P4, P16, P8, P20, P8,
        P11, P12, P11,
        P7, P19, P7,
        P15, P3, P15, P16
    ]
end

function ikosaederZeichnen(Eckpunkte)
    P1 = Eckpunkte[1]; P2 = Eckpunkte[2]
    P3 = Eckpunkte[3]; P4 = Eckpunkte[4]
    P5 = Eckpunkte[5]; P6 = Eckpunkte[6]
    P7 = Eckpunkte[7]; P8 = Eckpunkte[8]
    P9 = Eckpunkte[9]; P10 = Eckpunkte[10]
    P11 = Eckpunkte[11]; P12 = Eckpunkte[12]

    return [
        P1, P3, P4, P10, P3, P11, P10, P12, P11, P7, P12, P8, P7, P6, P8, P5, P6, P1, P5, P4, P1,
        P2, P6, P2, P7, P2, P11, P2, P3, P4, P9, P5, P9, P8, P9, P12, P9, P10
    ]
end

Φ = (1 + sqrt(5))/2
eckpunkteGrundDodekaeder = [
    (1, 1, 1), (-1, 1, 1), (-1, -1, 1), (1, -1, 1), 
    (1, 1, -1), (-1, 1, -1), (-1, -1, -1), (1, -1, -1),
    (0, 1/Φ, Φ), (0, -1/Φ, Φ), (0, -1/Φ, -Φ), (0, 1/Φ, -Φ),
    (1/Φ, Φ, 0), (-1/Φ, Φ, 0), (-1/Φ, -Φ, 0), (1/Φ, -Φ, 0),
    (Φ, 0, 1/Φ), (-Φ, 0, 1/Φ), (-Φ, 0, -1/Φ), (Φ, 0, -1/Φ)
]    

# Seiten des ersten Dodekaeders definieren
ϵ = eckpunkteGrundDodekaeder
seitenGrundDodekaeder = [
    (ϵ[1], ϵ[9], ϵ[2], ϵ[14], ϵ[13]),
    (ϵ[1], ϵ[17], ϵ[4], ϵ[10], ϵ[9]),
    (ϵ[9], ϵ[10], ϵ[3], ϵ[18], ϵ[2]),
    (ϵ[2], ϵ[18], ϵ[19], ϵ[6], ϵ[14]),
    (ϵ[14], ϵ[6], ϵ[12], ϵ[5], ϵ[13]),
    (ϵ[13], ϵ[5], ϵ[20], ϵ[17], ϵ[1]),
    (ϵ[20], ϵ[17], ϵ[4], ϵ[16], ϵ[8]),
    (ϵ[8], ϵ[20], ϵ[5], ϵ[12], ϵ[11]),
    (ϵ[11], ϵ[12], ϵ[6], ϵ[19], ϵ[7]),
    (ϵ[7], ϵ[19], ϵ[18], ϵ[3], ϵ[15]),
    (ϵ[15], ϵ[3], ϵ[10], ϵ[4], ϵ[16]),
    (ϵ[16], ϵ[8], ϵ[11], ϵ[7], ϵ[15])
]

grundDodekaeder = dodekaederZeichnen(eckpunkteGrundDodekaeder)

eckpunkteIkosaeder = mittelpunkteBerechnen(seitenGrundDodekaeder)
Ikosaeder = ikosaederZeichnen(eckpunkteIkosaeder)

λ = eckpunkteIkosaeder
seitenIkosaeder = [
    (λ[1], λ[2], λ[6]), (λ[1], λ[3], λ[4]), (λ[3], λ[10], λ[11]), (λ[2], λ[7], λ[11]),
    (λ[5], λ[6], λ[8]), (λ[4], λ[5], λ[9]), (λ[9], λ[10], λ[12]),(λ[7], λ[8], λ[12]),
    (λ[1], λ[2], λ[3]), (λ[2], λ[3], λ[11]), (λ[8], λ[9], λ[12]), (λ[5], λ[8], λ[9]),
    (λ[1], λ[5], λ[6]), (λ[1], λ[4], λ[5]), (λ[10], λ[11], λ[12]), (λ[7], λ[11], λ[12]),
    (λ[2], λ[6], λ[7]), (λ[3], λ[4], λ[10]), (λ[4], λ[9], λ[10]), (λ[6], λ[7], λ[8])
]

eckpunkteInneresDodekaeder = mittelpunkteBerechnen(seitenIkosaeder)
inneresDodekaeder = dodekaederZeichnen(eckpunkteInneresDodekaeder)

oktaederIkosaederPlot = plot3d(grundDodekaeder, axis = :off, legend = false, grid = false)
plot3d!(Ikosaeder)
plot3d!(inneresDodekaeder)


plot3d(
    tetraederPlot, würfelOktaederPlot, oktaederIkosaederPlot, 
    layout = grid(1, 3, widths=[0.3 , 0.3, 0.4])
)
