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
        int bytes_read = read(0, command, 100);
        command[bytes_read-1] = 0;
	
	/* Check if the command is "exit" */
        if (strcmp(command, "exit") == 0) {
            /* Exit the shell */
            exit(0);
        } 
        else {
            /* Create a new process to execute the command */
            pid_t pid = fork();

            /* In the child process, execute the command */
            if (pid == 0) {
                execlp(command, command, (char *) NULL);
                /* Exit with a failure status if exec fails */
                exit(1);
		
		} 
            /* In the parent process, wait for the child to complete */
            else {
                wait(NULL);
            }
        }
    }
    return 0;
}
