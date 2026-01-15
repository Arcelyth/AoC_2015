#include <stdio.h>

int main() {
    char input[] = "cqjxxyzz";
    while (1) {
        for (int i = 7; i >= 0; i--) if (++input[i] > 'z') input[i] = 'a'; else break;
        
        int incr = 0, pairs = 0, i = 0, j = 1, valid = 1;
        for (; i < 8; i++) {
            if (input[i]=='i' || input[i]=='o' || input[i]=='l') { valid = 0; break; } 
            if (i < 6 && (input[i+1] == input[i]+1) && (input[i+2] == input[i]+2)) incr = 1;    
            if (j && (i < 7 && input[i] == input[i+1])) { pairs++; j = 0;} else j = 1;
        }
        if (incr && pairs >= 2 && valid) {
            printf("%s\n", input); break;
        }
    }
    return 0;
}


