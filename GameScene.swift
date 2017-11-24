//
//  GameScene.swift
//  C4
//
//  Created by William Liu on 11/5/17.
//  Copyright © 2017 Spark! LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var bg = SKSpriteNode()
    var std = SKShapeNode()
    var spc = SKShapeNode()
    var lbl1 = SKLabelNode()
    var lbl2 = SKLabelNode()
    var lbl3 = SKLabelNode()
    var PvP = SKShapeNode()
    var PvC = SKShapeNode()
    var diameter = CGFloat(0)
    var arrPos = [[CGPoint]]()
    var plays = [[Int]]()
    var tempP = [[Int]]()
    var orderList = [Int]()
    var mask = [[Int]]()
    var positionB = [[Int]]()
    var bottom = [[Int]]()
    var key = [[Int]]()
    var sizes = CGFloat()
    var currentPlay = 1
    var label = SKLabelNode()
    var gameMode = 0
    var turnText = "Red's turn"
    var flag = false //game win check
    var flag2 = true //which home screen
    var flag3 = false //which home screen
    var flag4 = true //allows select
    var gameString = ""
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        for i in 0...6{
            orderList.append(7/2 + (1-2*(i%2))*(i+1)/2)
            
        }
        createScene()
    }
    func createScene(){
        std = SKShapeNode(rect: CGRect(x: -self.size.width/6, y: -self.size.height/8, width: self.size.width/3, height: self.size.height/8), cornerRadius: 10.0)
        std.fillColor = UIColor.blue
        spc = SKShapeNode(rect: CGRect(x: -self.size.width/6, y: -3 * self.size.height/8, width: self.size.width/3, height: self.size.height/8), cornerRadius: 10.0)
        lbl1 = SKLabelNode()
        lbl1.text = "Standard Mode"
        lbl1.fontName = "Baskerville"
        lbl1.fontSize = 24
        lbl3 = SKLabelNode()
        lbl3.text = "Select Mode:"
        lbl3.fontName = "Baskerville"
        lbl3.position = CGPoint(x: 0, y: 3*self.size.height/16)
        lbl3.fontSize = 64
        lbl3.fontColor = UIColor.black
        lbl2 = SKLabelNode()
        lbl2.text = "Special Mode"
        lbl2.fontName = "Baskerville"
        lbl2.fontSize = 24
        lbl1.position = CGPoint(x: 0, y: -3*self.size.height/32)
        lbl2.position = CGPoint(x: 0, y: -11*self.size.height/32)
        spc.fillColor = UIColor.blue
        self.addChild(std)
        self.addChild(spc)
        self.addChild(lbl1)
        self.addChild(lbl2)
        self.addChild(lbl3)
        flag2 = true
        flag3 = false
    }
    func createScene2(){
        lbl1.text = "Player vs Player"
        lbl2.text = "Player vs AI"
        lbl3.text = "Select Opponent:"
    }
    func fillBoard(){
        gameString = ""
        bg = SKSpriteNode(imageNamed: "backboard")
        bg.size = CGSize(width: self.size.width, height: 27*self.size.height/32)
        bg.position = CGPoint(x: 0, y: -5 * self.size.height/64)
        flag4 = true
        label.position = CGPoint(x:0, y:25*self.size.height/64)
        self.addChild(label)
        self.addChild(bg)
        
        let string2 = "Red's"
        turnText = "Red's turn"
        let range = (turnText as NSString).range(of: string2)
        let range2 = (turnText as NSString).range(of: turnText)
        let attributedText = NSMutableAttributedString.init(string: turnText)
        attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
        attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
        label.attributedText = attributedText
        arrPos = [[CGPoint]]()
        plays = [[Int]]()
        currentPlay = 1
        sizes = 1/7 * (self.size.width-1124/2436*self.size.width)
        if(1/6*bg.size.height <= sizes){
            sizes = 1/6*bg.size.height
        }
        diameter = sizes * 0.8
        let offset = sizes - diameter
        var xPos = -self.size.width/2 + (561/2436 * self.size.width + offset/2) + diameter/2
        var yPos = self.size.height/2 - offset/2 - diameter/2
        for _ in 0...6{
            var arrayPos = [CGPoint]()
            var negPos = [Int]()
            yPos = -self.size.height/2 + offset/2 + diameter/2
            for _ in 0...5{
                arrayPos.append(CGPoint(x: xPos, y: yPos))
                negPos.append(-1)
                circle(x: xPos, y: yPos)
                yPos = yPos + offset + diameter
            }
            xPos = xPos + offset + diameter
            arrPos.append(arrayPos)
            plays.append(negPos)
            
        }
        flag = true
 
    }
    func circle(x: CGFloat, y: CGFloat){
        let circleBG = SKShapeNode(circleOfRadius: diameter/2)
        circleBG.glowWidth = 1.0
        circleBG.fillColor = UIColor.white
        circleBG.position = CGPoint(x: x, y: y)
        circleBG.zPosition = 2
        self.addChild(circleBG)

    }
    func touchDown(atPoint pos : CGPoint) {
        if (flag2){
            if(spc.contains(pos)){
                gameMode = 1
                createScene2()
                flag2 = false
                flag3 = true
            }
            if(std.contains(pos)){
                gameMode = -1
                createScene2()
                flag2 = false
                flag3 = true
            }
        }
        else if(flag3){
            if(spc.contains(pos)){
                gameMode = gameMode + 3
                self.removeAllChildren()
                fillBoard()
                flag3 = false
            }
            if(std.contains(pos)){
                gameMode = gameMode + 2
                self.removeAllChildren()
                fillBoard()
                flag3 = false
            }
        }
        else{
            if (flag){
                if(gameMode==1){
                    if (pos.x > (arrPos[0][0].x-diameter/2) && pos.x < (arrPos[0][0].x+diameter/2)){
                        play(x:0)
                    }
                    if (pos.x > (arrPos[1][0].x-diameter/2) && pos.x < (arrPos[1][0].x+diameter/2)){
                        play(x:1)
                    }
                    if (pos.x > (arrPos[2][0].x-diameter/2) && pos.x < (arrPos[2][0].x+diameter/2)){
                        play(x:2)
                    }
                    if (pos.x > (arrPos[3][0].x-diameter/2) && pos.x < (arrPos[3][0].x+diameter/2)){
                        play(x:3)
                    }
                    if (pos.x > (arrPos[4][0].x-diameter/2) && pos.x < (arrPos[4][0].x+diameter/2)){
                        play(x:4)
                    }
                    if (pos.x > (arrPos[5][0].x-diameter/2) && pos.x < (arrPos[5][0].x+diameter/2)){
                        play(x:5)
                    }
                    if (pos.x > (arrPos[6][0].x-diameter/2) && pos.x < (arrPos[6][0].x+diameter/2)){
                        play(x:6)
                    }
                }
                if(gameMode==2 && flag4){
                    if (pos.x > (arrPos[0][0].x-diameter/2) && pos.x < (arrPos[0][0].x+diameter/2)){
                        if(canPlay(i: 0, arr: plays)){
                        play(x:0)
                        if(flag){
                            auto1(x:0, tempA: plays, numP: gameString.count)
                        }
                        }
                    }
                    if (pos.x > (arrPos[1][0].x-diameter/2) && pos.x < (arrPos[1][0].x+diameter/2)){
                        if(canPlay(i: 1, arr: plays)){
                        play(x:1)
                        if(flag){
                            auto1(x:1, tempA: plays, numP: gameString.count)
                        }
                        }
                    }
                    if (pos.x > (arrPos[2][0].x-diameter/2) && pos.x < (arrPos[2][0].x+diameter/2)){
                        if(canPlay(i: 2, arr: plays)){
                        play(x:2)
                        if(flag){
                            auto1(x:2, tempA: plays, numP: gameString.count)
                        }
                        }
                    }
                    if (pos.x > (arrPos[3][0].x-diameter/2) && pos.x < (arrPos[3][0].x+diameter/2)){
                        if(canPlay(i: 3, arr: plays)){
                        play(x:3)
                        if(flag){
                            auto1(x:3, tempA: plays, numP: gameString.count)
                        }
                        }
                    }
                    if (pos.x > (arrPos[4][0].x-diameter/2) && pos.x < (arrPos[4][0].x+diameter/2)){
                        if(canPlay(i: 4, arr: plays)){
                        play(x:4)
                        if(flag){
                            auto1(x:4, tempA: plays, numP: gameString.count)
                        }
                        }
                    }
                    if (pos.x > (arrPos[5][0].x-diameter/2) && pos.x < (arrPos[5][0].x+diameter/2)){
                        if(canPlay(i: 5, arr: plays)){
                        play(x:5)
                        if(flag){
                            auto1(x:5, tempA: plays, numP: gameString.count)
                        }
                        }
                    }
                    if (pos.x > (arrPos[6][0].x-diameter/2) && pos.x < (arrPos[6][0].x+diameter/2)){
                        if(canPlay(i: 6, arr: plays)){
                        play(x:6)
                        if(flag){
                            auto1(x:6, tempA: plays, numP: gameString.count)
                        }
                        }
                    }
                }
            }
        else{
            self.removeAllChildren()
            createScene()
        }
        }
        
    }
    func canPlay(i: Int, arr: [[Int]]) -> Bool{
        var j = 0
        while(arr[i][j] != -1){
            j = j+1
            if(j==6){
                return false
            }
        }
        return true
    }
    func checkWin(arr: [[Int]], player: Int) -> Bool{
        for k in 0...6{
            for l in 0...5{
                if(arr[k][l]==player){
                    checkWin(i: k, j: l, arr: arr)
                    if(!flag){
                        flag = true
                        flag3 = false
                        return flag
                    }
                }
            }
        }
        return !flag
    }
    func solve1(tempA: [[Int]], numP: String, player: Int, a:Int, b:Int)->[Int]{
        if (numP.count - gameString.count >= 6){
            return [0,0]
        }
        if (numP.count == 42){
            return [0,0]
        }

        
        for i in 0...6{
            if(canPlay(i: i, arr: tempA)){
                var tempAA = tempA
                var j = 0
                while(tempAA[i][j] != -1){
                    j = j+1
                }
                tempAA[i][j] = player
                if(checkWin(arr: tempA, player: player)){
                    return [Int(43-numP.count)/2,i]
                }
            }
        }
        let bestS = Int(41-numP.count)/2
        var bA = b
        var Ab = a
        if(bA>bestS){
            bA = bestS
            if(Ab>bA){
                return [bA,Int(numP.suffix(1))!]
            }
        }
        var ind = 0
        for i in 0...6{
            if(canPlay(i: orderList[i], arr: tempA)){
                var tempAA = tempA
                var j = 0
                while(tempAA[orderList[i]][j] != -1){
                    j = j+1
                }
                tempAA[orderList[i]][j] = player
                let nP = (1+player)%2
                let score = solve1(tempA: tempAA, numP: numP + "\(orderList[i])", player: nP, a:-bA, b: -Ab)
                if(-score[0] > bA){
                    return [-score[0],orderList[i]]
                }
                if(-score[0] > Ab){
                    Ab = -score[0]
                    ind = orderList[i]
                }
            }
        }
        return [Ab, ind]
    }
    func auto1(x: Int, tempA: [[Int]], numP: Int){
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.play(x: self.solve1(tempA: tempA, numP: self.gameString, player: self.currentPlay, a: -10000, b: 10000)[1])
            self.flag4 = true
        }

    }
    func play(x: Int){
        gameString = gameString + "\(x)"
        var j = 0
        while(plays[x][j] != -1){
            j = j + 1
            if(j == 6){
                return
            }
        }
        let circleBG = SKShapeNode(circleOfRadius: diameter/2)
        circleBG.glowWidth = 1.0
        circleBG.position = CGPoint(x: arrPos[x][j].x , y: self.size.height/2)
        circleBG.zPosition = 2
        plays[x][j] = currentPlay
        if(currentPlay == 1){
            circleBG.fillColor = UIColor.red
            turnText = "Yellow's turn"
            let string2 = "Yellow's"
            let range = (turnText as NSString).range(of: string2)
            let range2 = (turnText as NSString).range(of: turnText)
            let attributedText = NSMutableAttributedString.init(string: turnText)
            attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow , range: range)
            attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
            label.attributedText = attributedText
        }
        else{
            circleBG.fillColor = UIColor.yellow
            turnText = "Red's turn"
            let string2 = "Red's"
            let range = (turnText as NSString).range(of: string2)
            let range2 = (turnText as NSString).range(of: turnText)
            let attributedText = NSMutableAttributedString.init(string: turnText)
            attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
            attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
            label.attributedText = attributedText
        }
        flag4 = false
        self.addChild(circleBG)
        circleBG.run(SKAction.moveTo(y: arrPos[x][j].y, duration: 0.05))
        for k in 0...6{
            for l in 0...5{
                if(plays[k][l]==currentPlay){
                    checkWin(i: k, j: l, arr: plays)
                }
            }
        }
        currentPlay = (currentPlay + 1) % 2
 
    }
    func checkWin(i: Int, j: Int, arr: [[Int]]){
        /* come up with this yourself
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
        let playss = arr
        let player = playss[i][j]
        var i2 = i
        var j2 = j
        var c = 0
        while(playss[i2][j2] == player)
        {

            c = c+1
            if(c >= 4){
                if(player == 1){
                    turnText = "Red wins"
                    let string2 = "Red"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                else{
                    turnText = "Yellowwins"
                    let string2 = "Yellow"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                flag = false
            }
            if(i2 != 6){
                i2 = i2 + 1
            }
            else{
                break
            }
        }
        c=0
        i2 = i
        j2 = j
        while(playss[i2][j2] == player)
        {

            c = c+1
            if(c >= 4){
                if(player == 1){
                    turnText = "Red wins"
                    let string2 = "Red"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                else{
                    turnText = "Yellow wins"
                    let string2 = "Yellow"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                 
                }
                flag = false
            }
            if(i2 != 0){
                i2 = i2 - 1
            }
            else{
                break
            }
        }
        c=0
        i2 = i
        j2 = j
        while(playss[i2][j2] == player)
        {

            c = c+1
            if(c >= 4){
                if(player == 1){
                    turnText = "Red wins"
                    let string2 = "Red"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                else{
                    turnText = "Yellow wins"
                    let string2 = "Yellow"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                    
                }
                flag = false
            }
            if(j2 != 0){
                j2 = j2 - 1
            }
            else{
                break
            }
        }
        c=0
        i2 = i
        j2 = j
        while(playss[i2][j2] == player)
        {

            c = c+1
            if(c >= 4){
                if(player == 1){
                    turnText = "Red wins"
                    let string2 = "Red"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                else{
                    turnText = "Yellow wins"
                    let string2 = "Yellow"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                flag = false
            }
            if(j2 != 5){
                j2 = j2 + 1
            }
            else{
                break
            }
        }
        c=0
        i2 = i
        j2 = j
        while(playss[i2][j2] == player)
        {

            c = c+1
            if(c >= 4){
                if(player == 1){
                    turnText = "Red wins"
                    let string2 = "Red"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                else{
                    turnText = "Yellow wins"
                    let string2 = "Yellow"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                flag = false
            }
            if(j2 != 5 && i2 != 0){
                j2 = j2 + 1
                i2 = i2 - 1
            }
            else{
                break
            }
        }
        c=0
        i2 = i
        j2 = j
        while(playss[i2][j2] == player)
        {

            c = c+1
            if(c >= 4){
                if(player == 1){
                    turnText = "Red wins"
                    let string2 = "Red"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                else{
                    turnText = "Yellow wins"
                    let string2 = "Yellow"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                flag = false
            }
            if(j2 != 5 && i2 != 6){
                j2 = j2 + 1
                i2 = i2 + 1
            }
            else{
                break
            }
        }
        c=0
        i2 = i
        j2 = j
        while(playss[i2][j2] == player)
        {
            c = c+1
            if(c >= 4){
                if(player == 1){
                    turnText = "Red wins"
                    let string2 = "Red"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                else{
                    turnText = "Yellow wins"
                    let string2 = "Yellow"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                flag = false
            }
            if(j2 != 0 && i2 != 0){
                j2 = j2 - 1
                i2 = i2 - 1
            }
            else{
                break
            }
        }
        c=0
        i2 = i
        j2 = j
        while(playss[i2][j2] == player)
        {

            c = c + 1
            if(c >= 4){
                if(player == 1){
                    turnText = "Red wins"
                    let string2 = "Red"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                else{
                    turnText = "Yellow wins"
                    let string2 = "Yellow"
                    let range = (turnText as NSString).range(of: string2)
                    let range2 = (turnText as NSString).range(of: turnText)
                    let attributedText = NSMutableAttributedString.init(string: turnText)
                    attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow , range: range)
                    attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
                    label.attributedText = attributedText
                }
                flag = false
            }
            if(j2 != 0 && i2 != 6){
                j2 = j2 - 1
                i2 = i2 + 1
            }
            else{
                break
            }
        }
        var flag3 = true
        for c1 in 0...6{
            for c2 in 0...5{
                if(playss[c1][c2] == -1){
                    flag3 = false
                }
            }
        }
        if(flag3){
            flag = false
            turnText = "It's a tie"
            let range2 = (turnText as NSString).range(of: turnText)
            let attributedText = NSMutableAttributedString.init(string: turnText)
            attributedText.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue , range: range2)
            attributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.init(name: "Baskerville", size: 48)!, range: range2)
            label.attributedText = attributedText
        }
 
    }
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
