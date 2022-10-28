import SwiftUI
import Foundation
import PlaygroundSupport

public struct ResultsView: View {
    var label: String
    public init(predictionLabel: String) {
        label = predictionLabel
    }
    
    public var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Results")
                        .font(.system(size: 48))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding(.leading, 30)
                .padding(.top, 30)
                
                Spacer()
                
                Text("Your Score is")
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
                Text(label)
                    .font(.system(size: 112))
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .shadow(color: .orange, radius: 30)
                
                Spacer()
                
                Text("Your clock is graded on a scale from 0-5. 0 being most likely, 5 being least likely for cognitive dysfunction")
                    .font(.system(size: 24))
                    .padding(.bottom, 24)
                    .padding(.horizontal, 24)
                    .foregroundColor(Color.white)
                
                if label == "0" {
                    Text("Your clock is not recognizable at all. It is imperative to receive help from your physician about cognitive dysfunction.")
                        .font(.system(size: 24))
                        .padding(.bottom, 24)
                        .padding(.horizontal, 24)
                        .foregroundColor(Color.white)
                } else if label == "1" {
                    Text("Your clock is severely distorted. It is most likely that you have cognitive dysfunction.")
                        .font(.system(size: 24))
                        .padding(.bottom, 24)
                        .padding(.horizontal, 24)
                        .foregroundColor(Color.white)
                } else if label == "2" {
                    Text("Your clock is moderately distorted. It is somewhat likely that you have cognitive dysfunction.")
                        .font(.system(size: 24))
                        .padding(.bottom, 24)
                        .padding(.horizontal, 24)
                        .foregroundColor(Color.white)
                } else if label == "3" {
                    Text("Your clock is mildly distorted. It it is less likely that you have cognitive dysfunction.")
                        .font(.system(size: 24))
                        .padding(.bottom, 24)
                        .padding(.horizontal, 24)
                        .foregroundColor(Color.white)
                } else if label == "4" {
                    Text("Your clock is reasonably accurate. You have a very low chance of having cognitive dysfunction.")
                        .font(.system(size: 24))
                        .padding(.bottom, 24)
                        .padding(.horizontal, 24)
                        .foregroundColor(Color.white)
                } else if label == "5" {
                    Text("Your clock is accurate. It is almost true that you do not have cognitive dysfunction as of now.")
                        .font(.system(size: 24))
                        .padding(.bottom, 24)
                        .padding(.horizontal, 24)
                        .foregroundColor(Color.white)
                } else {
                    Text("Your clock does not fullfill the requirements stated in the instructions. Please make sure that your paper is white, and that your clock is the only thing in the view of the camera.")
                        .font(.system(size: 24))
                        .padding(.bottom, 24)
                        .padding(.horizontal, 24)
                        .foregroundColor(Color.white)
                }
                Button {
                    PlaygroundPage.current.setLiveView(HomeView())
                } label: {
                    Label("Back to Home", systemImage: "chevron.left")
                        .padding(.vertical, 12)
                        .padding(.horizontal, 100)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .foregroundColor(Color.black)
                        .font(.system(size: 24))
                }
                .padding(.bottom)
            }
        }
    }
}


