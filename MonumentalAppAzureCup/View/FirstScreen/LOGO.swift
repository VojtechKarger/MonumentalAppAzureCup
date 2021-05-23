//
//  LOGO.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 22.05.2021.
//

import SwiftUI

struct LOGO: View {
    
    var body: some View {

            GeometryReader { geo in
                let frame = geo.frame(in: .global)
                
                let height = frame.width / 7
                Image("monumen")
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
//                HStack(alignment: .bottom , spacing: 0){
//                    M()
//                        .fill(Color.azure)
//                        .frame(width: frame.width / 6 ,height: height)
//                    Onumen()
//                        .fill(Color.primary)
//                        .frame(width: frame.width / 7 * 6, height: height, alignment: .center)
//                }
            }.padding()

    }
}


struct M: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.79781*width, y: 0.0034*height))
        path.addCurve(to: CGPoint(x: 0.94682*width, y: 0.09042*height), control1: CGPoint(x: 0.86181*width, y: 0.0034*height), control2: CGPoint(x: 0.91148*width, y: 0.0324*height))
        path.addCurve(to: CGPoint(x: 0.99984*width, y: 0.33491*height), control1: CGPoint(x: 0.98216*width, y: 0.14843*height), control2: CGPoint(x: 0.99984*width, y: 0.22993*height))
        path.addLine(to: CGPoint(x: 0.99984*width, y: height))
        path.addLine(to: CGPoint(x: 0.90384*width, y: height))
        path.addLine(to: CGPoint(x: 0.90384*width, y: 0.35563*height))
        path.addCurve(to: CGPoint(x: 0.86945*width, y: 0.17744*height), control1: CGPoint(x: 0.90384*width, y: 0.27827*height), control2: CGPoint(x: 0.89237*width, y: 0.21888*height))
        path.addCurve(to: CGPoint(x: 0.77201*width, y: 0.11528*height), control1: CGPoint(x: 0.84652*width, y: 0.136*height), control2: CGPoint(x: 0.81404*width, y: 0.11528*height))
        path.addCurve(to: CGPoint(x: 0.64449*width, y: 0.2023*height), control1: CGPoint(x: 0.72425*width, y: 0.11528*height), control2: CGPoint(x: 0.68175*width, y: 0.14429*height))
        path.addCurve(to: CGPoint(x: 0.56999*width, y: 0.43229*height), control1: CGPoint(x: 0.60819*width, y: 0.25894*height), control2: CGPoint(x: 0.58336*width, y: 0.3356*height))
        path.addLine(to: CGPoint(x: 0.56999*width, y: height))
        path.addLine(to: CGPoint(x: 0.47398*width, y: height))
        path.addLine(to: CGPoint(x: 0.47398*width, y: 0.35563*height))
        path.addCurve(to: CGPoint(x: 0.4396*width, y: 0.17744*height), control1: CGPoint(x: 0.47398*width, y: 0.27827*height), control2: CGPoint(x: 0.46252*width, y: 0.21888*height))
        path.addCurve(to: CGPoint(x: 0.3436*width, y: 0.11528*height), control1: CGPoint(x: 0.41762*width, y: 0.136*height), control2: CGPoint(x: 0.38562*width, y: 0.11528*height))
        path.addCurve(to: CGPoint(x: 0.21607*width, y: 0.20437*height), control1: CGPoint(x: 0.29583*width, y: 0.11528*height), control2: CGPoint(x: 0.25333*width, y: 0.14498*height))
        path.addCurve(to: CGPoint(x: 0.14157*width, y: 0.43229*height), control1: CGPoint(x: 0.17882*width, y: 0.26239*height), control2: CGPoint(x: 0.15398*width, y: 0.33836*height))
        path.addLine(to: CGPoint(x: 0.14157*width, y: height))
        path.addLine(to: CGPoint(x: 0.04557*width, y: height))
        path.addLine(to: CGPoint(x: 0.04557*width, y: 0.2023*height))
        path.addCurve(to: CGPoint(x: 0.03554*width, y: 0.14222*height), control1: CGPoint(x: 0.04557*width, y: 0.17744*height), control2: CGPoint(x: 0.04222*width, y: 0.15741*height))
        path.addCurve(to: CGPoint(x: 0.00115*width, y: 0.08627*height), control1: CGPoint(x: 0.0298*width, y: 0.12564*height), control2: CGPoint(x: 0.01834*width, y: 0.10699*height))
        path.addLine(to: CGPoint(x: 0.06419*width, y: 0.0034*height))
        path.addCurve(to: CGPoint(x: 0.12151*width, y: 0.08006*height), control1: CGPoint(x: 0.09094*width, y: 0.02412*height), control2: CGPoint(x: 0.11004*width, y: 0.04967*height))
        path.addCurve(to: CGPoint(x: 0.14013*width, y: 0.19401*height), control1: CGPoint(x: 0.13392*width, y: 0.11045*height), control2: CGPoint(x: 0.14013*width, y: 0.14843*height))
        path.addLine(to: CGPoint(x: 0.14013*width, y: 0.22717*height))
        path.addCurve(to: CGPoint(x: 0.23327*width, y: 0.06141*height), control1: CGPoint(x: 0.16306*width, y: 0.15534*height), control2: CGPoint(x: 0.1941*width, y: 0.10009*height))
        path.addCurve(to: CGPoint(x: 0.36939*width, y: 0.0034*height), control1: CGPoint(x: 0.27339*width, y: 0.02273*height), control2: CGPoint(x: 0.31876*width, y: 0.0034*height))
        path.addCurve(to: CGPoint(x: 0.49978*width, y: 0.06763*height), control1: CGPoint(x: 0.42288*width, y: 0.0034*height), control2: CGPoint(x: 0.46634*width, y: 0.02481*height))
        path.addCurve(to: CGPoint(x: 0.56282*width, y: 0.2541*height), control1: CGPoint(x: 0.53321*width, y: 0.11045*height), control2: CGPoint(x: 0.55422*width, y: 0.1726*height))
        path.addCurve(to: CGPoint(x: 0.65166*width, y: 0.07177*height), control1: CGPoint(x: 0.57906*width, y: 0.17675*height), control2: CGPoint(x: 0.60867*width, y: 0.11597*height))
        path.addCurve(to: CGPoint(x: 0.79781*width, y: 0.0034*height), control1: CGPoint(x: 0.69464*width, y: 0.02619*height), control2: CGPoint(x: 0.74336*width, y: 0.0034*height))
        path.closeSubpath()
        return path
    }
}




struct Onumen: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.08185*width, y: 0.9204*height))
        path.addCurve(to: CGPoint(x: 0.03306*width, y: 0.8388*height), control1: CGPoint(x: 0.06086*width, y: 0.9204*height), control2: CGPoint(x: 0.0446*width, y: 0.8932*height))
        path.addCurve(to: CGPoint(x: 0.01574*width, y: 0.6076*height), control1: CGPoint(x: 0.02151*width, y: 0.7844*height), control2: CGPoint(x: 0.01574*width, y: 0.70733*height))
        path.addLine(to: CGPoint(x: 0.01574*width, y: 0.3934*height))
        path.addCurve(to: CGPoint(x: 0.03306*width, y: 0.1622*height), control1: CGPoint(x: 0.01574*width, y: 0.29367*height), control2: CGPoint(x: 0.02151*width, y: 0.2166*height))
        path.addCurve(to: CGPoint(x: 0.08185*width, y: 0.0806*height), control1: CGPoint(x: 0.0446*width, y: 0.1078*height), control2: CGPoint(x: 0.06086*width, y: 0.0806*height))
        path.addCurve(to: CGPoint(x: 0.13096*width, y: 0.1622*height), control1: CGPoint(x: 0.10305*width, y: 0.0806*height), control2: CGPoint(x: 0.11942*width, y: 0.1078*height))
        path.addCurve(to: CGPoint(x: 0.14828*width, y: 0.3934*height), control1: CGPoint(x: 0.14251*width, y: 0.2166*height), control2: CGPoint(x: 0.14828*width, y: 0.29367*height))
        path.addLine(to: CGPoint(x: 0.14828*width, y: 0.6076*height))
        path.addCurve(to: CGPoint(x: 0.13096*width, y: 0.8388*height), control1: CGPoint(x: 0.14828*width, y: 0.70733*height), control2: CGPoint(x: 0.14251*width, y: 0.7844*height))
        path.addCurve(to: CGPoint(x: 0.08185*width, y: 0.9204*height), control1: CGPoint(x: 0.11942*width, y: 0.8932*height), control2: CGPoint(x: 0.10305*width, y: 0.9204*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.08185*width, y: 0.7759*height))
        path.addCurve(to: CGPoint(x: 0.10546*width, y: 0.7334*height), control1: CGPoint(x: 0.09214*width, y: 0.7759*height), control2: CGPoint(x: 0.10001*width, y: 0.76173*height))
        path.addCurve(to: CGPoint(x: 0.11396*width, y: 0.6076*height), control1: CGPoint(x: 0.11113*width, y: 0.70393*height), control2: CGPoint(x: 0.11396*width, y: 0.662*height))
        path.addLine(to: CGPoint(x: 0.11396*width, y: 0.3934*height))
        path.addCurve(to: CGPoint(x: 0.10546*width, y: 0.2693*height), control1: CGPoint(x: 0.11396*width, y: 0.339*height), control2: CGPoint(x: 0.11113*width, y: 0.29763*height))
        path.addCurve(to: CGPoint(x: 0.08185*width, y: 0.2251*height), control1: CGPoint(x: 0.10001*width, y: 0.23983*height), control2: CGPoint(x: 0.09214*width, y: 0.2251*height))
        path.addCurve(to: CGPoint(x: 0.05824*width, y: 0.2693*height), control1: CGPoint(x: 0.07178*width, y: 0.2251*height), control2: CGPoint(x: 0.06391*width, y: 0.23983*height))
        path.addCurve(to: CGPoint(x: 0.05006*width, y: 0.3934*height), control1: CGPoint(x: 0.05278*width, y: 0.29763*height), control2: CGPoint(x: 0.05006*width, y: 0.339*height))
        path.addLine(to: CGPoint(x: 0.05006*width, y: 0.6076*height))
        path.addCurve(to: CGPoint(x: 0.05824*width, y: 0.7334*height), control1: CGPoint(x: 0.05006*width, y: 0.662*height), control2: CGPoint(x: 0.05278*width, y: 0.70393*height))
        path.addCurve(to: CGPoint(x: 0.08185*width, y: 0.7759*height), control1: CGPoint(x: 0.06391*width, y: 0.76173*height), control2: CGPoint(x: 0.07178*width, y: 0.7759*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.26652*width, y: 0.0806*height))
        path.addCurve(to: CGPoint(x: 0.30304*width, y: 0.1537*height), control1: CGPoint(x: 0.28247*width, y: 0.0806*height), control2: CGPoint(x: 0.29465*width, y: 0.10497*height))
        path.addCurve(to: CGPoint(x: 0.31595*width, y: 0.356*height), control1: CGPoint(x: 0.31165*width, y: 0.2013*height), control2: CGPoint(x: 0.31595*width, y: 0.26873*height))
        path.addLine(to: CGPoint(x: 0.31595*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.28163*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.28163*width, y: 0.3747*height))
        path.addCurve(to: CGPoint(x: 0.27502*width, y: 0.2659*height), control1: CGPoint(x: 0.28163*width, y: 0.32823*height), control2: CGPoint(x: 0.27943*width, y: 0.29197*height))
        path.addCurve(to: CGPoint(x: 0.25708*width, y: 0.2251*height), control1: CGPoint(x: 0.27083*width, y: 0.2387*height), control2: CGPoint(x: 0.26484*width, y: 0.2251*height))
        path.addCurve(to: CGPoint(x: 0.23473*width, y: 0.2727*height), control1: CGPoint(x: 0.24805*width, y: 0.2251*height), control2: CGPoint(x: 0.2406*width, y: 0.24097*height))
        path.addCurve(to: CGPoint(x: 0.22119*width, y: 0.3951*height), control1: CGPoint(x: 0.22885*width, y: 0.3033*height), control2: CGPoint(x: 0.22434*width, y: 0.3441*height))
        path.addLine(to: CGPoint(x: 0.22119*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.18687*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.18687*width, y: 0.3135*height))
        path.addCurve(to: CGPoint(x: 0.18404*width, y: 0.2472*height), control1: CGPoint(x: 0.18687*width, y: 0.2863*height), control2: CGPoint(x: 0.18593*width, y: 0.2642*height))
        path.addCurve(to: CGPoint(x: 0.17365*width, y: 0.1894*height), control1: CGPoint(x: 0.18215*width, y: 0.2302*height), control2: CGPoint(x: 0.17869*width, y: 0.21093*height))
        path.addLine(to: CGPoint(x: 0.19663*width, y: 0.0806*height))
        path.addCurve(to: CGPoint(x: 0.21206*width, y: 0.1435*height), control1: CGPoint(x: 0.20335*width, y: 0.09987*height), control2: CGPoint(x: 0.20849*width, y: 0.12083*height))
        path.addCurve(to: CGPoint(x: 0.21961*width, y: 0.2217*height), control1: CGPoint(x: 0.21563*width, y: 0.16503*height), control2: CGPoint(x: 0.21815*width, y: 0.1911*height))
        path.addCurve(to: CGPoint(x: 0.23819*width, y: 0.1197*height), control1: CGPoint(x: 0.22402*width, y: 0.17863*height), control2: CGPoint(x: 0.23021*width, y: 0.14463*height))
        path.addCurve(to: CGPoint(x: 0.26652*width, y: 0.0806*height), control1: CGPoint(x: 0.24616*width, y: 0.09363*height), control2: CGPoint(x: 0.25561*width, y: 0.0806*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.48745*width, y: 0.6858*height))
        path.addCurve(to: CGPoint(x: 0.49028*width, y: 0.7538*height), control1: CGPoint(x: 0.48745*width, y: 0.713*height), control2: CGPoint(x: 0.48839*width, y: 0.73567*height))
        path.addCurve(to: CGPoint(x: 0.50098*width, y: 0.8099*height), control1: CGPoint(x: 0.49217*width, y: 0.7708*height), control2: CGPoint(x: 0.49574*width, y: 0.7895*height))
        path.addLine(to: CGPoint(x: 0.478*width, y: 0.917*height))
        path.addCurve(to: CGPoint(x: 0.46226*width, y: 0.8558*height), control1: CGPoint(x: 0.47108*width, y: 0.89773*height), control2: CGPoint(x: 0.46583*width, y: 0.87733*height))
        path.addCurve(to: CGPoint(x: 0.45471*width, y: 0.7742*height), control1: CGPoint(x: 0.45869*width, y: 0.83313*height), control2: CGPoint(x: 0.45617*width, y: 0.80593*height))
        path.addCurve(to: CGPoint(x: 0.43582*width, y: 0.8813*height), control1: CGPoint(x: 0.44988*width, y: 0.81953*height), control2: CGPoint(x: 0.44358*width, y: 0.85523*height))
        path.addCurve(to: CGPoint(x: 0.40748*width, y: 0.9204*height), control1: CGPoint(x: 0.42805*width, y: 0.90737*height), control2: CGPoint(x: 0.41861*width, y: 0.9204*height))
        path.addCurve(to: CGPoint(x: 0.37002*width, y: 0.849*height), control1: CGPoint(x: 0.39132*width, y: 0.9204*height), control2: CGPoint(x: 0.37884*width, y: 0.8966*height))
        path.addCurve(to: CGPoint(x: 0.3568*width, y: 0.6416*height), control1: CGPoint(x: 0.36121*width, y: 0.80027*height), control2: CGPoint(x: 0.3568*width, y: 0.73113*height))
        path.addLine(to: CGPoint(x: 0.3568*width, y: 0.101*height))
        path.addLine(to: CGPoint(x: 0.39111*width, y: 0.101*height))
        path.addLine(to: CGPoint(x: 0.39111*width, y: 0.6263*height))
        path.addCurve(to: CGPoint(x: 0.39804*width, y: 0.7368*height), control1: CGPoint(x: 0.39111*width, y: 0.67277*height), control2: CGPoint(x: 0.39342*width, y: 0.7096*height))
        path.addCurve(to: CGPoint(x: 0.41756*width, y: 0.7759*height), control1: CGPoint(x: 0.40266*width, y: 0.76287*height), control2: CGPoint(x: 0.40916*width, y: 0.7759*height))
        path.addCurve(to: CGPoint(x: 0.43959*width, y: 0.7266*height), control1: CGPoint(x: 0.42637*width, y: 0.7759*height), control2: CGPoint(x: 0.43372*width, y: 0.75947*height))
        path.addCurve(to: CGPoint(x: 0.45313*width, y: 0.5957*height), control1: CGPoint(x: 0.44547*width, y: 0.69373*height), control2: CGPoint(x: 0.44998*width, y: 0.6501*height))
        path.addLine(to: CGPoint(x: 0.45313*width, y: 0.101*height))
        path.addLine(to: CGPoint(x: 0.48745*width, y: 0.101*height))
        path.addLine(to: CGPoint(x: 0.48745*width, y: 0.6858*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.61423*width, y: 0.0806*height))
        path.addCurve(to: CGPoint(x: 0.65075*width, y: 0.1537*height), control1: CGPoint(x: 0.63018*width, y: 0.0806*height), control2: CGPoint(x: 0.64236*width, y: 0.10497*height))
        path.addCurve(to: CGPoint(x: 0.66366*width, y: 0.356*height), control1: CGPoint(x: 0.65936*width, y: 0.2013*height), control2: CGPoint(x: 0.66366*width, y: 0.26873*height))
        path.addLine(to: CGPoint(x: 0.66366*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.62934*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.62934*width, y: 0.3747*height))
        path.addCurve(to: CGPoint(x: 0.62273*width, y: 0.2659*height), control1: CGPoint(x: 0.62934*width, y: 0.32823*height), control2: CGPoint(x: 0.62714*width, y: 0.29197*height))
        path.addCurve(to: CGPoint(x: 0.60479*width, y: 0.2251*height), control1: CGPoint(x: 0.61854*width, y: 0.2387*height), control2: CGPoint(x: 0.61255*width, y: 0.2251*height))
        path.addCurve(to: CGPoint(x: 0.58244*width, y: 0.2727*height), control1: CGPoint(x: 0.59576*width, y: 0.2251*height), control2: CGPoint(x: 0.58831*width, y: 0.24097*height))
        path.addCurve(to: CGPoint(x: 0.5689*width, y: 0.3951*height), control1: CGPoint(x: 0.57656*width, y: 0.3033*height), control2: CGPoint(x: 0.57205*width, y: 0.3441*height))
        path.addLine(to: CGPoint(x: 0.5689*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.53459*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.53459*width, y: 0.3135*height))
        path.addCurve(to: CGPoint(x: 0.53175*width, y: 0.2472*height), control1: CGPoint(x: 0.53459*width, y: 0.2863*height), control2: CGPoint(x: 0.53364*width, y: 0.2642*height))
        path.addCurve(to: CGPoint(x: 0.52136*width, y: 0.1894*height), control1: CGPoint(x: 0.52986*width, y: 0.2302*height), control2: CGPoint(x: 0.5264*width, y: 0.21093*height))
        path.addLine(to: CGPoint(x: 0.54434*width, y: 0.0806*height))
        path.addCurve(to: CGPoint(x: 0.55977*width, y: 0.1435*height), control1: CGPoint(x: 0.55106*width, y: 0.09987*height), control2: CGPoint(x: 0.5562*width, y: 0.12083*height))
        path.addCurve(to: CGPoint(x: 0.56733*width, y: 0.2217*height), control1: CGPoint(x: 0.56334*width, y: 0.16503*height), control2: CGPoint(x: 0.56586*width, y: 0.1911*height))
        path.addCurve(to: CGPoint(x: 0.5859*width, y: 0.1197*height), control1: CGPoint(x: 0.57173*width, y: 0.17863*height), control2: CGPoint(x: 0.57792*width, y: 0.14463*height))
        path.addCurve(to: CGPoint(x: 0.61423*width, y: 0.0806*height), control1: CGPoint(x: 0.59388*width, y: 0.09363*height), control2: CGPoint(x: 0.60332*width, y: 0.0806*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.76716*width, y: 0.7776*height))
        path.addCurve(to: CGPoint(x: 0.78762*width, y: 0.7606*height), control1: CGPoint(x: 0.77534*width, y: 0.7776*height), control2: CGPoint(x: 0.78216*width, y: 0.77193*height))
        path.addCurve(to: CGPoint(x: 0.80462*width, y: 0.6977*height), control1: CGPoint(x: 0.79329*width, y: 0.74813*height), control2: CGPoint(x: 0.79895*width, y: 0.72717*height))
        path.addLine(to: CGPoint(x: 0.82508*width, y: 0.7997*height))
        path.addCurve(to: CGPoint(x: 0.80147*width, y: 0.8898*height), control1: CGPoint(x: 0.81879*width, y: 0.83937*height), control2: CGPoint(x: 0.81092*width, y: 0.8694*height))
        path.addCurve(to: CGPoint(x: 0.76653*width, y: 0.9204*height), control1: CGPoint(x: 0.79203*width, y: 0.9102*height), control2: CGPoint(x: 0.78038*width, y: 0.9204*height))
        path.addCurve(to: CGPoint(x: 0.71616*width, y: 0.8456*height), control1: CGPoint(x: 0.74386*width, y: 0.9204*height), control2: CGPoint(x: 0.72707*width, y: 0.89547*height))
        path.addCurve(to: CGPoint(x: 0.69979*width, y: 0.6127*height), control1: CGPoint(x: 0.70524*width, y: 0.7946*height), control2: CGPoint(x: 0.69979*width, y: 0.71697*height))
        path.addLine(to: CGPoint(x: 0.69979*width, y: 0.3645*height))
        path.addCurve(to: CGPoint(x: 0.71679*width, y: 0.1588*height), control1: CGPoint(x: 0.69979*width, y: 0.27723*height), control2: CGPoint(x: 0.70545*width, y: 0.20867*height))
        path.addCurve(to: CGPoint(x: 0.76401*width, y: 0.0823*height), control1: CGPoint(x: 0.72833*width, y: 0.1078*height), control2: CGPoint(x: 0.74407*width, y: 0.0823*height))
        path.addCurve(to: CGPoint(x: 0.81155*width, y: 0.1639*height), control1: CGPoint(x: 0.78437*width, y: 0.0823*height), control2: CGPoint(x: 0.80021*width, y: 0.1095*height))
        path.addCurve(to: CGPoint(x: 0.82855*width, y: 0.3951*height), control1: CGPoint(x: 0.82288*width, y: 0.21717*height), control2: CGPoint(x: 0.82855*width, y: 0.29423*height))
        path.addCurve(to: CGPoint(x: 0.82603*width, y: 0.5039*height), control1: CGPoint(x: 0.82855*width, y: 0.44157*height), control2: CGPoint(x: 0.82771*width, y: 0.47783*height))
        path.addCurve(to: CGPoint(x: 0.8169*width, y: 0.5617*height), control1: CGPoint(x: 0.82435*width, y: 0.52997*height), control2: CGPoint(x: 0.82131*width, y: 0.54923*height))
        path.addCurve(to: CGPoint(x: 0.79738*width, y: 0.5787*height), control1: CGPoint(x: 0.81249*width, y: 0.57303*height), control2: CGPoint(x: 0.80598*width, y: 0.5787*height))
        path.addLine(to: CGPoint(x: 0.73379*width, y: 0.5787*height))
        path.addLine(to: CGPoint(x: 0.73379*width, y: 0.6127*height))
        path.addCurve(to: CGPoint(x: 0.76716*width, y: 0.7776*height), control1: CGPoint(x: 0.73379*width, y: 0.72263*height), control2: CGPoint(x: 0.74491*width, y: 0.7776*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.76369*width, y: 0.2234*height))
        path.addCurve(to: CGPoint(x: 0.74166*width, y: 0.2659*height), control1: CGPoint(x: 0.75446*width, y: 0.2234*height), control2: CGPoint(x: 0.74711*width, y: 0.23757*height))
        path.addCurve(to: CGPoint(x: 0.73379*width, y: 0.3781*height), control1: CGPoint(x: 0.73641*width, y: 0.29423*height), control2: CGPoint(x: 0.73379*width, y: 0.33163*height))
        path.addLine(to: CGPoint(x: 0.73379*width, y: 0.4512*height))
        path.addLine(to: CGPoint(x: 0.77881*width, y: 0.4512*height))
        path.addCurve(to: CGPoint(x: 0.79108*width, y: 0.4359*height), control1: CGPoint(x: 0.78468*width, y: 0.4512*height), control2: CGPoint(x: 0.78877*width, y: 0.4461*height))
        path.addCurve(to: CGPoint(x: 0.79455*width, y: 0.3781*height), control1: CGPoint(x: 0.79339*width, y: 0.42457*height), control2: CGPoint(x: 0.79455*width, y: 0.4053*height))
        path.addCurve(to: CGPoint(x: 0.78636*width, y: 0.2642*height), control1: CGPoint(x: 0.79455*width, y: 0.32823*height), control2: CGPoint(x: 0.79182*width, y: 0.29027*height))
        path.addCurve(to: CGPoint(x: 0.76369*width, y: 0.2234*height), control1: CGPoint(x: 0.78111*width, y: 0.237*height), control2: CGPoint(x: 0.77356*width, y: 0.2234*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.94196*width, y: 0.0806*height))
        path.addCurve(to: CGPoint(x: 0.97848*width, y: 0.1537*height), control1: CGPoint(x: 0.95791*width, y: 0.0806*height), control2: CGPoint(x: 0.97008*width, y: 0.10497*height))
        path.addCurve(to: CGPoint(x: 0.99139*width, y: 0.356*height), control1: CGPoint(x: 0.98708*width, y: 0.2013*height), control2: CGPoint(x: 0.99139*width, y: 0.26873*height))
        path.addLine(to: CGPoint(x: 0.99139*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.95707*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.95707*width, y: 0.3747*height))
        path.addCurve(to: CGPoint(x: 0.95046*width, y: 0.2659*height), control1: CGPoint(x: 0.95707*width, y: 0.32823*height), control2: CGPoint(x: 0.95487*width, y: 0.29197*height))
        path.addCurve(to: CGPoint(x: 0.93252*width, y: 0.2251*height), control1: CGPoint(x: 0.94626*width, y: 0.2387*height), control2: CGPoint(x: 0.94028*width, y: 0.2251*height))
        path.addCurve(to: CGPoint(x: 0.91016*width, y: 0.2727*height), control1: CGPoint(x: 0.92349*width, y: 0.2251*height), control2: CGPoint(x: 0.91604*width, y: 0.24097*height))
        path.addCurve(to: CGPoint(x: 0.89663*width, y: 0.3951*height), control1: CGPoint(x: 0.90429*width, y: 0.3033*height), control2: CGPoint(x: 0.89978*width, y: 0.3441*height))
        path.addLine(to: CGPoint(x: 0.89663*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.86231*width, y: 0.9*height))
        path.addLine(to: CGPoint(x: 0.86231*width, y: 0.3135*height))
        path.addCurve(to: CGPoint(x: 0.85948*width, y: 0.2472*height), control1: CGPoint(x: 0.86231*width, y: 0.2863*height), control2: CGPoint(x: 0.86137*width, y: 0.2642*height))
        path.addCurve(to: CGPoint(x: 0.84909*width, y: 0.1894*height), control1: CGPoint(x: 0.85759*width, y: 0.2302*height), control2: CGPoint(x: 0.85413*width, y: 0.21093*height))
        path.addLine(to: CGPoint(x: 0.87207*width, y: 0.0806*height))
        path.addCurve(to: CGPoint(x: 0.8875*width, y: 0.1435*height), control1: CGPoint(x: 0.87879*width, y: 0.09987*height), control2: CGPoint(x: 0.88393*width, y: 0.12083*height))
        path.addCurve(to: CGPoint(x: 0.89505*width, y: 0.2217*height), control1: CGPoint(x: 0.89106*width, y: 0.16503*height), control2: CGPoint(x: 0.89358*width, y: 0.1911*height))
        path.addCurve(to: CGPoint(x: 0.91363*width, y: 0.1197*height), control1: CGPoint(x: 0.89946*width, y: 0.17863*height), control2: CGPoint(x: 0.90565*width, y: 0.14463*height))
        path.addCurve(to: CGPoint(x: 0.94196*width, y: 0.0806*height), control1: CGPoint(x: 0.9216*width, y: 0.09363*height), control2: CGPoint(x: 0.93105*width, y: 0.0806*height))
        path.closeSubpath()
        return path
    }
}


struct LOGO_Previews: PreviewProvider {
    static var previews: some View {
        LOGO()
    }
}
