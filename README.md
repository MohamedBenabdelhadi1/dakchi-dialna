# lab1
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MAX_INPUT_LENGTH 100

void display_prompt() {
    printf("HelloShell > ");
}

int main() {
    char input[MAX_INPUT_LENGTH];

    while (1) {
        display_prompt();

        if (fgets(input, sizeof(input), stdin) == NULL) {
            perror("Erreur de lecture de l'entrée");
            exit(EXIT_FAILURE);
        }

        // Supprimer le saut de ligne à la fin de l'entrée
        input[strcspn(input, "\n")] = '\0';

        // Créer un processus enfant pour exécuter la commande
        pid_t pid = fork();

        if (pid == -1) {
            perror("Erreur de création du processus");
            exit(EXIT_FAILURE);
        } else if (pid == 0) { // Code exécuté par le processus enfant
            // Afficher le message "hello"
            printf("hello\n");
            exit(EXIT_SUCCESS);
        } else { // Code exécuté par le processus parent
            // Attendre que le processus enfant se termine
            int status;
            waitpid(pid, &status, 0);

            if (!WIFEXITED(status)) {
                fprintf(stderr, "Le processus enfant n'a pas terminé correctement.\n");
            }
        }
    }

    return 0;
}
