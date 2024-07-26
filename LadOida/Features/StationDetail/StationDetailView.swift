//
//  StationDetailView.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 13.07.24.
//

import SwiftUI
import ComposableArchitecture

struct StationDetailView: View {

    let store: StoreOf<StationDetailCore>

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                HStack {
                    Text(store.station.contactName ?? "")
                        .font(AppFonts.bold(.title1))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    Image(systemName: "ev.charger.fill")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .shadow(radius: 15)
                }
                .padding(16)
                .foregroundStyle(.white)
            }
            .background(AppColors.color(.primary))

            ScrollView {
                VStack(spacing: 16) {
                    DetailRow(
                        title: "Status",
                        subtitle: store.station.status?.rawValue
                    )

                    DetailRow(
                        title: "Öffentlich",
                        subtitle: store.station.public == true ? "Ja" : "Nein"
                    )

                    DetailRow(
                        title: "Straße",
                        subtitle: store.station.street
                    )

                    DetailRow(
                        title: "Ort",
                        subtitle: "\(store.station.postCode ?? "") \(store.station.city ?? "")"
                    )

                    DetailRow(
                        title: "Beschreibung",
                        subtitle: store.station.description
                    )

                    DetailRow(
                        title: "Website",
                        subtitle: store.station.website,
                        link: true
                    )

                    DetailRow(
                        title: "Telefonnummer",
                        subtitle: store.station.telephone,
                        link: true
                    )

                    DetailRow(
                        title: "E-Mail",
                        subtitle: store.station.email,
                        link: true
                    )

                    DetailRow(
                        title: "Preise",
                        subtitle: store.station.priceUrl,
                        link: true
                    )

                    DetailRow(
                        title: "Grüne Energie",
                        subtitle: store.station.greenEnergy == true ? "Ja" : "Nein"
                    )

                    DetailRow(
                        title: "Gratis Parken",
                        subtitle: store.station.freeParking == true ? "Ja" : "Nein"
                    )

                    if let openingHours = store.station.openingHours {
                        if let text = openingHours.text {
                            DetailRow(
                                title: "Öffnungszeiten",
                                subtitle: text == "anytime" ? "Immer geöffnet" : text
                            )
                        } else if !openingHours.details.isEmpty {
                            let openingDetailHours = openingHours.details.map { openingHourDetail in
                                "\(openingHourDetail.fromWeekday ?? "") - \(openingHourDetail.toWeekday ?? ""), \(openingHourDetail.fromTime ?? "") - \(openingHourDetail.toTime ?? "")\n"
                            }.joined()

                            DetailRow(
                                title: "Öffnungszeiten",
                                subtitle: openingDetailHours
                            )
                        }
                    }

                    DetailRow(
                        title: "Ladepunkte"
                    ) {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(Array(store.station.points.enumerated()), id: \.offset) { index, point in
                                VStack(spacing: 2) {
                                    HStack {
                                        if let energyInKw = point.energyInKw {
                                            Text("\(String(format: "%.0f", energyInKw)) kW")
                                                .font(AppFonts.regular(.subtitle))

                                            Text("|")
                                                .font(AppFonts.regular(.subtitle))
                                        }

                                        ForEach(point.connectorTypes, id: \.self) { connectorType in
                                            Text(connectorType)
                                                .font(AppFonts.regular(.subtitle))
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                    HStack {
                                        ForEach(point.authenticationModes, id: \.self) { authenticationMode in
                                            if let mode = getImageForAuthenticationMode(key: authenticationMode) {
                                                HStack {
                                                    mode.0
                                                        .resizable()
                                                        .frame(width: 17, height: 17)

                                                    Text(mode.1)
                                                        .font(AppFonts.regular(.subtitle))
                                                }
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                    HStack {
                                        ForEach(point.vehicleTypes, id: \.self) { vehicleType in
                                            if let type = getImageForVehicleType(key: vehicleType) {
                                                HStack {
                                                    type.0
                                                        .resizable()
                                                        .frame(width: 17, height: 17)

                                                    Text(type.1)
                                                        .font(AppFonts.regular(.subtitle))
                                                }
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                    if let priceInCentPerKwh = point.priceInCentPerKwh {
                                        HStack {
                                            Text("Preis pro kWh:")
                                                .font(AppFonts.regular(.subtitle))

                                            Text("\(String(format: "%.0f", priceInCentPerKwh)) cent")
                                                .font(AppFonts.bold(.subtitle))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }

                                    if let priceInCentPerMin = point.priceInCentPerMin {
                                        HStack {
                                            Text("Preis pro Minute:")
                                                .font(AppFonts.regular(.subtitle))

                                            Text("\(String(format: "%.0f", priceInCentPerMin)) cent")
                                                .font(AppFonts.bold(.subtitle))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }

                                    if let evseId = point.evseId {
                                        HStack {
                                            Text("EVSE ID:")
                                                .font(AppFonts.regular(.subtitle))

                                            Text(evseId)
                                                .font(AppFonts.bold(.subtitle))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }

                                    if let roaming = point.roaming {
                                        HStack {
                                            Text("Roaming")
                                                .font(AppFonts.regular(.subtitle))

                                            if roaming {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .resizable()
                                                    .frame(width: 17, height: 17)
                                                    .foregroundStyle(.green)
                                            } else {
                                                Image(systemName: "xmark.circle.fill")
                                                    .resizable()
                                                    .frame(width: 17, height: 17)
                                                    .foregroundStyle(.red)
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }

                                    if let freeOfCharge = point.freeOfCharge {
                                        HStack {
                                            Text("Kostenlos")
                                                .font(AppFonts.regular(.subtitle))

                                            if freeOfCharge {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .resizable()
                                                    .frame(width: 17, height: 17)
                                                    .foregroundStyle(.green)
                                            } else {
                                                Image(systemName: "xmark.circle.fill")
                                                    .resizable()
                                                    .frame(width: 17, height: 17)
                                                    .foregroundStyle(.red)
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }

                                if store.station.points.count > 1,
                                   index != store.station.points.count - 1 {
                                    Divider()
                                }
                            }
                        }
                    }

                    if let location = store.station.location,
                       let latitude = location.latitude,
                       let longitude = location.longitude,
                       let url = URL(string: "maps://?saddr=&daddr=\(latitude),\(longitude)"),
                       UIApplication.shared.canOpenURL(url) {
                        Button(
                            action: {
                                UIApplication.shared.open(url)
                            },
                            label: {
                                VStack {
                                    HStack {
                                        Text("Ladestelle in Maps öffnen")
                                            .font(AppFonts.bold(.subtitle))
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .foregroundStyle(.white)

                                        Spacer()

                                        Image(systemName: "map.fill")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .tint(.white)
                                    }
                                    .padding()
                                }
                                .background(AppColors.color(.primary))
                                .border(AppColors.color(.divider))
                            }
                        )
                        .padding(.bottom)
                    }
                }
                .padding()
            }

            Spacer()
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .textSelection(.enabled)
        .ignoresSafeArea()
    }

    func getImageForAuthenticationMode(key: String) -> (Image, String)? {
        switch key {
        case "CASH":
            return (Image(systemName: "eurosign.square.fill"), "Bar")
        case "RFID":
            return (Image(systemName: "wifi.square.fill"), "RFID")
        case "CREDIT_CARD":
            return (Image(systemName: "creditcard.fill"), "Kreditkarte")
        case "DEBIT_CARD":
            return (Image(systemName: "creditcard"), "Debitkarte")
        case "APP":
            return (Image(systemName: "iphone.gen3.circle.fill"), "App")
        case "SMS":
            return (Image(systemName: "message.badge.filled.fill.rtl"), "Sms")
        case "NFC":
            return (Image(systemName: "wifi.router.fill"), "NFC")
        case "WEBSITE":
            return (Image(systemName: "globe"), "Web")
        default:
            return nil
        }
    }

    func getImageForVehicleType(key: String) -> (Image, String)? {
        switch key {
        case "CAR":
            return (Image(systemName: "car.fill"), "Auto")
        case "MOTORCYCLE":
            return (Image(systemName: "bicycle.circle.fill"), "Motorrad")
        case "BICYCLE":
            return (Image(systemName: "figure.outdoor.cycle"), "Fahrrad")
        case "BOAT":
            return (Image(systemName: "sailboat.circle.fill"), "Boot")
        case "TRUCK":
            return (Image(systemName: "truck.box.fill"), "Truck")
        default:
            return nil
        }
    }
}

struct DetailRow<Content: View>: View{
    let title: String
    let subtitle: String?
    let link: Bool
    @ViewBuilder let content: (() -> Content)

    init(
        title: String,
        subtitle: String? = nil,
        link: Bool = false,
        content: @escaping (() -> Content) = { EmptyView() }
    ) {
        self.title = title
        self.subtitle = subtitle
        self.link = link
        self.content = content
    }

    var body: some View {
        if subtitle != nil || Content.self != EmptyView.self {
            VStack {
                Text(title)
                    .font(AppFonts.bold(.subtitle))
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let subtitle {
                    if link,
                       let url = URL(string: title == "Telefonnummer" ? "tel:\(subtitle)" : subtitle) {
                        Link(subtitle, destination: url)
                            .font(AppFonts.regular(.subtitle))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text(subtitle)
                            .font(AppFonts.regular(.subtitle))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }

                if Content.self != EmptyView.self {
                    content()
                }
            }
            .multilineTextAlignment(.leading)
        }
    }
}
