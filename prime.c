#include <bits/stdc++.h>
using namespace std;
 
bool isPrime(long n)
{
    if (n <= 1)
        return false;
    for (int i = 2; i < n; i++)
        if (n % i == 0)
            return false;
 
    return true;
}
int findReverse(long n)
{
   int sum=0;
   while (n!=0)
   {
     sum = sum*10 + n%10;
     n /= 10;
   }
   return sum;
}
bool isPerfect(long num)
{
    for(long index = 1; index * index <= num; index++ )
    {
        if((num % index == 0) && (num / index == index))
        {
            return true;
        }
    }
    return false;
}
bool palindrome(long value)
{
    long reversed = 0, remainder, original;
    original = value;

    while(value != 0)
    {
        remainder = value % 10;
        reversed = reversed * 10 + remainder;
        value /= 10;
    }
    if(original == reversed)
        return true;
    else
        return false;
}
int sqroot(int n) {
        int x = n;
        for (int i = 0; i < (n/2); i++)
             x = (x + n / x) / 2;

        return x;
}

int main()
{
    
    
    int count = 0;
    long reversed,Pinterger = 1;

    long squareNum = 0;
    long reverse_square = 0;

    while(count < 11)
    {
        reversed = findReverse(Pinterger);

        if(isPerfect(Pinterger) == true && isPerfect(reversed) == true)
        {
            squareNum = sqroot(Pinterger);
            reverse_square = sqroot(reversed);

            if(isPrime(squareNum) == 1 && isPrime(reverse_square))
            {
                if(palindrome(Pinterger) == false)
                {
                    printf("%d\n",Pinterger);
                    count++;
                }

            }
        }
        Pinterger++;
    }


    return 0;

}
