#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_FILENAME_SIZE 25
int main (int argc, char *argv[]){
  //Get filenames from command line
  char input[MAX_FILENAME_SIZE];
  char output[MAX_FILENAME_SIZE];
  strncpy(input, argv[1], MAX_FILENAME_SIZE);
  strncpy(output, argv[2], MAX_FILENAME_SIZE);
  int burstCt = 0;

  //Create array of burst times
  int* bursts;
  int size;

  //Open file for reading input
  char line [32]; //Max line size

  FILE *file = fopen(input, "r");
  if(file != NULL){
    //Count lines in file
    int ch = 0;
    int previous = '\n';
    while((ch = fgetc(file))!=EOF){
      if(ch == '\n' && previous != '\n'){
        burstCt++;
      }
      previous = ch;
    }
    //rewind after counting
    rewind(file);

    //Allocate memory for array
    bursts = (int*)calloc(burstCt, sizeof(int));
    if(bursts == NULL){
      printf("Failed to allocate memory!\n");
      exit(0);
    }
    //Read burst times and store in array
    int i=0;
    while(fgets(line, sizeof line, file)!=NULL){
      int temp = atoi(line);
      bursts[i] = temp;
      i++;
    }
    fclose(file);

    //Open output file
    FILE *file1 = fopen(output, "w");
    if(file1 == NULL){
      printf("Error opening file for output\n");
      exit(1);
    }
    //Print wait times
    int currWait=0;
    double totalWait = 0;
    for(int i=0; i<burstCt; i++){
      fprintf(file1, "%d \n", currWait);
      if(i!=burstCt-1){
      currWait += bursts[i];
      totalWait += currWait;
      }
    }
    //Print avg wait
    double avgWait = totalWait/(double)burstCt;
    fprintf(file1, "%.2f \n", avgWait);
    fclose(file1);

    //Deallocate memory
    free(bursts);

  }else{
    printf("Failed to open file!\n");
    return 1;
  }
}

//Reference https://www.daniweb.com/programming/software-development/code/216411/reading-a-file-line-by-line
