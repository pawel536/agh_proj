#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<fcntl.h>
#include<errno.h>
#include<string.h>
#include<unistd.h>
#include<time.h>

int main( int argc, char* argv[] ) {
int fflag = 0;
int eflag = 0;
int dflag = 0;
int sflag = 0;
int opt;
int n = -1;
int e = -1;
int z = -1;
double dmin=-1;
double dmax=-1;
int dint = -1;
while((opt = getopt(argc, argv, "f: e: d: s: ")) != -1 ) {
	switch(opt) {
		case 'f':{
			fflag++;
			n = (int)strtol(optarg, NULL, 10);
			break;
		}
		case 'e':{
			eflag++;
			e = (int)strtol(optarg, NULL, 10);
			break;
		}
		case 's':{
			sflag++;
			z = (int)strtol(optarg, NULL, 10);
			break;
		}
		case 'd':{
			dflag++;
			char* p;
			dmin = strtod(optarg, &p);
			dmax = strtod(p+1, &p);
			dint = (int)strtol(p+1, NULL,10);
			break;
		}
		default:{
			perror("Wrong flag used");
			return 5;
		}
	}
}

if(!fflag && !eflag && !dflag && !sflag) {
	printf("All flags compulsory:\n\
		-f: file number, int between 1-1000\n\
		-e: error number, int gt 0\n\
		-d: double1:double2:int gt 1, 0<double1<double2\n\
		-s: random seed number, int gt 0\n");
	return 0;
} else if( !fflag || !eflag || !dflag || !sflag ) {
	perror("All flags (f, e, d , s) required!");
	return 6;
} else if(n<1 || n>=1000 || e<1 || z<1 || dint<2 || dmin<=0 || dmax<=dmin) {
	perror("Conditions not met!");
	return 1;
}
srand(z);
struct timespec ts;
int errnumber = 0;
int los = 0;
int pid = getpid();

while(1) {
	los =(int)(rand()/(RAND_MAX + 1.0)*n) +1;
	char buffer[9] = {0};
	int spr = sprintf(buffer, "plik_%d", los);
	if( spr < 1 ) {
		perror("sprintf failed");
		return 6;
	}
	int fd = open(buffer, O_WRONLY | O_CREAT | O_EXCL, 0666 );
	if( fd == -1 ) {
		++errnumber;
		#ifdef DEBUG
			char buffer3[11] = {0};
			int spr3 = sprintf(buffer3, "\'%s\'", buffer);
			printf("%5d    %-10s    *niedostępny*\n", pid, buffer3);
			if( spr3 < 1 ) {
				perror("sprintf failed");
				return 6;
			}
		#endif
		if( errnumber >= e) return 0;	
	}
	else {
		errnumber = 0;
		char buffer2[6] = {0};
		int spr2 = sprintf(buffer2, "%d", pid);
		int w = write( fd, buffer2, spr2);
		if( w == -1) {
			perror("write fail");
			return 7;
		}
		int c = close(fd);
		if( c == -1 ) {
			perror("close failed");
			return 8;
		}
		#ifdef DEBUG
			char buffer3[11];
			int spr3 = sprintf(buffer3, "\'%s\'", buffer);
			if( spr3 < 1 ) {
				perror("sprintf failed");
				return 6;
			}
			printf("%5d    %-10s    *zajęty*\n", pid, buffer3);
		#endif	
	}
	double dg = (  dmin + (dmax-dmin)*(rand()%dint)/(dint-1.0) )/10.0;
	ts.tv_sec = (int)dg;
	dg = dg - (int)dg;
	ts.tv_nsec = (long)(1000000000*dg);
	nanosleep(&ts, NULL);
}
return 0;
}
