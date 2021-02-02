while true
do
  echo "1. Add"
  echo "2. Subsctract"
  echo "3. Multiply"
  echo "4. Divide"
  echo "5. Quit"
  read -p "Enter your choice: " choice

  if [ $choice -eq 1 ]
  then
        read -p "Enter Number_1: " numbera
        read -p "Enter Number_2: " numberb
        echo Answer=$(( $numbera + $numberb ))

  elif [ $choice -eq 2 ]
  then
        read -p "Enter Number_1: " numbera
        read -p "Enter Number_2: " numberb
        echo Answer=$(( $numbera - $numberb ))
  
  elif [ $choice -eq 3 ]
  then
        read -p "Enter Number_1: " numbera
        read -p "Enter Number_2: " numberb
        echo Answer=$(( $numbera * $numberb ))
 
 elif [ $choice -eq 4 ]
  then
        read -p "Enter Number_1: " numbera
        read -p "Enter Number_2: " numberb
        echo Answer=$(( $numbera / $numberb ))
  
  elif [ $choice -eq 5 ]
  then
      break
 fi

done
