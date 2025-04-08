#include "minitalk.h"

void	ft_perror_exit(char *message, int exit_number);


void	send_char(int pid, char c)
{
	int	bit;

	bit = 0;
	while(bit < 8)
	{
		if ((c >> bit) & 1)
			kill(pid, SIGUSR1);
		else
			kill(pid, SIGUSR2);
		usleep(100); // Small delay to ensure the server processes each signal
		bit++;
	}
}

int	main(int ac, char **av)
{
	int	pid;
	int	i;
	char	*message;

	if (ac != 3)
		ft_perror_exit("Usage: ./client [PID] [MESSAGE]\n", 1);

	pid = ft_atoi(av[1]);
	message = av[2];
	i = 0;
	while (message[i])
	{
		send_char(pid, message[i]);
		i++;
	}
	send_char(pid, '\0');
	return(0);

}

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