#include "minitalk.h"
// if SIGUSR1 => 1
// if SIGUSR2 => 0

void	ft_perror_exit(char *message, int exit_number)
{
	size_t	i;
	
	i = 0;
	while (message[i] != '\0')
	{
		write(2, &message[i], 1);
		i++;
	}
	write(2, "\n", 1);
	exit(exit_number);
}

void	handler(int signum, siginfo_t *info, void *context)
{
	static int		bit_count = 0;
	static char		c = 0;
	static char		*message = NULL;
	static size_t	index = 0;
	static size_t	size = 1;

	// 	TROCAR BUZZER SIZE POR CALLOC E STRLEN
	//usleep(100);
	(void)context;
	(void)info;
	if (!message)
	{
		message = ft_calloc(size, sizeof(char));
		if (!message)
			ft_perror_exit("Memory allocation failed", 1);
	}
	if (signum == SIGUSR1)
		c = c | (1 << bit_count);
	bit_count++;
	if (bit_count == 8)
	{
		if (index >= size - 1)
		{
			size *= 2;
			char *temp = ft_calloc(size, sizeof(char));
			if (!temp)
				ft_perror_exit("Memory allocation failed", 1);
			ft_memcpy(temp, message, index);
			free(message);
			message = temp;
		}
		message[index++] = c;
		if (c == '\0')
		{
			ft_putstr_fd(message, 1);
			ft_putchar_fd('\n', 1);
			free(message);
			message = NULL;
			index = 0;
			size = 1;
		}
		bit_count = 0;
		c = 0;
	}
	
}
int	main(int ac, char **av)
{
	int	pid;

	(void)av;
	struct sigaction sa;

	if (ac != 1)
		ft_perror_exit("Usage: ./server\n", 1);
	pid = getpid();
	ft_printf("pid: %d\n", pid);
	sa.sa_sigaction = handler;
	sa.sa_flags = SA_SIGINFO;
	
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);


	// mantem o servidor rodando para receber sinais
	while(1)
		pause();



}




/* The sigaction structure is defined as something like:

struct sigaction {
	void	 (*sa_handler)(int);
	void	 (*sa_sigaction)(int, siginfo_t *, void *);
	sigset_t   sa_mask;
	int		sa_flags;
	void	 (*sa_restorer)(void);
}; */