# lab1
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include "enseash.h"

/*
 * This program is a simple shell that displays a welcome message
 * and a prompt for the user to enter a command. The command is read
 * from the user and stored in the "command" buffer.

 STUDENTS:
 Nicolas Lasso Jaramillo
 Sebastian Coneo Nuñez
*/

int main() {
    char command[100];
    /* Print the welcome message */
    write(1, WELCOME_MSG, strlen(WELCOME_MSG));
    /* Loop indefinitely to accept commands */
    while (1) {
        /* Print the shell prompt */
        write(1, PROMPT, strlen(PROMPT));
        /* Read the command from the user */
        int bytes_read = read(0, command, 100);
        command[bytes_read-1] = 0;
    }
    return 0;
}

