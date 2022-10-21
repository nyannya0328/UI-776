//
//  IntoroView.swift
//  UI-776
//
//  Created by nyannyan0328 on 2022/10/21.
//

import SwiftUI

struct IntoroView: View {
    @State var showView : Bool = false
      @Namespace var animation
    
    @State var showWorkThrought : Bool = false
    @State var currentIndex : Int = 0
    var body: some View {
        ZStack{
            
            if showView{
                
                sampleHome()
                    .transition(.move(edge: .top))
            }
            else{
                
                ZStack{
                    Color("BG").ignoresSafeArea()
                    
                    IntroScreen()
                    
                    ShowWorkScreen()
                    
                    NavBar()
                }
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: showWorkThrought)
            }
            
        }
        .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value:showView)
    }
    @ViewBuilder
    func customIndicator ()->some View{
        
        HStack(spacing: 10) {
            
            ForEach(intros.indices ,id:\.self){index in
                
                Circle()
                     .frame(width: 20,height: 20)
                     .foregroundColor(.gray.opacity(0.3))
                     .overlay {
                         
                         if currentIndex == index{
                             
                             Circle()
                                 .fill(Color("Blue"))
                                  .frame(width: 20,height: 20)
                                  .matchedGeometryEffect(id: "INDICATOR", in: animation)
                             
                         }
                     }
            }
        }
        .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: currentIndex)
        
    }
    @ViewBuilder
    func ShowWorkScreen ()->some View{
        
        let isLast = currentIndex == intros.count
     
        GeometryReader{
            
            let size = $0.size
            
            
            ZStack{
                
                
                ForEach(intros.indices.indices ,id:\.self){index in
                    
                    ScreenView(index: index, size: size)
                }
                WelocmView(index: intros.count, size: size)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                
                ZStack{
                    Image(systemName: "chevron.right")
                        .font(.title3.weight(.semibold))
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    
                    HStack{
                        
                        Text("Sign up")
                            .font(.custom(sansBold, size: 15))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        
                         Image(systemName: "arrow.right")
                            .font(.custom(sansRegular, size: 15))
                    
                        
                        
                    }
                    .padding(.horizontal)
                   
                    .scaleEffect(isLast ? 1 : 0.001)
                    .opacity(isLast ? 1 : 0)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                    
                    
                }
                .frame(width: isLast ? size.width / 1.5 : 55,height: isLast ? 50 : 55)
                    .foregroundColor(.white)
                 
                    .background{
                     
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("Blue"))
                    }
                    .onTapGesture {
                        if currentIndex == intros.count{
                            
                            showView = true
                        }
                        else{
                            
                            currentIndex += 1
                        }
                        
                    }
                    .offset(y:-100)
                    .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85), value: isLast)
                    
            }
          
           
            .overlay(alignment:.bottom) {
                
                customIndicator()
                    .opacity(isLast ? 0 : 1)
                    .offset(y:-180)
                
            }
            .overlay(alignment:.bottom) {
                
                HStack(spacing: 5) {
                    Text("Already have an account")
                        .font(.custom(sansRegular, size: 20))
                        .foregroundColor(.gray)
                    
                    Button("Login"){
                        
                        
                    }
                    .font(.custom(sansRegular, size: 20))
                    .foregroundColor(.cyan)
                }
                .offset(y:isLast ? 12 : 120)
                
            }
        
           
            .offset(y:showWorkThrought ? 0 : size.height)
            
            
            
        }
        
        
        
    }
    @ViewBuilder
    func ScreenView(index : Int,size : CGSize)->some View{
        
        
        let intro = intros[index]
        
        VStack(spacing: 10) {
            
            Text(intro.title)
                .font(.custom(sansBold, size: 25))
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(dummyText)
                .font(.custom(sansRegular, size: 15))
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                .padding(.horizontal,10)
                .multilineTextAlignment(.center)
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.3 : 0), value: currentIndex)
                
            
        }
        
        
        
    }
    
    @ViewBuilder
    func WelocmView(index : Int,size : CGSize)->some View{
        
        
       
        
        VStack(spacing: 10) {
            
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.3 : 0), value: currentIndex)
                
            
            Text("welcome")
                .font(.custom(sansBold, size: 25))
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Text(dummyText)
                .font(.custom(sansRegular, size: 15))
                .offset(x:-size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 1.1,dampingFraction: 0.85,blendDuration: 0.85).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                .padding(.horizontal,10)
                .multilineTextAlignment(.center)
            
          
            
        }
        
        
        
    }
    @ViewBuilder
    func NavBar ()->some View{
        
        let isLast = currentIndex == intros.count
        
        
        HStack{
            
            Button {
                
                if currentIndex > 0{
                    
                    currentIndex -= 1
                }
                else{
                    
                    showWorkThrought.toggle()
                }
                
            } label: {
                
             
                Image(systemName: "chevron.left")
                    .font(.title2.bold())
                    .foregroundColor(Color("Blue"))
            }
            
            
            Spacer()
            
            Button("Skip"){
                
                
            }
            .foregroundColor(Color("Blue"))
            .opacity(isLast ? 0 : 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
       .offset(y:showWorkThrought ? 0 : -120)
       
        .padding(.horizontal)
        
        
    }
    @ViewBuilder
    func IntroScreen()->some View{
        GeometryReader{
            
            let size = $0.size
         
            VStack(spacing: 15) {
                
                Image("Intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width,height: size.height / 2)
                
                Text("Clear Head")
                    .font(.custom(sansRegular, size: 20))
                    .foregroundColor(.black)
                
                Text(dummyText)
                    .font(.custom(sansSemiBold, size: 15))
                    .padding(.horizontal,15)
                    .multilineTextAlignment(.center)
                    .padding(.top,10)
                
                
                Text("Let's Beigin")
                    .font(.custom(sansSemiBold, size: 25))
                    .padding(.vertical)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background{
                     
                        Capsule()
                            .fill(Color("Blue").gradient)
                        
                    }
                    .onTapGesture {
                        showWorkThrought.toggle()
                        
                    }
            }
            .offset(y:showWorkThrought ? -size.height : 0)
        }
        .ignoresSafeArea()
        
    }
}

struct IntoroView_Previews: PreviewProvider {
    static var previews: some View {
        IntoroView()
    }
}
struct sampleHome : View{
    
    var body: some View{
        NavigationStack{
            
            Text("Home")
                .navigationTitle("Home")
        }
    }
}
