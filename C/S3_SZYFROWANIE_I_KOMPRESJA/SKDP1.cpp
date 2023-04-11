#include <iostream>
#include <iomanip>
using namespace std;
#define KEYLENGTH 5
// IAD SKD 21/22 lab4
int main()
{ 
    unsigned char S[256] = { 0 };

    for( int i = 0; i < 256; i++ )
        S[i] = i;

    unsigned char K[KEYLENGTH + 1] = "Klucz";  //klucz - 5 liter, 6 miejsce - na znak konca ciagu znakow
    
    int j = 0;
    for( int i = 0; i < 256; i++ )
    {
        j = ( j + S[i] + K[i % KEYLENGTH] ) % 256;
        int a = S[i];
        S[i] = S[j];
        S[j] = a;
    }

    FILE* fin = NULL;
    FILE* fout = NULL;

    if( ( fin = fopen( "plikwe.txt", "rt" ) ) == NULL )
    {
        cout << "ERROR open input file\n";
        return 1;
    }

    fout = fopen( "plikwy.txt", "w" );
    if( fout == NULL )
    {
        cout << "ERROR open output file\n";
        fclose( fin );
        return 1;
    }

    unsigned char tekst[256] = { 0 };  // do wczytania tekstu jawnego
    unsigned char szyfr[256] = { 0 };  // do szyfrowania
    int n = 0;  //dlugosc tekstu wczytanego

    while( !feof( fin ) && n<256 )
    {
        char c = fgetc( fin );
        if( !feof( fin ) )
            tekst[n++] = c;
    }

    for( int i = 0; i < n; i++ )  //sprawdzenie wczytania
        cout << tekst[i];         //

    int i = 0;
    j = 0;
    unsigned char pom;

    for( int k = 0; k < n; k++ )
    {
        i = ( i + 1 ) % 256;
        j = ( j + S[i] ) % 256;
        pom = S[i];
        S[i] = S[j];
        S[j] = pom;
        szyfr[k] = S[( S[i] + S[j] ) % 256];
        szyfr[k] ^= tekst[k];
        fputc( szyfr[k], fout );
    }

    cout << endl;

    for( int i = 0; i < n; i++ )                                                    // dla sprawdzenia wypisanie zaszyfr
        cout << endl << hex << setfill( '0' ) << setw( 2 ) << (int)szyfr[i];        // w szesnastkowym

    fclose( fin );
    fclose( fout );
    return 0;
}