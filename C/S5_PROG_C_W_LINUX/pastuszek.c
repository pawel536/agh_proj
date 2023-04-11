#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<fcntl.h>
#include<errno.h>
#include<string.h>
#include<unistd.h>
#include<time.h>
#include<sys/wait.h>

typedef struct Tabela{
	int no;
	int pid;
	int pliki;
} Tabela;


int main( int argc, char* argv[] ) {
int sflag = 0;
int wflag = 0;
int gflag = 0;
int pflag = 0;
int zflag = 0;
int opt;
int S = -1;
float W = -1.0;
int G = -1;
int Z = (int)time(NULL);
float start = -1;
float step = -1;
int count = -1;
while((opt = getopt(argc, argv, "s: w: g: p: z: ")) != -1 ) {
	switch(opt) {
		case 's':{
			sflag++;
			S = (int)strtol(optarg, NULL, 10);
			break;
		}
		case 'w':{
			wflag++;
			W = strtof(optarg, NULL);
			break;
		}
		case 'g':{
			gflag++;
			G = (int)strtol(optarg, NULL, 10);
			break;
		}
		case 'p':{
			pflag++;
			char* p;
			start = strtof(optarg, &p);
			step = strtof(p+1, &p);
			count = (int)strtol(p+1, NULL,10);
			break;
		}
		case 'z':{
			zflag++;
			Z = (int)strtol(optarg, NULL, 10);
			break;
		}
		default:{
			perror("Wrong flag used");
			return 1;
		}
	}
}

if(!sflag && !wflag && !gflag && !pflag && !zflag) {
	printf("All flags except for -z (seed generator - int gt 0) compulsory:\n\
		-s: flock size number, int gt 0\n\
		-w: coefficient float, 0<w*s<999\n\
		-g: hunger resistance, int gt 0\n\
	       	-p: float1:float2:int gt 1, 0<float1<float2\n");
	return 0;
} else if( !sflag || !wflag || !gflag || !pflag ) {
	perror("Flags (s, w, g , p) required!");
	return 2;
} else if( S<1 || W*S<=0 || W*S>999.0 || G<1 || Z<1 || start<=0 || step<=0 || count<1  ) {
	perror( "Conditions not met." );
	return 3;
}

int pd;

char str[12] = {0};
char str2[12] = {0};
char str3[40] = {0};
int ceil = (int)(W*S);
if(W*S - ceil > 1e-8) ceil++;
sprintf(str, "%d", ceil);
sprintf(str2, "%d", G);
sprintf(str3, "%f:%f:%d", start, start+count*step, count+1);

Tabela* tab = malloc(S*sizeof(Tabela));

for( int i=0; i<S; i++) 
{
	char str4[12] = {0};
	sprintf(str4, "%d", Z++);

	char* p2[] = {"./gas", "-f", str, "-e", str2, "-d", str3, "-s", str4,  NULL};
	pd = fork();
	switch(pd) {
		case -1: {
			perror("Fork failed!");
			return 4;
	 	}
		case 0: {
			int stat = execvp("./gas", p2);
			stat++;
			break;
		}
		default: {
			tab[i].no = i+1;
			tab[i].pid = pd;
			tab[i].pliki = 0;
			break;
		}
	}
}

while(wait(NULL)!=-1) {
	continue;
}

for(int i=1; i<=ceil; i++)
{
	char buffer[9] = {0};
	char buffer2[6] = {0};
	sprintf(buffer, "plik_%d", i);
	int fd = open(buffer, O_RDONLY );
	if( fd != -1 ) {
		int r = read( fd, buffer2, 6);
		if( r!= -1 ) {
			int p = (int)strtol(buffer2, NULL, 10);
			if(p<1) {
				perror("strtol fail");
				return 5;
			} 
			for(int j=0; j<S; j++) {
				if(tab[j].pid == p) tab[j].pliki++;
			}			
		}
		close(fd);
		unlink(buffer);
	}
}
for(int i=0; i<S; i++) {
	printf("<%*d><%*d><%*d>\n", 5,tab[i].no, 5, tab[i].pid, 3, tab[i].pliki );
}	
return 0;
}
