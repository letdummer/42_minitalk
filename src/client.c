#include "minitalk.h"

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
		usleep(100);
		bit++;
	}
}

void	send_length(int pid, size_t length)
{
	size_t	bit;

	bit = 0;
	while (bit < (sizeof(size_t) * 8))
	{
		if ((length >> bit) & 1)
			kill(pid, SIGUSR1);
		else
			kill(pid, SIGUSR2);
		usleep(100);
		bit++;
	}
}

int	main(int ac, char **av)
{
	int	pid;
	int	i;
	char	*message;
	size_t	message_length;

	if (ac != 3)
		ft_perror_exit("Usage: ./client [PID] [MESSAGE]\n", 1);

	pid = ft_atoi(av[1]);
	if (pid <= 0)
		ft_perror_exit("Invalid PID\n", 1);
	if (kill(pid, 0) < 0)
		ft_perror_exit("Process does not exist\n", 1);
	message = av[2];
	message_length = ft_strlen(message);
	send_length(pid, message_length);
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