
#include <iostream>
#include <string>

using namespace std;

int test() {

    string user_name;
    cout << "your name:";
    cin >> user_name;
    cout << endl;
    cout << "Hello ";
    cout << user_name;
    return 0;

}

void test_fibon();
void test_cout();
void test_array1() ;
void test_point1();
void test_io();
int main() {
    // test_cout(); 
    // test_array1();
    // test_point1();
    // test_io();
    test_fibon();
    return 0;
   
}