
import SwiftUI
import PlaygroundSupport

public struct ResultsUnderstandingView: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Understanding Your Results")
                        .font(.system(size: 48))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding(.leading, 30)
                .padding(.top, 30)
                
                Spacer()
                
                Text("Your clock is going to be graded on a scale from 0-5. 0 being most likely, 5 being least likely for cognitive dysfunction.")
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 60)
                Button {
                    let camera = CameraView()
                    camera.screenType = true
                    camera.shootPhoto()
                } label: {
                    Label("Start", systemImage: "play.fill")
                        .padding(.vertical, 12)
                        .padding(.horizontal, 100)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .foregroundColor(Color.black)
                        .font(.system(size: 24))
                        .shadow(color: .orange, radius: 15)
                }
                .padding(.bottom, 60)
            }
        }
    }
}

public struct ProblemView: View {
    public init() {}
    public var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    Text("Introduction")
                        .font(.system(size: 48))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)
                    Spacer()
                    Image(systemName: "brain.head.profile")
                        .resizable()
                        .foregroundColor(.orange)
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .padding(.horizontal, 50)
                }
                .padding(.bottom, 100)
                HStack{
                    VStack {
                        Text("This playground will determine if you have dementia through a CoreML-evaluated Clock Drawing Test. The goal is to increase diagnosis rates of this disease, and provide a lightweight tool for millions around the world.")
                            .font(.system(size: 24))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 40)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                        
                        Button {
                            PlaygroundPage.current.setLiveView(InstructionsView())
                        } label: {
                            Text("Next")
                                .padding(.vertical, 12)
                                .padding(.horizontal, 100)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .foregroundColor(Color.black)
                                .font(.system(size: 24))
                                .shadow(color: .orange, radius: 15)
                        }
                    }
                    
                    Image(uiImage: #imageLiteral(resourceName: "scoresampleimages.png"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .padding(.horizontal)
                        .padding(.vertical)
                }
            }
            .padding(.bottom, 80)
        }
    }
}

public struct InstructionsView: View {
    public init() {}
    public var body: some View {
        TabView {
            
            HomeInstructionsView()
            
            OnboardingView(Title: "Step 1", Description: "Get a piece of white paper and a pencil, and draw an analog clock that shows the time \"11:10\" with numbers around the interior of the clock. Use the diagram above as reference.", UIImage: #imageLiteral(resourceName: "20007114_eight.tif"), Button: false, SystemImage: "pencil.and.outline"
            )
            OnboardingView(Title: "Step 2", Description: "Once you finish reading the instructions, a start button will appear on the last page. Click on it to open the camera. Take a photo of your clock, making sure that only the paper you drew the clock on is seen in the camera.", UIImage: #imageLiteral(resourceName: "instructionsCamera.png"), Button: false, SystemImage: "camera")
            OnboardingView(Title: "Step 3", Description: "Once the \"Use Photo\" button is clicked after taking your picture, the ML model will evaluate the score of your clock in less than a second, and your results will seamlessly appear!", UIImage: #imageLiteral(resourceName: "instructionsResults.png"), Button: true, SystemImage: "checklist")
            
            ResultsUnderstandingView()
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

public struct HomeView: View {
    public init() {}
    public var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack {
                    Image(systemName: "brain")
                        .resizable()
                        .foregroundColor(.orange)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 30)
                    Spacer()
                }
                Spacer()
                Text("Welcome to Dementia AI")
                    .font(.system(size: 48))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 10)
                    .multilineTextAlignment(.leading)
                Text("Test to see if you have cognitive dysfunction")
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
                    .padding(30)
                Button {
                    PlaygroundPage.current.setLiveView(ProblemView())
                } label: {
                    Label("Start", systemImage: "play.fill")
                        .padding(.vertical, 12)
                        .padding(.horizontal, 100)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .foregroundColor(Color.black)
                        .font(.system(size: 24))
                }
                .shadow(color: .orange, radius: 15)
                .padding(.bottom, 60)
                
                HStack {
                    Spacer()
                    Image(uiImage: #imageLiteral(resourceName: "9f6efc789a4fbe0f667267674555aa89_CreateML.icns"))
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 30)
                }
            }
        }
    }
}

public struct HomeInstructionsView: View {
    public var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Instructions")
                    .font(.system(size: 48))
                    .padding(.vertical, 10)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                Text("Follow them to get accurate results")
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
                    .padding(.bottom, 30)
                HStack {
                    Image(systemName: "pencil.and.outline")
                        .resizable()
                        .foregroundColor(.orange)
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .padding(.horizontal, 50)
                    Image(systemName: "camera")
                        .resizable()
                        .foregroundColor(.orange)
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .padding(.horizontal, 50)
                    Image(systemName: "checklist")
                        .resizable()
                        .foregroundColor(.orange)
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .padding(.horizontal, 50)
                }
            }
        }
    }
}

public struct OnboardingView: View {
    let title: String
    let description: String
    let uiImage: UIImage
    let button: Bool
    let systemImage: String
    
    public init(Title: String, Description: String, UIImage: UIImage, Button: Bool, SystemImage: String) {
        title = Title
        description = Description
        uiImage = UIImage
        button = Button
        systemImage = SystemImage
    }
    public var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text(title)
                        .font(.system(size: 48))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 30)
                        .multilineTextAlignment(.leading)
                    Spacer(minLength: 0)
                    Image(systemName: systemImage)
                        .resizable()
                        .foregroundColor(.orange)
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .padding(.horizontal, 50)
                }
                .padding(.leading, 60)
                .padding(.top, 20)
                
                if uiImage != UIImage() {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .orange, radius: 15)
                        .padding(.vertical, 5)
                }
                
                Text(description)
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
                    .padding(60)
                
            }
        }
        
        
    }
}

