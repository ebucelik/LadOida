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
                    detailRow(
                        title: "Status",
                        subtitle: store.station.status?.rawValue
                    )

                    detailRow(
                        title: "Öffentlich",
                        subtitle: store.station.public == true ? "Ja" : "Nein"
                    )

                    detailRow(
                        title: "Straße",
                        subtitle: store.station.street
                    )

                    detailRow(
                        title: "Ort",
                        subtitle: "\(store.station.postCode ?? "") \(store.station.city ?? "")"
                    )

                    detailRow(
                        title: "Beschreibung",
                        subtitle: store.station.description
                    )

                    detailRow(
                        title: "Website",
                        subtitle: store.station.website,
                        link: true
                    )

                    detailRow(
                        title: "Telefonnummer",
                        subtitle: store.station.telephone,
                        link: true
                    )

                    detailRow(
                        title: "E-Mail",
                        subtitle: store.station.email,
                        link: true
                    )

                    detailRow(
                        title: "Preise",
                        subtitle: store.station.priceUrl,
                        link: true
                    )

                    detailRow(
                        title: "Grüne Energie",
                        subtitle: store.station.greenEnergy == true ? "Ja" : "Nein"
                    )

                    detailRow(
                        title: "Gratis Parken",
                        subtitle: store.station.freeParking == true ? "Ja" : "Nein"
                    )

                    if let openingHours = store.station.openingHours {
                        if let text = openingHours.text {
                            detailRow(
                                title: "Öffnungszeiten",
                                subtitle: text == "anytime" ? "Immer geöffnet" : text
                            )
                        } else if !openingHours.details.isEmpty {
                            let openingDetailHours = openingHours.details.map { openingHourDetail in
                                "\(openingHourDetail.fromWeekday ?? "") - \(openingHourDetail.toWeekday ?? ""), \(openingHourDetail.fromTime ?? "") - \(openingHourDetail.toTime ?? "")\n"
                            }.joined()

                            detailRow(
                                title: "Öffnungszeiten",
                                subtitle: openingDetailHours
                            )
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
                    }
                }
                .padding()
            }

            Spacer()
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    func detailRow(title: String, subtitle: String?, link: Bool = false) -> some View {
        if let subtitle {
            VStack {
                Text(title)
                    .font(AppFonts.bold(.subtitle))
                    .frame(maxWidth: .infinity, alignment: .leading)

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
            .multilineTextAlignment(.leading)
        }
    }
}
