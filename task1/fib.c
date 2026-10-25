/*
输入的是1，2直接返回1，从3开始递归
for循环使得第一位数和第二位数一个变成第二位数一个变成第一位数和第二位数之后再次返回
返回最后一位数
*/
int fib(int n){
    if (n <= 0) return 0;
    if (n == 1 || n == 2) return 1; 
    int a = 1;
    int b = 1;
    int round = n - 2;
    for(int i = 0;i < round;i++){
        int tmp = a;
        a = b;
        b = tmp + b;
    }
    return b;
}