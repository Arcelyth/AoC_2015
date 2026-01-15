#include <stdio.h>
#define SIZE 9

int has_incr(const char* str) {
    for (int i = 0; i <= 5; i++){
        char fst = str[i];
        if ((str[i+1] == fst + 1) && (str[i+2] == fst + 2)) {
            return 1;
        }
    }
    return 0;
}

int is_valid(const char* str) {
    for (int i = 0; i <= 7; i++) {
        if (str[i] == 'i' || str[i] == 'o' || str[i] == 'l') {
            return 0;
        }
    }
    return 1;
}

int pairs(const char* str) {
    int count = 0;
    for (int i = 0; i <= 6; i++) {
        if (str[i] == str[i+1]) {
            count++;
            i ++;
        }
    }
    return count;
   
}

void increment(char* str) {
    for (int i = 7; i >= 0; i--) {
        if (str[i] == 'z') {
            str[i] = 'a';
        } else {
            str[i]++;
            break;
        }
    }
}

int main() {
    char input[SIZE] = "cqjxjnds";
    int pos = SIZE - 2;
    while (1) {
        increment(input);
        if (has_incr(input) && is_valid(input) && (pairs(input) >= 2)){
            printf("%s\n", input);
            break;
        }
    }
    return 0;
}


