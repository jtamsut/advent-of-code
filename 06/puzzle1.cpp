#include <iostream>
#include <fstream>

using namespace std;

// function to get the max number from an array
int getMax(int arr[16]) 
{
    int currentMax = 0;
    for (int i=0; i<16; i++) {
        if (arr[i] > currentMax) {
            currentMax = arr[i];
        }
    }
    return currentMax;
}

// entry point 
int main() 
{
    ifstream inputFile;
    char output;
    char elems[16];
    int counter = 0;
    int max;
    int currentOutput;
    
    inputFile.open("./input.txt");
    
    while (!inputFile.eof()){
        inputFile >> output;
        output >> currentOutput;
        elems[counter] = currentOutput;
        counter += 1;
    }

    cout << getMax(elems);

    return 0;
}

