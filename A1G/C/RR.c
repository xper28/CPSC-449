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
  int* waitTimes;
  int* remaining;
  int size;
  int quantum = -1;

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
    //Mend countet
    burstCt--;

    //Allocate memory for array
    bursts = (int*)calloc(burstCt, sizeof(int));
    waitTimes = (int*)calloc(burstCt, sizeof(int));
    remaining = (int*)calloc(burstCt, sizeof(int));
    if(bursts == NULL){
      printf("Failed to allocate memory!\n");
      exit(0);
    }
    //Read burst times and store in array
    int r=0;
    while(fgets(line, sizeof line, file)!=NULL){
      if(quantum == -1){
        int tempq = atoi(line);
        quantum = tempq;
      }else{
        int temp = atoi(line);
        bursts[r] = temp;
        remaining[r] = temp;
        r++;
      }
    }
    fclose(file);

    //Open output file
    FILE *file1 = fopen(output, "w");
    if(file1 == NULL){
      printf("Error opening file for output\n");
      exit(1);
    }
    //Initialise remaining array
    for(int j=0; j<burstCt; j++){
      waitTimes[j] = 0;
    }
    //Run RR algorithm
    double totalWait = 0;
    int timer = 0;

    while(1){
      int done = 777;
      for(int i=0; i<burstCt; i++){
        int current = remaining[i];
        if(remaining[i] > 0){
          done = -777;
          int diff = current - quantum;
          if(diff>0){
            timer += quantum;
            remaining[i] = diff;
          }else{
            timer += remaining[i];
            waitTimes[i] = timer - bursts[i];
            remaining[i] = 0;
          }
        }
      }
      if(done == 777){
        break;
      }
    }

    //Print wait times
    for(int i=0; i<burstCt; i++){
      fprintf(file1, "%d \n", waitTimes[i]);
      totalWait += waitTimes[i];
    }

    double avgWait = totalWait/(double)burstCt;
    fprintf(file1, "%.2f \n", avgWait);
    fclose(file1);

    //Deallocate memory
    free(bursts);
    free(waitTimes);
    free(remaining);

  }else{
    printf("Failed to open file!\n");
    return 1;
  }
}

//Reference https://www.daniweb.com/programming/software-development/code/216411/reading-a-file-line-by-line
//Reference https://stackoverflow.com/questions/12733105/c-function-that-counts-lines-in-file
