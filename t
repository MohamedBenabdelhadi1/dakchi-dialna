int main() {
    char command[100];

    write(1, WELCOME_MSG, strlen(WELCOME_MSG));

    while (1) {
        write(1, PROMPT, strlen(PROMPT));

        // Lecture de la commande depuis l'entrée standard (terminal)
        int bytes_read = read(0, command, sizeof(command) - 1);
        command[bytes_read - 1] = '\0'; // Remplace le saut de ligne par un caractère de fin de chaîne

        // Quitter la boucle si la commande est "exit"
        if (strcmp(command, "exit") == 0) {
            break;
        }

        // Utiliser fork pour créer un nouveau processus
        pid_t pid = fork();

        if (pid == -1) {
            perror("Erreur lors de la création du processus fils");
            exit(EXIT_FAILURE);
        } else if (pid == 0) {
            // Code exécuté par le processus fils
            // Utiliser execvp pour exécuter la commande
            char* args[] = {command, NULL};
            execvp(command, args);

            // Si execvp échoue, afficher un message d'erreur
            perror("Erreur lors de l'exécution de la commande");
            exit(EXIT_FAILURE);
        } else {
            // Code exécuté par le processus parent
            // Attendre que le processus fils se termine
            waitpid(pid, NULL, 0);
        }
    }

    return 0;
}
