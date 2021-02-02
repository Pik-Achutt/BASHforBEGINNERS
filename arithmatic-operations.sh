$1=20
$2=10
answera=$(echo $(( $1 + $2 )))
echo "Sum is $answera"
answerb=$(echo $(( $1 - $2 )))
echo "Difference is $answerb"
answerc=$(echo $(( $1 / $2 )))
echo "Product is $answerc"
answerd=$(echo $(( $1 * $2 )))
echo "Quotient is $answerd"
