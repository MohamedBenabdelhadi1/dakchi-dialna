#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <sys/wait.h>
#define WELCOME_MSG "Bienvenue dans le Shell ENSEA.\nPour quitter, tapez 'exit'.\n"
#define PROMPT "enseash%"

int main() {
    /* Buffer for storing the user's command */
    char command[100];

    /* Print the welcome message */
    write(1, WELCOME_MSG, strlen(WELCOME_MSG));

    /* Loop indefinitely to accept commands */
    while (1) {
        /* Print the shell prompt */
        write(1, PROMPT, strlen(PROMPT));
        /* Read the command from the user */
        int bytes_read = read(0, command, sizeof(command));
        // Fork to create a child process
        pid_t pid = fork();
         if (pid == 0) {
            // Child process
            command[bytes_read-1] = 0;  // Remove the newline character
            execlp(command, command, (char *) NULL);
        }
         else {
            // Parent process
            // Wait for the child process to finish
            wait(NULL);
        }
    }
    return 0;
}
