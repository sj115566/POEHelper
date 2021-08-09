global lp1, pizzag, tempvv, lp2, lp3
loop 1{
        FileEncoding, UTF-8
        Loop, read, C:\Garena\Games\32808\logs\Client.txt
        last_line := A_LoopReadLine
        if( lp1 := InStr(last_line, "@")){
                tempvv := SubStr(last_line, lp1)
                lp2 := InStr(tempvv, ":")
                if( pizzag := InStr(tempvv, ">")){
                    lp3 := InStr(tempvv, " ", , , 2)
                    tempvv := SubStr(tempvv, 1, lp2-1)
                    StringRight, tempvv, tempvv, lp2-lp3-1
                }Else{
                    lp3 := InStr(tempvv, " ")
                    tempvv := SubStr(tempvv, 1, lp2-1)
                    StringRight, tempvv, tempvv, lp2-lp3-1
                }
            FileAppend, %tempvv%`n , ttesting.txt , UTF-8
        } 
        
        
}    
