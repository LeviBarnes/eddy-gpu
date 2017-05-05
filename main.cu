#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cuda.h>
#include <stdio.h>
#include <math_functions.h>
#include <math.h>
#include <string.h>
#include <cstdlib>
#include <sys/timeb.h>
#include <assert.h>
#include <time.h>
#include <vector>
#include <boost/math/special_functions/beta.hpp>
#include <boost/math/special_functions/gamma.hpp>
#include "definitions.cuh"
//#define MAX_THREADS 1024
//#define MAX_THREADS 23
//#define MAX_GENES 50
//#ifdef _WIN32
//const char DIR[20] = "PRIORS\\";
//#endif
//#ifdef linux
//const char DIR[20] = "PRIORS/";
//#include <errno.h>
//#endif
//extern "C"
//{
//#include "incomplete_beta_function.h"
//#include "beta_function.h"
//}
#define HANDLE_ERROR( err ) ( HandleError( err, __FILE__, __LINE__ ) )
//void printVec(int** a, int n);

static void HandleError(cudaError_t err, const char *file, int line)
{
	if (err != cudaSuccess)
	{
		printf("%s in %s at line %d\n", cudaGetErrorString(err),
			file, line);
		exit(EXIT_FAILURE);
	}
}
//
//void checkCUDAError(const char *msg)
//{
//	cudaError_t err = cudaGetLastError();
//	if (cudaSuccess != err)
//	{
//		fprintf(stderr, "Cuda error: %s: %s.\n", msg,
//			cudaGetErrorString(err));
//		exit(EXIT_FAILURE);
//	}
//}
//
//void idPrep(int fixd, int combo, int *ary1, int *ary2){
//
//	int start = 2;
//	int pos = 1;
//	int pos2 = 0;
//	for (int i = 0; i <combo; i++){
//		ary1[i] = pos;
//		ary2[i] = pos2;
//		pos++;
//		if (pos == fixd){
//			pos = start;
//			pos2++;
//			start++;
//		}
//	}
//
//
//}
////cooley function 
//double kool(double *P, double *Q, int scaler, int scaler1) {
//	//	js = kool(lval1, sea, 0, scaler) / 2 + kool(lval1, sea, scaler, scaler) / 2;
//	int numberOfValue = scaler1;
//	double D = 0;
//	for (int i = 0; i < numberOfValue; i++) {
//		if (Q[i] == 0) {
//			continue;
//		}
//
//		if (P[i + scaler] == 0)
//			continue;
//
//		double temp = P[i + scaler] * log(P[i + scaler] / Q[i]);
//		D += temp;
//	}
//
//	return D;
//}
//
//// creates unique required data for subsequent steps
//int structureUnique(int unique, int totEdges, int scaler1, int scaler2, int noGenes, bool *uniqueList, int *edgesPN, int *edgeAry, int *nodeAry, int *uniEdges, int *uniNodes, int *uniEpn){
//	int start = 0;
//	int start2 = 0;
//	int set1 = 0;
//	int count = 0;
//	int count2 = 0;
//	uniEpn[0] = 0;
//	int place = 1;
//
//	for (int i = 0; i < scaler2; i++){
//		if (uniqueList[i] == 1){
//			if (i < scaler1){
//				set1++;
//			}
//			//compute number of Edges in network
//			int numEdges = 0;
//			if (i == scaler2 - 1){
//				assert(i < scaler2 + 1);
//				numEdges = totEdges - edgesPN[i];
//			}
//			else
//			{
//				assert(i < scaler2 + 1);
//				numEdges = edgesPN[i + 1] - edgesPN[i];
//			}
//			//add matching values to new edge list
//			int val;
//			for (int j = 0; j < numEdges; j++){
//				assert(i < scaler2 + 1);
//				val = edgeAry[edgesPN[i] + j];
//				uniEdges[j + start] = val;
//				count++;
//			}
//
//			start = count;
//			//add matching values to new node list
//			for (int k = 0; k < noGenes; k++){
//				uniNodes[k + start2] = nodeAry[i*noGenes + k];
//				count2++;
//			}
//			start2 = count2;
//			//add matching values to new master 
//			assert(place < unique + 1);
//			/*if (place >= unique)
//			{
//				printf("place : %d\n", place);
//			}*/
//			uniEpn[place] = numEdges + uniEpn[place - 1];
//			place++;
//
//		}
//	}
//	return set1;
//}
////gamma function
//double gammds(double x, double p, int *ifault)
//
////****************************************************************************80
//{
//	double a;
//	double arg;
//	double c;
//	double e = 1.0E-09;
//	double f;
//	//int ifault2;
//	double uflo = 1.0E-37;
//	double value;
//	//
//	//  Check the input.
//	//
//	if (x <= 0.0)
//	{
//		*ifault = 1;
//		value = 0.0;
//		return value;
//	}
//
//	if (p <= 0.0)
//	{
//		*ifault = 1;
//		value = 0.0;
//		return value;
//	}
//	//
//	//  LGAMMA is the natural logarithm of the gamma function.
//	//
//	arg = p * log(x) - lgamma(p + 1.0) - x;
//
//	if (arg < log(uflo))
//	{
//		value = 0.0;
//		*ifault = 2;
//		return value;
//	}
//
//	f = exp(arg);
//
//	if (f == 0.0)
//	{
//		value = 0.0;
//		*ifault = 2;
//		return value;
//	}
//
//	*ifault = 0;
//	//
//	//  Series begins.
//	//
//	c = 1.0;
//	value = 1.0;
//	a = p;
//
//	for (;;)
//	{
//		a = a + 1.0;
//		c = c * x / a;
//		value = value + c;
//
//		if (c <= e * value)
//		{
//			break;
//		}
//	}
//
//	value = value * f;
//
//	return value;
//	/*JR*/
//}
//
//
//
//
//__host__ int cmpfunc(const void * a, const void * b)
//{
//	return (*(int*)a - *(int*)b);
//}
//
//__host__ void writeBdeuScores(char *outputFile, char *inputFile, char *classFile, char *genesetFile, char *class1, char *class2, int scaler, double *bdeuScores)
//{
//	FILE *scoreFile = fopen(outputFile, "w");
//	if (scoreFile == NULL)	{ printf("scoreFile is NULL. Error code : %s. Exiting...\n", strerror(errno)); exit(EXIT_FAILURE); }
//	fprintf(scoreFile, "\t\t BDEU SCORES\n");
//	fprintf(scoreFile, "input : %s\n", inputFile);
//	fprintf(scoreFile, "class : %s\n", classFile);
//	fprintf(scoreFile, "geneset : %s\n\n", genesetFile);
//	fprintf(scoreFile, "Network \t  %s  \t   \t    %s\n", class1, class2);
//	int networkIndex = 1;
//	for (int j = 0; j < scaler; j++)
//	{
//		fprintf(scoreFile, "Network %d\t %f \t %f \n", networkIndex++, bdeuScores[j], bdeuScores[j + scaler]);
//		//printf("lval1[%d] : %f\n lval1", j, lval1[j]);
//	}
//	fclose(scoreFile);
//	printf("Finished bdeu file %s\n", outputFile);
//}
//
//__host__ void writeNetworkFile(char *outputFile, char *inputFile, char *classFile, char *genesetFile, int networkNum, int *edgesPN,
//	char genesetgenes[][40], int genesetlength, int *nodes, int *edges, int totalEdges, int *networkIds)
//{
//	FILE *output = fopen(outputFile, "w");
//	if (output == NULL)	{ printf("output when accessing networkOutput.txt is NULL. Error code : %s. Exiting...\n", strerror(errno)); exit(EXIT_FAILURE); }
//
//	fprintf(output, "%s", "\t\tUnique Networks\n\n");
//	fprintf(output, "input : %s\n", inputFile);
//	fprintf(output, "class : %s\n", classFile);
//	fprintf(output, "geneset : %s\n\n\n", genesetFile);
//	int edgePos = 0;
//
//	//loop through all the unique networks
//	for (int i = 0; i < networkNum; i++)
//	{
//		int total;
//		if (i == networkNum - 1)
//		{
//			total = totalEdges - edgesPN[i];
//		}
//		else
//		{
//			total = edgesPN[i + 1] - edgesPN[i];
//		}
//		fprintf(output, "network %d (%d)\t number of edges : %d\n", i + 1, networkIds[i], total);
//		fprintf(output, "%s", "---------------");
//		fprintf(output, "%s", "---------------\n\n");
//		if (total == 0)
//		{
//			continue;
//		}
//		//loop through each node in the ith network
//		for (int j = 0; j < genesetlength - 1; j++)
//		{
//			//if change in node values --> edge has been found
//			if (nodes[(i * genesetlength) + j + 1] != nodes[(i * genesetlength) + j])
//			{
//				int change = nodes[(i * genesetlength) + j + 1] - nodes[(i * genesetlength) + j];
//				total -= change;
//				for (int k = 0; k < change; k++)
//				{
//					fprintf(output, "%s - %s\n", genesetgenes[j], genesetgenes[edges[edgePos++]]);
//					//fprintf(output, "%d - %d ---> normal case total remaining : %d j : %d\n", j, pUniEdges[edgePos++], total, j);
//				}
//			}
//			if (j + 1 == genesetlength - 1 && total > 0)
//			{
//				//fprintf(output, "%s", "9s case\n");
//				for (int k = 0; k < total; k++)
//				{
//					//fprintf(output, "%d - %d ---> 9s case\n", j + 1, pUniEdges[edgePos++]);
//					fprintf(output, "%s - %s\n", genesetgenes[j + 1], genesetgenes[edges[edgePos++]]);
//				}
//			}
//
//
//
//		}
//		fprintf(output, "%s", "\n");
//		fprintf(output, "%s", "\n");
//
//	}
//
//	fclose(output);
//	printf("Finished writing %s\n", outputFile);
//}
//
//__host__ void writeEdgeListFile(char *outputFile, char *inputName, char *className, char *pathwayName, char genesetgenes[][40],
//	int genesetlength, int *nodes, int *edges, int *edgesPN, int *priorMatrix, char class1[50], char class2[50])
//{
//	FILE *output = fopen(outputFile, "w");
//	//arrays to keep track of found nodes w/edges for each class	
//	std::vector<graphNode> class1Nodes;
//	std::vector<graphNode> class2Nodes;
//
//
//	//loop through *nodes/*edges to find get nodes and edge
//	//store found nodes into either class1Nodes or class2Nodes with a graphNode struct
//	int edgePos = 0;
//	char classes[2][50];
//	strcpy(classes[0], class1);
//	strcpy(classes[1], class2);
//	//loop through all the unique networks
//	for (int i = 0; i < 2; i++)
//	{
//		int total;
//		if (i == 2 - 1)
//		{
//			total = edgesPN[2] - edgesPN[i];
//		}
//		else
//		{
//			total = edgesPN[i + 1] - edgesPN[i];
//		}
//		if (total == 0)
//		{
//			continue;
//		}
//		//loop through each node in the ith network
//		for (int j = 0; j < genesetlength - 1; j++)
//		{
//			//if change in node values --> edge has been found
//			if (nodes[(i * genesetlength) + j + 1] != nodes[(i * genesetlength) + j])
//			{
//				int change = nodes[(i * genesetlength) + j + 1] - nodes[(i * genesetlength) + j];
//				total -= change;
//				for (int k = 0; k < change; k++)
//				{
//					graphNode temp;
//                                        temp.node = j;
//                                        temp.edge = edges[edgePos++];
//					temp.inBoth = 0;
//					//fprintf(output, "%s - %s\n", genesetgenes[j], genesetgenes[edges[edgePos++]]);
//					//printf("%s\t%s\t%s\n", genesetgenes[j], genesetgenes[edges[edgePos++]], classes[i]);
//					//printf("%s\n", classes[i]);
//					if(strcmp(classes[i], class1) == 0)
//					{
//						class1Nodes.push_back(temp);
//					}
//					else
//					{
//						class2Nodes.push_back(temp);
//					}
//					//fprintf(output, "%d - %d ---> normal case total remaining : %d j : %d\n", j, pUniEdges[edgePos++], total, j);
//				}
//			}
//			if (j + 1 == genesetlength - 1 && total > 0)
//			{
//				for (int k = 0; k < total; k++)
//				{
//					graphNode temp;
//                                        temp.node = j + 1;
//                                        temp.edge = edges[edgePos++];
//					temp.inBoth = 0;
//					//fprintf(output, "%d - %d ---> 9s case\n", j + 1, pUniEdges[edgePos++]);
//					//fprintf(output, "%s - %s\n", genesetgenes[j + 1], genesetgenes[edges[edgePos++]]);
//					//printf("%s\t%s\t%s\n", genesetgenes[j + 1], genesetgenes[edges[edgePos++]], classes[i]);
//					//printf("%s\n", classes[i]);
//                                        if(strcmp(classes[i], class1) == 0)
//                                        {
//                                                class1Nodes.push_back(temp);
//                                        }
//                                        else
//                                        {
//                                                class2Nodes.push_back(temp);
//                                        }
//				}
//			}
//		}
//	}
//
//
//	//determine which nodes in class1 are also in class2 - if the are mark inBoth for each node so later we dont repeat when we print
//	for(int i = 0; i < class1Nodes.size(); i++)
//	{
//		for(int j = 0; j < class2Nodes.size(); j++)
//		{
//			if(class1Nodes.at(i).node == class2Nodes.at(j).node && class1Nodes.at(i).edge == class2Nodes.at(j).edge)
//			{
//				class1Nodes.at(i).inBoth = 1;
//				class2Nodes.at(j).inBoth = 1;
//				
//			}
//		}
//	}
//
//	//create spacer and ff rows to offset our reads for row/col access to the prior matrix
// 	int c = ((genesetlength * genesetlength) - genesetlength) / 2;
//	int position = 0;
//        int *spacer = (int *)malloc(sizeof(int) * c);
//        int *ff = (int *)malloc(sizeof(int) * c);
//        for (int row = 1; row < genesetlength; row++)                     
//        {
//                for (int col = 0; col < row; col++)
//                {
//                        spacer[position] = row;
//                        ff[position] = col;
//                        position++;
//                }
//        }
//
//	//denote if eddy found an edge so that we can check later if the edge wasnt found- 1 = EDDY found edge 0 = EDDY  did not find edge
//	int *eddyFound = (int *)calloc(genesetlength * genesetlength, sizeof(int));
//	
//
//
//
//	
//	char priorString[2][20] = {"NONE", "PRIOR"};
//	//printf("ATTEMPTING FILE OUTPUT TEST: \n");
//	for(int i = 0; i < class1Nodes.size(); i++)
//	{
//		
//		int row = class1Nodes.at(i).node;
//                int col = class1Nodes.at(i).edge;
//		if(class1Nodes.at(i).inBoth == 1)
//		{
//			//if node is in both classes print to file with "Both" class specifier
//			fprintf(output, "%s\t%s\t%s\t%s\n", genesetgenes[row], genesetgenes[col], "Both", priorString[*(priorMatrix + row * genesetlength + col)]);
//			//printf("%s\t%s\t%s\t%s\n", genesetgenes[row], genesetgenes[col], "Both", priorString[*(priorMatrix + row * genesetlength + col)]);
//			//denote that eddy found this edge
//			*(eddyFound + row * genesetlength + col) = 1;
//			*(eddyFound + col * genesetlength + row) = 1;
//			//printf("IN BOTH!");
//		}
//		else
//		{
//			//if it isnt both class write all class1 nodes
//			fprintf(output, "%s\t%s\t%s\t%s\n", genesetgenes[row], genesetgenes[col], class1, priorString[*(priorMatrix + row * genesetlength + col)]);
//			//denote that eddy found this edge
//			*(eddyFound + row * genesetlength + col) = 1;
//                        *(eddyFound + col * genesetlength + row) = 1;
//		}
//	}
//	
//	for(int i = 0; i < class2Nodes.size(); i++)
//	{
//		int row = class2Nodes.at(i).node;
//                int col = class2Nodes.at(i).edge;
//		if(class2Nodes.at(i).inBoth != 1)
//		{
//			//write to file all nodes as long as not also in class1 - that way we dont repeat edges
//			fprintf(output, "%s\t%s\t%s\t%s\n", genesetgenes[row], genesetgenes[col], class2, priorString[*(priorMatrix + row * genesetlength + col)]);
//			//printf("%s\t%s\t%s\t%s\n", genesetgenes[row], genesetgenes[col], class2, priorString[*(priorMatrix + row * genesetlength + col)]);
//			//denote that eddy found an edge
//			*(eddyFound + row * genesetlength + col) = 1;
//                        *(eddyFound + col * genesetlength + row) = 1;
//		}
//	}
//	
//
//	//write edges that werent found by EDDY
//	//loop through prior matrix- if relationship isnt already found by eddy but in the prior file, write relationship to file
//	for(int i = 0; i < c; i++)
//	{
//		int row = spacer[i];
//		int col = ff[i];
//		//0 in eddyFound = eddy did not find 1 in eddyFound = eddy did find
//		if(*(eddyFound + row * genesetlength + col) == 0 && *(priorMatrix + row * genesetlength + col) == 1)
//		{
//			fprintf(output,"%s\t%s\t%s\t%s\n", genesetgenes[row], genesetgenes[col], "Neither", "PRIOR");
//		}
//	}
//	
//	free(spacer); spacer = NULL;
//	free(ff); ff = NULL;
//	free(eddyFound); eddyFound = NULL;
//	
//	fclose(output);
//	printf("Finished writing edgelist file %s\n", outputFile);
//
//}
//
//__host__ double mean(double *a, size_t size)
//{
//	double sum = 0.0;
//	for (size_t i = 0; i < size; i++)	{ sum += a[i];	}
//	return sum / size;
//}
//
//__host__ double variance(double mean, double *a, size_t size)
//{
//	double sum = 0.0;
//	for (size_t i = 0; i < size; i++)	{ sum += pow(a[i] - mean, 2); }
//	return sum / size;
//}
//
//
//__host__ void checkParentLimit(int numNetworks, int numNodes, int maxParents, int *nodes, size_t size)
//{
//	//loop through each network
//	for (int net = 0; net < numNetworks; net++)
//	{
//		//loop through nodes in each network
//		for (int i = 0; i < numNodes - 1; i++)
//		{
//			if (nodes[(net * numNodes) + i + 1] - nodes[(net * numNodes) + i] > maxParents)
//			{
//				printf("PROBLEM @ %d %d\n", (net * numNodes) + i, (net * numNodes) + i + 1);
//			}
//		}
//	}
//}
//
////compute likelihood of different dataset parsed by 2 iterations
//__host__ void compute_likelihood(int scaler, int noNodes, double *out5, double *lval1)
//{
//	for(int g = 0; g < 2; g++){
//		int set = 0;
//		int place = 0;
//		double scoreSum = 0;
//		double *likeli1;
//		double min = 0;
//		double max = 0;
//		double inAlpha = 0;
//		double probScale = 0;
//		double likeliSum = 0;
//		double nonInf = 0;
//		double *dist;
//
//		double *adjusted;
//		double *infFlag;
//		double *outq;
//		int localoffset;
//		outq = out5;
//		if (g < 1){
//			localoffset = 0;
//		}
//		else
//		{
//			localoffset = scaler;
//		}
//
//		dist = (double *)malloc(sizeof(double)*scaler);
//		likeli1 = (double *)malloc(sizeof(double)*scaler);
//		adjusted = (double *)malloc(sizeof(double)*scaler);
//		infFlag = (double *)malloc(sizeof(double)*scaler);
//		for (int k2 = 0; k2 < scaler; k2++){
//
//			dist[k2] = 0.0;
//
//			adjusted[k2] = 0.0;
//			infFlag[k2] = 0.0;
//
//		}
//		for (int i = 0; i < scaler*noNodes; i++){
//
//			dist[place] += outq[i + localoffset*noNodes];
//			set++;
//			if (set == noNodes){
//				set = 0;
//				place++;
//			}
//		}
//
//		min = dist[0];
//		max = dist[0];
//		for (int j3 = 0; j3 < scaler; j3++){
//					//			printf(" dis %d %f \n", j3, dist[j3]);
//			scoreSum += dist[j3];
//			if (dist[j3]>max){
//
//				max = dist[j3];
//			}
//			if (dist[j3] < min){
//
//				min = dist[j3];
//			}
//
//		}
//
//
//		inAlpha = -1 * (scoreSum / scaler);
//		//printf("\n min-%f max-%f", min, max);
//		//printf("inAlpha-%f", inAlpha);
//		probScale = (10) / (max - min);
//
//		for (int m = 0; m < scaler; m++){
//
//			adjusted[m] = (dist[m] + inAlpha)*probScale;
//			//			printf("\n adjusted: %f", adjusted[m]);
//			likeli1[m] = exp(adjusted[m]);
//			//			printf("\n likeli: %f", likeli1[m]);
//			nonInf += likeli1[m];
//			//likeLi[m] = posInf;
//			//suppress overflow infinity error
//			#pragma warning(suppress: 4056)
//			if (likeli1[m] >= INFINITY || likeli1[m] <= -INFINITY){
//				infFlag[m] = 1.0;
//				likeliSum++;
//			}
//
//		}
//		free(dist); dist = NULL;
//		free(adjusted); adjusted = NULL;
//		//	printf("\n likesum: %f nonInf: %f", likeliSum, nonInf);
//
//		if (likeliSum == 0){
//			for (int meow = 0; meow < scaler; meow++){
//				likeli1[meow] = likeli1[meow] / nonInf;
//				lval1[meow + localoffset] = likeli1[meow];
//
//			}
//
//		}
//		else{
//			for (int meow = 0; meow < scaler; meow++){
//				likeli1[meow] = infFlag[meow] / likeliSum;
//				lval1[meow + localoffset] = likeli1[meow];
//			}
//		}
//		free(likeli1); likeli1 = NULL;
//		free(infFlag); infFlag = NULL;
//		outq = NULL;
//	}
//
//}
//
////determine gene relationships by running expression data through chi-squared test
////@RETURN: sampleSum - total number of samples 
//int calculate_edges(int scalerSum, int samples, int samples2, int genesetlength, int size2, int c, int genes, int *transferdata1, int *transferdata2, int *ff1, int *priorMatrix, int *spacer1, cudaEvent_t start, cudaEvent_t stop, float time, double pw, int *edgeListData1, int *edgeListData2, int *dout23, int *dedgesPN, int *dtriA, int *dtriAb, int *ddofout, int *dppn, int *dstf, int *dff, int *dspacr, int *dpriorMatrix, int numclass1, int numclass2, int permNum)
//{
//			
//
//	//copy into device 
//	assert(genes*samples*sizeof(int) == genesetlength * numclass1 * sizeof(int));
//	assert(genes*samples2*sizeof(int) == genesetlength * numclass2 * sizeof(int));
//	HANDLE_ERROR(cudaMemcpy(dtriA, transferdata1, genes*samples*sizeof(int), cudaMemcpyHostToDevice));
//	HANDLE_ERROR(cudaMemcpy(dtriAb, transferdata2, genes*samples2*sizeof(int), cudaMemcpyHostToDevice));
//	HANDLE_ERROR(cudaMemcpy(dff, ff1, c*sizeof(int), cudaMemcpyHostToDevice));
//	HANDLE_ERROR(cudaMemcpy(dspacr, spacer1, c*sizeof(int), cudaMemcpyHostToDevice));
//	HANDLE_ERROR(cudaMemcpy(dpriorMatrix, priorMatrix, genesetlength * genesetlength * sizeof(int), cudaMemcpyHostToDevice));
//			
//			
//
//	//no longer used once copied to GPU
//	free(spacer1); spacer1 = NULL;
//	free(ff1); ff1 = NULL;
//
//	int sampleSum = samples + samples2 + 2;
//
//			
//	cudaEventRecord(start, 0);
//	if( c < MAX_THREADS)
//	{
//	run2 << <sampleSum, c, genes * genes * sizeof(int) >> >(genes, samples, samples2, dtriA, dtriAb, dspacr, dff, ddofout, dppn, dstf, dout23, c, dpriorMatrix, pw);
//	}
//	else
//	{
//		int BPN = ceil((c * 1.0) / MAX_THREADS);
//		int TPB = ceil((c * 1.0) / BPN);
//			
//		run2Scalable <<< sampleSum * BPN, TPB>>>(genes, samples, samples2, dtriA, dtriAb,dspacr, dff, ddofout, dppn, dstf, dout23, c, dpriorMatrix, pw, BPN, TPB);
//	}
//
//
//
//	cudaEventRecord(stop, 0);
//	cudaEventSynchronize(stop);
//	cudaEventElapsedTime(&time, start, stop);
//
//	if (permNum == 0)
//	{
//		//holds post run2 edge data for edge list calculations after permutations
//		edgeListData1 = (int *)malloc(sizeof(int) * c);
//		edgeListData2 = (int *)malloc(sizeof(int) * c);
//
//		//host array to transfer output of run2 to edgeListData1/edgeListData2
//		int *tempOut23 = (int *)malloc(sizeof(int) * c * scalerSum);
//				
//
//		//copy binary data back to CPU
//		HANDLE_ERROR(cudaMemcpy(tempOut23, dout23, sizeof(int) * c * scalerSum, cudaMemcpyDeviceToHost));
//				
//
//		//first network in first class - no samples left out
//		for (int i = 0; i < c; i++)
//		{
//			//load 1st network from class 1
//			edgeListData1[i] = tempOut23[i];
//		}
//		int count = 0;
//		//last network in 2nd class - no samples left out
//		for (int i = (scalerSum - 1) * c; i < (scalerSum) * c; i++)
//		{
//			edgeListData2[count++] = tempOut23[i];
//		}
//			
//
//
//
//		free(tempOut23); tempOut23 = NULL;
//	}
//
//
//
//	return sampleSum;
//}
//
////build edgesPN array that holds the number of edges for each network
//void count_edges(int *dsrchAry, cudaEvent_t PN_start, cudaEvent_t PN_stop, float PN_time, int *dout23, int *dedgesPN, int genes, int MAX_PARENTS, int c, int scalerSum, int *edgesPN, cudaError_t errSync, int sampleSum)
//{
//
//	int *tempEdgesSums;
//	tempEdgesSums = (int *) calloc(sampleSum + 1, sizeof(int));
//	edgePerNetworkKernel << < sampleSum + 1, 1 >> > (dout23, dedgesPN, dsrchAry, genes, MAX_PARENTS, c);
//	cudaEventRecord(PN_stop, 0);
//			
//	//copy edge sums over to CPU to calculate prefix sum for edgesPN	
//	HANDLE_ERROR(cudaMemcpy(tempEdgesSums, dedgesPN, sizeof(int) * (scalerSum + 1), cudaMemcpyDeviceToHost));	
//			
//	edgesPN[0] = 0;
//	for(int i = 1; i < sampleSum + 1; i++)
//	{
//		edgesPN[i] = edgesPN[i-1] + tempEdgesSums[i-1]; //prefix sum calculation
//	}
//	//get rid of this temp array	
//	free(tempEdgesSums); tempEdgesSums = NULL;
//	//edgesPN on the CPU is now fixed but dedgesPN is used later- copy edgesPN results back to GPU memory
//	HANDLE_ERROR(cudaMemcpy(dedgesPN, edgesPN, sizeof(int) * (sampleSum + 1), cudaMemcpyHostToDevice));
//			
//			
//	errSync = cudaGetLastError();
//	if (errSync != cudaSuccess)
//	{
//		printf("%s\n", cudaGetErrorString(errSync));
//	}
//	cudaEventSynchronize(PN_stop);
//	cudaEventElapsedTime(&PN_time, PN_start, PN_stop);
//
//}
//
////construct network graphs from gene relationships and network edge counts (edgesPN).
//void build_graph(int scalerSum, int noNodes, int c, int *dedgesPN, int *dout23, int *dpNodes, int numEdges, int *dsrchAry, int *dpEdges, int MAX_PARENTS, int *pNodes, int *pEdges, int nodeSize, int edgeSize)
//{
//	run22 << <scalerSum, noNodes >> >(c, dedgesPN, dout23, dpNodes, noNodes, numEdges, dsrchAry, dpEdges, MAX_PARENTS);
//
//	HANDLE_ERROR(cudaMemcpy(pNodes, dpNodes, nodeSize, cudaMemcpyDeviceToHost));
//	HANDLE_ERROR(cudaMemcpy(pEdges, dpEdges, edgeSize, cudaMemcpyDeviceToHost));
//
//			
//
//	//ensure parent limit
//	checkParentLimit(scalerSum, noNodes, MAX_PARENTS, pNodes, nodeSize / sizeof(int));
//
//}
//
//
//
//
////determine which graphs are duplicated and mark them for removal in structureUnique
//void mark_duplicate_networks(int scalerSum, int scalerCombo, int *scalerTest, int *shrunkPlc, int *shrunk, int *dshrunk, int *dscalerTest, int *dshnkplc, int maxThreads, int samples, int numEdges, int genesetlength, int *dedgesPN, int *dpNodes, int *dpEdges)
//{
//
//	idPrep(scalerSum, scalerCombo, scalerTest, shrunkPlc);
//
//	
//
//	//cp into device
//	HANDLE_ERROR(cudaMemcpy(dscalerTest, scalerTest, sizeof(int)*scalerCombo, cudaMemcpyHostToDevice));
//	HANDLE_ERROR(cudaMemcpy(dshnkplc, shrunkPlc, sizeof(int)*scalerCombo, cudaMemcpyHostToDevice));
//
//	run25 << <(scalerCombo / (maxThreads - 1)) + 1, maxThreads - 1 >> >(samples + 1, scalerSum, numEdges, genesetlength, scalerCombo, dedgesPN, dpNodes, dpEdges, dshrunk, dscalerTest, dshnkplc);
//	
//	HANDLE_ERROR(cudaMemcpy(shrunk, dshrunk, sizeof(int)*scalerCombo, cudaMemcpyDeviceToHost));
//	cudaFree(dshrunk); dshrunk = NULL;
//	cudaFree(dscalerTest); dscalerTest = NULL;
//	cudaFree(dshnkplc); dshnkplc = NULL;
//	cudaFree(dedgesPN); dedgesPN = NULL;
//	cudaFree(dpEdges); dpEdges = NULL;
//	cudaFree(dpNodes); dpNodes = NULL;
//	free(shrunkPlc); shrunkPlc = NULL;
//
//
//}
////calculate the BDEU scores for each graph
//void score_networks(double *out5, double *dout5, int *dpEdges2, int *dpNodes2, int *dNij, int *dNijk, int *dUniEpn, int uniEdgeSize, int uniNodeSize, int unisum, int noNodes, int scaler, int *pUniEdges, int *pUniNodes, int *pUniEpn, int genesetlength, int edSum, int samples, int samples2, int *dtriA, int *dtriAb, int *dppn, int *dstf, int dppnLength)
//{
//
//
//	
//
//	HANDLE_ERROR(cudaMemcpy(dpEdges2, pUniEdges, uniEdgeSize, cudaMemcpyHostToDevice));
//	HANDLE_ERROR(cudaMemcpy(dpNodes2, pUniNodes, uniNodeSize, cudaMemcpyHostToDevice));
//	HANDLE_ERROR(cudaMemcpy(dUniEpn, pUniEpn, sizeof(int) * unisum, cudaMemcpyHostToDevice));
//	free(pUniNodes); pUniNodes = NULL;
//	free(pUniEdges); pUniEdges = NULL;
//	free(pUniEpn); pUniEpn = NULL;
//
//	cudaEvent_t run4Start, run4End;
//	cudaEventCreate(&run4Start);
//	cudaEventCreate(&run4End);
//	cudaEventRecord(run4Start, 0);
//	float run4Time;
//
//	run4 << <scaler * 2, noNodes >> >(scaler, dUniEpn, genesetlength, edSum, unisum, samples, samples2, dtriA, dtriAb, dpEdges2, dpNodes2, dppn, dstf, dNij, dNijk, dout5, dppnLength);
//	
//	cudaEventRecord(run4End, 0);
//	cudaEventSynchronize(run4End);
//	cudaEventElapsedTime(&run4Time, run4Start, run4End);
//	HANDLE_ERROR(cudaMemcpy(out5, dout5, sizeof(double)*noNodes*scaler * 2, cudaMemcpyDeviceToHost));
//
//
//}



int main(int argc, char *argv[])
{
	//looking at GPU properties
	int nDevices;
	//int maxBlocks;
	int maxThreads;

	cudaGetDeviceCount(&nDevices);
	for (int i = 0; i < nDevices; i++) {
		cudaDeviceProp prop;
		cudaGetDeviceProperties(&prop, i);
		printf("Device Number: %d\n", i);
		printf("  Device name: %s\n", prop.name);
		printf("  Memory Clock Rate (KHz): %d\n",
			prop.memoryClockRate);
		printf("  Processor Clock Rate (KHz): %d\n", prop.clockRate);
		printf("  Device Max Number of Blocks: %d\n",
			prop.maxGridSize[1]);
		
		printf("  Device Max Number of Threads per Block: %d\n",
			prop.maxThreadsPerBlock);
		maxThreads = prop.maxThreadsPerBlock;
		printf("  Device Max Number of Compute Indices: %d\n",
			prop.maxGridSize[1] * prop.maxThreadsPerBlock);
		printf("  Memory Bus Width (bits): %d\n",
			prop.memoryBusWidth);
		printf("  Peak Memory Bandwidth (GB/s): %f\n",
			2.0*prop.memoryClockRate*(prop.memoryBusWidth / 8) / 1.0e6);
		printf("  Compute Capability : %d.%d\n", prop.major, prop.minor);
		printf("  Device has %d SMs\n", prop.multiProcessorCount);
		printf("  This device can run multiple kernels simultaneously : %d \n\n",
			prop.concurrentKernels);
		

	}
	printf("3 different files final update\n");
	//data grab routine *************************************************************************************
	//command line arguments parser--------------------------------------------------------------------------

	char *inputFile = NULL;
	char *classFile = NULL;
	char *genesetFile = NULL;
	//limits the number of parents a node can have
	int parentCap = 0;
	//number of permutations
	int perms = 0; // 1 permutation
	double pw = 1.0; //default - no prior weight
	double pThreshold = .05; //default value

	//-d for input
	//-g for geneset
	//-c for class
	//-mp for max parents
	//-p for p threshold value
	//-r number of permutations
	//-pw prior weight = [0,1]
	//loop through argv, determining location of each arg parameter
	for (int i = 1; i < argc; i++)
	{
		if (strcmp(argv[i], "-d") == 0)
			inputFile = argv[i + 1];
		else if (strcmp(argv[i], "-g") == 0)
			genesetFile = argv[i + 1];
		else if (strcmp(argv[i], "-c") == 0)
			classFile = argv[i + 1];
		else if (strcmp(argv[i], "-mp") == 0)
			parentCap = atoi(argv[i + 1]);
		else if (strcmp(argv[i], "-help") == 0 || strcmp(argv[i], "--help") == 0)
			printf("Required arguments : \n -d input.txt\n -c classfile.txt\n -g geneset.txt -mp # of parents\n -p pvalue for independence testing\n");
		else if (strcmp(argv[i], "-r") == 0)
			perms = atoi(argv[i + 1]);
		else if (strcmp(argv[i], "-pw") == 0)
			pw = atof(argv[i + 1]);
		else if(strcmp(argv[i], "-p") == 0)
			pThreshold = atof(argv[i+1]);
	}

	
	
	
	
	//set to defaults if no arguments are included
	if (inputFile == NULL)	{ printf("Invalid input file entered. Exiting...\n"); exit(EXIT_FAILURE); }
	if (classFile == NULL)	{ printf("Invalid class file entered. Exiting...\n"); exit(EXIT_FAILURE); }
	if (genesetFile == NULL)	{ printf("Invalid geneset file entered. Exiting...\n"); exit(EXIT_FAILURE); }
	printf("%s\n", genesetFile);
	if(pThreshold < 0.0 || pThreshold > 1.0)
	{
		pThreshold = .05; //default if out of range
	}
	printf("p Threshold  = %f\n", pThreshold); 
	//set maxparents to default 3 if not set in command line arguments
	if (parentCap <= 0)
	{
		//should normally be run with 3 which will make it for a total of 4
		parentCap = 3;
	}
	printf("Max parents = %d\n", parentCap);
	const int MAX_PARENTS = parentCap;
	if (perms <= 0)
	{
		perms = 100; //default
	}
	printf("Permutations = %d\n", perms);
	if (pw < 0.0 || pw > 1.0)
	{
		pw = 1.0; //no prior knowledge
	}
	printf("pw : %f\n", pw);
	//end command line parser---------------------------------------------------------------------------------------

	//expression data
	FILE *fp = fopen(inputFile, "r");
	
	//class 
	FILE *fp2 = fopen(classFile, "r");

	//FILE * fp3 = fopen("geneset10.txt", "r");
	FILE *fp3 = fopen(genesetFile, "r");

	FILE *results = fopen("results.txt", "w");
	

	//check that files are working
	if (fp == NULL)	{ printf("Expression file is NULL. error number is : %d\n", strerror(errno)); exit(EXIT_FAILURE); }
	if (fp2 == NULL){ printf("Class File File is NULL. error number is : %d\n", strerror(errno)); exit(EXIT_FAILURE); }
	if (fp3 == NULL){ printf("Gene List File is NULL. error number is : %d\n", strerror(errno)); exit(EXIT_FAILURE); }
	if (results == NULL){ printf("results file is NULL. error number is : %d\n", strerror(errno)); exit(EXIT_FAILURE); }
	

	//allocate memory for file reads
	char buf[200000];
	int numsamples = 0;
	int numgenes = 0, genesetlength = 0;
	int numclass1, numclass2;
	char sampnames[5000][50];
	char classnames[5000][50];
	char genesetgenes[100][40];
	int classids[5000];
	char class1[50], class2[50];
	char genenames[20500][16]; //used to be [20000][10]- not big enough --> changed stack size to 1.5MB
	int genesetindexintodata[200]; //updated size from 50 to accomodate more genes
	//int classindexintodata[100][2];
	int i, j;// , index;
	//int jindex1, jindex2;
	int *data;
	int *transferdata1;
	int *transferdata2;
	char *token;


	//loads expression file into buffer
	fgets(buf, sizeof(buf), fp);
	token = strtok(buf, "\t");
	token = strtok(NULL, "\t");

	// Skip first word "Genelist"
	//load  samplenames from buffer and count number of samples
	while (token != NULL) {
		strcpy(sampnames[numsamples], token);
		numsamples++;
		token = strtok(NULL, "\t");
	}

	for (int i = 0; i < numsamples; i++) {
		// Get rid of extra empty "sample" caused by trailing tab
		if (strlen(sampnames[i]) == 1) numsamples--;
	}

	printf("%d samples\n", numsamples);

	while (fgets(buf, sizeof(buf), fp)) {
		token = strtok(buf, "\t");
		strcpy(genenames[numgenes], token);
		//    printf("%s\n", genenames[numgenes]);
		numgenes++;
	}

	numgenes--;
	printf("%d genes\n", numgenes);

	data = (int *)malloc(numgenes*numsamples*sizeof(int));
	//reset file position to 0
	fseek(fp, 0, 0);
	// Skip first line
	fgets(buf, sizeof(buf), fp);
	for (i = 0; i < numgenes; i++) {
		fgets(buf, sizeof(buf), fp);
		token = strtok(buf, "\t");
		for (j = 0; j < numsamples; j++) {
			token = strtok(NULL, "\t");
			assert(i * numsamples + j < numgenes * numsamples);
			sscanf(token, "%d", &data[i*numsamples + j]);
		}
	}

	fclose(fp);
	fgets(buf, sizeof(buf), fp2);
	token = strtok(buf, "\t");
	for (i = 0; i < numsamples; i++) {
		strcpy(classnames[i], token);
		token = strtok(NULL, "\t");
	}
	for (i = 1; i < numsamples; i++) {
		if (strcmp(classnames[i], classnames[0])) break;
	}
	strcpy(class1, classnames[0]);
	strcpy(class2, classnames[i]);
	numclass1 = 0;
	numclass2 = 0;

	//check if classfile had newline character at end of final classname, preventing 
	//strcmp from working
	if (classnames[numsamples - 1][strlen(classnames[numsamples - 1]) - 1] == '\n')
	{
		classnames[numsamples - 1][strlen(classnames[numsamples - 1]) - 1] = '\0';
	}

	for (i = 0; i < numsamples; i++) {
		if (!strcmp(classnames[i], class1)) {
			numclass1++;
			classids[i] = 0;

		}
		if (!strcmp(classnames[i], class2)) {
			numclass2++;
			classids[i] = 1;
		}

	}

	//should this be done? when reading in CTRP sample data not all classids are filled
	//this leads to a problem when reshuffling them later - only finding 201/202 supposed samples
	/*int revisedSamples = 0;
	for (int i = 0; i < numsamples; i++)
	{
		if (classids[i] == 1 || classids[i] == 0)
		{
			revisedSamples++;
		}
	}
	printf("revised : %d original : %d\n", revisedSamples, numsamples);
	numsamples = revisedSamples;*/

	//  printf("\n");
	printf("Classes: %d %s, %d %s\n", numclass1, class1, numclass2, class2);
	fclose(fp2);
	clock_t cpuTime = clock(), diff;
	//-----------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	fprintf(results, "%s\t %s\t %s\t\n", class2, "JS", "P");
	while (fgets(buf, sizeof(buf), fp3))
	{
		//check if beginning of file is newline
		if (buf[0] == '\n')
		{
			continue;
		}
		//ensures that classids are restored to a preshuffled state
		//for the first run of each pathway before permutations begin
		for (int k = 0; k < numsamples; k++)
		{
			if (strcmp(classnames[k], class1) == 0)
			{
				classids[k] = 0;
			}
			if (strcmp(classnames[k], class2) == 0)
			{
				classids[k] = 1;
			}

		}

		char *pathwayName = strtok(buf, "\n");
		//fgets(buf, sizeof(buf), fp3);
		//token = strtok(buf, "\t");
		token = strtok(pathwayName, "\t");
		token = strtok(NULL, "\t");
		// Get first word "Geneset"
		token = strtok(NULL, "\t");
		// Skip second word "URL"
		genesetlength = 0;
		while (token != NULL) {
			strcpy(genesetgenes[genesetlength], token);
			genesetlength++;
			token = strtok(NULL, "\t");
		}

		printf("%s\n", pathwayName);
		
		//-------------------------------------------------------------------------
		// Get rid of trailing carriage return on last gene name
		//no longer needed because strok with pathwayName eliminates newline character
		//genesetgenes[genesetlength - 1][strlen(genesetgenes[genesetlength - 1]) - 1] = '\0';

		printf("%d genes in geneset\n", genesetlength);
		//fclose(fp3);

		//should this be moved to after adjusting genesetlength?
		//transferdata1 = (int *)malloc(genesetlength*numclass1*sizeof(int));
		//transferdata2 = (int *)malloc(genesetlength*numclass2*sizeof(int));
		
		//accounts for any missing/extra genes
		int indexPos = 0;
		for (i = 0; i < genesetlength; i++) {
			int flagFound = 0;
			genesetindexintodata[i] = -1;
			for (j = 0; j < numgenes; j++) {
				if (!strcmp(genenames[j], genesetgenes[i])) {
					flagFound = 1;
					//fill genesetgenes only with genes that are being evaluated
					strcpy(genesetgenes[indexPos], genenames[j]);
					genesetindexintodata[indexPos] = j;
					break;
				}
			}
			//	printf ("Gene %d index: %d %d %s %s\n",i,genesetindexintodata[i],j,genenames[genesetindexintodata[i]],genesetgenes[i]);
			if (flagFound)
			{
				indexPos++;
			}
		}
		transferdata1 = (int *)malloc(genesetlength*numclass1*sizeof(int));
		transferdata2 = (int *)malloc(genesetlength*numclass2*sizeof(int));
		//delete genes that shouldn't be in gene list
		for (int k = indexPos; k < genesetlength; k++)	{ genesetgenes[k][0] = '\0'; }
		//adjust # of genes
		genesetlength = indexPos;
		printf("Adjusted genes : %d\n", genesetlength);
		
		
		//prior knowledge load data into binary matrix-------------------------------------------------------------
		
		int *priorMatrix = (int *)calloc(genesetlength * genesetlength, sizeof(int)); //array to hold prior knowledge matrix

		//look into \PRIORS folder
		char directory[300];; //directory for prior files
		strcpy(directory, DIR); //load folder path depending on if unix or windows
		char fileName[1000]; //name of prior file
		strcpy(fileName, pathwayName);
		strcat(fileName, ".prior"); //take pathwayname and add .prior to get file path
		strcat(directory, fileName);
		if(strstr(directory, "\r") != NULL){
			printf("File problem! Uses window endings!\n");
		}
		
		FILE *priorFile = fopen(directory, "r"); //open prior knowledge file
		printf("file : %s\n", directory);
		int priorFlag = 1; //1 = files found 0 = no file found
		if (priorFile == NULL)
		{
			printf("No prior file exists. Computing without prior knowledge\n");
			priorFlag = 0;
		}
		//fill prior Matrix
		char priorBuffer[100];
		while (priorFlag && fgets(priorBuffer, sizeof(priorBuffer), priorFile))
		{
			char *tok = strtok(priorBuffer, "\t");
			//printf("gene1 : %s\n", tok);
			int insideFlag = 0;
			int row = -1, col = -1;
			for (int k = 0; k < genesetlength; k++)
			{
				if (strcmp(genesetgenes[k], tok) == 0)
				{
					insideFlag = 1;
					row = k;
					break;
				}
			}

			if (insideFlag == 0)
				continue;
			tok = strtok(NULL, "\t");
			//printf("relationship : %s\n", tok);
			if (strcmp(tok, "neighbor-of") == 0)
			{
				continue;
			}
			tok = strtok(NULL, "\t");
			tok[strlen(tok) - 1] = '\0';
			//printf("gene2 : %s\n", tok);
			insideFlag = 0;
			for (int k = 0; k < genesetlength; k++)
			{
				if (strcmp(genesetgenes[k], tok) == 0)
				{
					insideFlag = 1;
					col = k;
					break;
				}
			}
			if (insideFlag == 0)
				continue;
			assert(row > -1 && col > -1 && row < genesetlength && col < genesetlength);
			*(priorMatrix + row * genesetlength + col) = 1;
			*(priorMatrix + col * genesetlength + row) = 1;
		}

		if (priorFlag == 1) //only try closing file if it was open to begin with
		{
			fclose(priorFile);
		}
			
		//begin permutation loop
		int n;
		int x;

		//stores js values across permutations for p value calcs
		double *jsVals = (double *)malloc(sizeof(double) * perms);
		//int *triAry2;
		//int *triAry3;
		//used to print network/bdeu score files
		int first_unisum;
		int first_scaler;
		int *first_uniNodes;
		int *first_uniEdges;
		int *first_uniEpn;
		double *first_lval1 = NULL;
		int first_numEdges;
		int *uniqueNetIds = NULL;
		//used to calculate edgeList without parent limit after permuatations finished - stores 1st permutation data
		int *edgeListData1 = NULL;
		int *edgeListData2 = NULL;
		//int *initialSpacr = NULL;
		//int *initialFF = NULL;
		int *initialSearcher = NULL;
		//number range of random numbers needed [0,mems)
		int mems = numsamples;

		float totalTime;
		cudaEvent_t begin, end;
		cudaEventCreate(&begin);
		cudaEventCreate(&end);

		for (int permNum = 0; permNum < perms; permNum++)
		{
			n = 0;
			
			int *randNums = (int *)malloc(sizeof(int) * numsamples);
			for (int c = 0; c < mems; c++) {
				randNums[c] = rand() % mems;
			}
			while (n < mems) {
				int r = rand() % mems;

				for (x = 0; x < n; x++)
				{
					if (randNums[x] == r){
						break;
					}
				}
				if (x == n){
					randNums[n++] = r;
				}
			}

			

			//after first permutation scramble samplings
			if (permNum > 0)
			{
				for (int counter = 0; counter < numclass1; counter++)
				{
					assert(counter < numsamples);
					classids[randNums[counter]] = 0;
				}
				for (int counter = numclass1; counter < numsamples; counter++)
				{
					assert(counter < numsamples);
					classids[randNums[counter]] = 1;
				}
			}
				
			
			
			free(randNums); randNums = NULL;
			
			//sort data into class1 and class 2
			int index = 0;
			for (i = 0; i < genesetlength; i++) {
				if (genesetindexintodata[i] == -1) {
					i++;
				}

				int jindex1 = 0;
				int jindex2 = 0;
				for (j = 0; j < numsamples; j++) {
					/*if (j == 4268 || j = 4 || classids[j] == -858993460)
					{
					printf("bad value in classids accessed @ %d with value of %d\n", i, classids[j]);
					}*/
					if (classids[j] == 0) {
						assert(index * numclass1 + jindex1 < numclass1 * genesetlength);//transferdata
						assert(genesetindexintodata[i] * numsamples + j < numgenes * numsamples); //data
						transferdata1[index*numclass1 + jindex1] = data[genesetindexintodata[i] * numsamples + j];
						jindex1++;
						//			printf("%d ",transferdata1[index*numclass1+jindex1]);
					}
					if (classids[j] == 1) {
						assert(index*numclass2 + jindex2 < numclass2 * genesetlength);//transferdata
						assert(genesetindexintodata[i] * numsamples + j < numgenes * numsamples); //data
						transferdata2[index*numclass2 + jindex2] = data[genesetindexintodata[i] * numsamples + j];
						jindex2++;
					}
				}
				//	printf("\n");
				index++;
			}

			//dead code never run
			//while (fgets(buf, sizeof(buf), fp)) {
			//	token = strtok(buf, "\t");
			//	strcpy(genenames[numgenes], token);
			//	//    printf("%s\n", genenames[numgenes]);
			//	numgenes++;
			//}
			//printf("Data Grab Done\n");
			int genes = genesetlength;
			//end data grab routine ******************************************************************************
			//samples sizes in both classes


			//start timing- Tomas
			cudaEventRecord(begin, 0);



			int samples = numclass1;
			int samples2 = numclass2;

			int c = (((genes*genes) - genes) / 2);

			int scaler = (samples + 1);
			int scaler2 = (samples2 + 1);
			int scalerSum = scaler + scaler2;
			
			//int pos = 0;
			//int posrr = 0;
			//transfer data for processing
			//triAry2 = transferdata1;
			//triAry3 = transferdata2;
			//int arypos = 0;
			//int hold = 0;
			//int spacer = 0;
			//int len = genes;
			
			int* spacer1;//dyn
			spacer1 = (int *)malloc(c*sizeof(int));
			int* ff1;//dyn
			int *searcher;
			ff1 = (int *)malloc(c*sizeof(int));
			searcher = (int *)malloc(genes*sizeof(int));


			//following block of code determines diaganol representation of data matrix
			//searcher[0] = 0;
			//int diff = 0;
			//for (spacer = 0; spacer <= len + 1; spacer++)
			//{
			//	hold = len*spacer;
			//	for (int f = spacer + 1; f < len; f++)
			//	{
			//		spacer1[arypos] = f;
			//		ff1[arypos] = spacer;
			//		arypos++;
			//	}
			//	if (spacer > 0 && spacer < len){
			//		//diff = genes - spacer;
			//		diff = spacer;
			//		printf("diff : %d\n", diff);
			//		searcher[spacer] = searcher[spacer - 1] + diff;
			//	}
			//}
			//for (int i = 0; i < genes; i++)
			//{
			//	printf("searcher[%d] : %d\n", i, searcher[i]);
			//}

			//determines diaganol representation of data matrix
			searcher[0] = 0;
			int position = 0;
			for (int row = 1; row < genes; row++)
			{
				for (int col = 0; col < row; col++)
				{
					assert(position < c);
					spacer1[position] = row;
					//printf("spacer1[%d] : %d\n", position, spacer1[position]);
					ff1[position] = col;
					position++;
					
					
				}
				if (row > 0)
				{
					assert(row < genes);
					searcher[row] = searcher[row - 1] + row;
				}
			}
			
			
			
			//if first permutation store spacr, ff, searcher to use in edgeList calcs after permutations
			if (permNum == 0)
			{
				//initialSpacr = (int *)malloc(sizeof(int) * c);
				//initialFF = (int *)malloc(sizeof(int) * c);
				initialSearcher = (int *)malloc(sizeof(int) * genes);
				//memcpy(initialSpacr, spacer1, sizeof(int) * c);
				//memcpy(initialFF, ff1, sizeof(int) * c);
				memcpy(initialSearcher, searcher, sizeof(int) * genes);
			}

			//start cuda time
			cudaEvent_t start, stop;
			float time;
			cudaEventCreate(&start);
			cudaEventCreate(&stop);


			///cuda launch 1***************************************************************************
			//holds edge data in binary format
			//int onesSize = sizeof(double) * c * scalerSum;
			int *edgesPN;
			edgesPN = (int *)malloc(sizeof(int)* (scalerSum + 1));

			//device copies for out23 and edgesPN
			int *dout23;
			int *dedgesPN;

			//device copies
			int *dtriA, *ddofout, *dtriAb, *dppn, *dstf;
			int *dff, *dspacr;
			//double *d_ones;
			int *dpriorMatrix;
			
			//mem sizes required
			int size2 = c*((samples2 + 1) + (samples + 1))*sizeof(int);
			//int size3 = c*((samples2 + 1) + (samples + 1))*sizeof(double);
			//need to malloc stuff before we can use it
			////space alloc for device
        		HANDLE_ERROR(cudaMalloc((void **)&dtriA, genesetlength*samples*sizeof(int)));
        		HANDLE_ERROR(cudaMalloc((void **)&dtriAb, genesetlength*samples2*sizeof(int)));
        		HANDLE_ERROR(cudaMalloc((void **)&dppn, genesetlength * 2 * sizeof(int)));
        		HANDLE_ERROR(cudaMalloc((void **)&dstf, genesetlength * 2 * 3 * sizeof(int)));
        		HANDLE_ERROR(cudaMalloc((void **)&ddofout, size2));
        		HANDLE_ERROR(cudaMalloc((void **)&dff, c*sizeof(int)));
        		HANDLE_ERROR(cudaMalloc((void **)&dspacr, c*sizeof(int)));
        		HANDLE_ERROR(cudaMalloc((void **)&dout23, sizeof(int) * c * scalerSum));
        		HANDLE_ERROR(cudaMalloc((void **)&dedgesPN, sizeof(int) * (scalerSum + 1)));
        		HANDLE_ERROR(cudaMalloc((void **)&dpriorMatrix, sizeof(int) * genesetlength * genesetlength));			
			int dppnLength = genesetlength * 2;
			int sampleSum = calculate_edges(scalerSum, samples, samples2, genesetlength, size2, c, genes, transferdata1, transferdata2, ff1, priorMatrix, spacer1, start, stop, time, pw, edgeListData1, edgeListData2, dout23, dedgesPN, dtriA, dtriAb, ddofout, dppn, dstf, dff, dspacr, dpriorMatrix, numclass1, numclass2, permNum);
			cudaError_t errSync = cudaGetLastError();






			//device copy
			int *dsrchAry;//, *tempEdgesSums;
			HANDLE_ERROR(cudaMalloc((void **)&dsrchAry, genes * sizeof(int)));
			HANDLE_ERROR(cudaMemcpy(dsrchAry, searcher, genes * sizeof(int), cudaMemcpyHostToDevice));
			//tempEdgesSums = (int *)calloc(sampleSum + 1, sizeof(int));

			free(searcher); searcher = NULL;

			cudaEvent_t PN_start, PN_stop;
			cudaEventCreate(&PN_start);
			cudaEventCreate(&PN_stop);
			cudaEventRecord(PN_start, 0);
			float PN_time;

			count_edges(dsrchAry, PN_start, PN_stop, PN_time, dout23, dedgesPN, genes, MAX_PARENTS, c, scalerSum, edgesPN, errSync, sampleSum);
			



			HANDLE_ERROR(cudaFree(dpriorMatrix)); dpriorMatrix = NULL;
			HANDLE_ERROR(cudaFree(ddofout)); ddofout = NULL;
			HANDLE_ERROR(cudaFree(dff)); dff = NULL;
			HANDLE_ERROR(cudaFree(dspacr)); dspacr = NULL;//cudaFree(dtriA); cudaFree(dtriAb);-used later in run4
			/***********************************************************************************************************************************************************/
			//total number of edges
			int numEdges = edgesPN[scalerSum];

			//run22 launch- create parent graphs
			int noNodes = genesetlength;
			//host copies
			int *pNodes, *pEdges;


			//dev copies
			int *dpEdges, *dpNodes;

			//mem reqs
			int nodeSize = sizeof(int)*(noNodes*(scalerSum));
			int edgeSize = sizeof(int)*numEdges;


			//space alloc for device
			HANDLE_ERROR(cudaMalloc((void **)&dpEdges, edgeSize));
			HANDLE_ERROR(cudaMalloc((void **)&dpNodes, nodeSize));


			//space alloc for host
			pNodes = (int *)malloc(nodeSize);
			pEdges = (int *)malloc(edgeSize);
			build_graph(scalerSum, noNodes, c, dedgesPN, dout23, dpNodes, numEdges, dsrchAry, dpEdges, MAX_PARENTS, pNodes, pEdges, nodeSize, edgeSize);
			
			HANDLE_ERROR(cudaFree(dsrchAry)); dsrchAry = NULL;
			HANDLE_ERROR(cudaFree(dout23)); dout23 = NULL;
			//end run 22**********************************************************************************************/


			int scalerCombo = (scalerSum*scalerSum - scalerSum) / 2;
			//host
			int *scalerTest; //compare value
			int *shrunk;
			int *shrunkPlc; //compare to
			scalerTest = (int *)malloc(sizeof(int)*scalerCombo);
			shrunk = (int *)malloc(sizeof(int)*scalerCombo);
			shrunkPlc = (int *)malloc(sizeof(int)*scalerCombo);
			int *dshrunk;
			int *dscalerTest;
			int *dshnkplc;
			HANDLE_ERROR(cudaMalloc((void**)&dshrunk, sizeof(int)*scalerCombo));
			HANDLE_ERROR(cudaMalloc((void**)&dscalerTest, sizeof(int)*scalerCombo));
			HANDLE_ERROR(cudaMalloc((void**)&dshnkplc, sizeof(int)*scalerCombo));


			mark_duplicate_networks(scalerSum, scalerCombo, scalerTest, shrunkPlc, shrunk, dshrunk, dscalerTest, dshnkplc, maxThreads, samples, numEdges, genesetlength, dedgesPN, dpNodes, dpEdges);


			bool *uniqueN, *visted;

			//routine for creatation of unique structures 
			uniqueN = (bool *)malloc(sizeof(bool)*scalerSum);

			uniqueN[0] = true;
			visted = (bool *)malloc(sizeof(bool)*scalerSum);
			visted[0] = true;

			
			for (int p = 0; p < scalerSum; p++){
				visted[p] = false;
			}
			for (int p = 0; p < scalerCombo; p++){
				assert(scalerTest[p] < scalerSum);
				if (visted[scalerTest[p]] == true){
					continue;
				}
				else
				{
					if (shrunk[p] == 0){
						uniqueN[scalerTest[p]] = false;
						visted[scalerTest[p]] = true;
					}
					else
					{
						uniqueN[scalerTest[p]] = true;
					}
				}


			}
			//grab network ids from 1st permutation before unique graphs are identified- used when network file is written
			if (permNum == 0)
			{
				uniqueNetIds = (int *)malloc(sizeof(int) * scalerSum);
				int counter = 0;
				for (int i = 0; i < scalerSum; i++)
				{
					if (uniqueN[i])
					{
						uniqueNetIds[counter++] = i;
					}
				}
				uniqueNetIds = (int *)realloc(uniqueNetIds, counter * sizeof(int));
			}


			free(scalerTest); scalerTest = NULL;
			free(shrunk); shrunk = NULL;
			free(visted); visted = NULL;

			int unisum = 0;
			int edSum = 0;
			//should it be scalerSum or scalerSum + 1?
			for (int p = 0; p < scalerSum; p++){

				if (uniqueN[p] == 1){
					unisum++;
					if (p == scalerSum - 1){
						assert(p < scalerSum + 1);
						edSum = edSum + (numEdges - edgesPN[p]);

					}
					else
					{
						assert(p < scalerSum + 1);
						edSum = edSum + edgesPN[p + 1] - edgesPN[p];

					}
				}
			}

			if (permNum == 0)
			{
				printf("Original Number of unique Networks : %d\n", unisum);
			}
			
			//printf("Number of unique networks : %d\n edSum : %d\n numEdges : %d\n edgesPN : %d\n", unisum, edSum, numEdges, edgesPN[scalerSum]);
			//**********************************restructure all **************************************************
			//printf("edSum %d numEdges %d\n", edSum, numEdges);
			int *pUniNodes, *pUniEdges, *pUniEpn;
			//space alloc
			pUniNodes = (int *)malloc(sizeof(int)*unisum*noNodes);
			pUniEdges = (int *)malloc(sizeof(int)*edSum);
			int uniEpnSize = unisum + 1;
			//pUniEpn = (int *)malloc(sizeof(int)*unisum + 1);
			pUniEpn = (int *)malloc(sizeof(int) * uniEpnSize);
			//printf("size of pUniEpn : %d\n", uniEpnSize);


			structureUnique(unisum, numEdges, scaler, scalerSum, noNodes, uniqueN, edgesPN, pEdges, pNodes, pUniEdges, pUniNodes, pUniEpn);
			

			free(edgesPN); edgesPN = NULL;
			free(pNodes); pNodes = NULL;
			free(pEdges); pEdges = NULL;
			free(uniqueN); uniqueN = NULL;

			//ensure parent limit
			checkParentLimit(unisum, noNodes, MAX_PARENTS, pUniNodes, unisum * noNodes);


			if (permNum == 0)
			{
				//store graph data for network file write after permutations finished
				//first_uniEpn = (int *)malloc(sizeof(int) * unisum);
				first_uniEpn = (int *)malloc(sizeof(int) * uniEpnSize);
				first_uniNodes = (int *)malloc(sizeof(int) * unisum * noNodes);
				first_uniEdges = (int *)malloc(sizeof(int) * edSum);
				memcpy(first_uniEpn, pUniEpn, unisum * sizeof(int));
				memcpy(first_uniNodes, pUniNodes, unisum * noNodes * sizeof(int));
				memcpy(first_uniEdges, pUniEdges, edSum * sizeof(int));
				first_numEdges = edSum;
				first_unisum = unisum;

			}



			scaler = unisum;
			if (permNum == 0)	{ first_scaler = scaler; }
			numEdges = edSum;
			int uniNodeSize = sizeof(int)*(noNodes*unisum);
			int uniEdgeSize = sizeof(int)*numEdges;

			//cuda run 4(final)*************************************************************************************
			double *out5;

			//dev copies
			//int *dtri1; int *dtri2; 
			double *dout5; int *dpEdges2; int *dpNodes2; int *dNij; int *dNijk;
			int *dUniEpn;
			//space alloc dev
			HANDLE_ERROR(cudaMalloc((void **)&dpEdges2, uniEdgeSize));
			HANDLE_ERROR(cudaMalloc((void **)&dpNodes2, uniNodeSize));
			HANDLE_ERROR(cudaMalloc((void **)&dUniEpn, sizeof(int)*unisum));
			//HANDLE_ERROR(cudaMalloc((void **)&dUniEpn, sizeof(int)*uniEpnSize));
			HANDLE_ERROR(cudaMalloc((void **)&dout5, sizeof(double)*noNodes*scaler * 2));
			HANDLE_ERROR(cudaMalloc((void **)&dNij, sizeof(int)*noNodes*scaler * 54));
			HANDLE_ERROR(cudaMalloc((void **)&dNijk, sizeof(int)*noNodes *scaler * 162));

			//space alloc host
			out5 = (double *)malloc(sizeof(double)*noNodes*scaler * 2);


			score_networks(out5, dout5, dpEdges2, dpNodes2, dNij, dNijk, dUniEpn, uniEdgeSize, uniNodeSize, unisum, noNodes, scaler, pUniEdges, pUniNodes, pUniEpn, genesetlength, edSum, samples, samples2, dtriA, dtriAb, dppn, dstf, dppnLength);

			HANDLE_ERROR(cudaFree(dNij)); dNij = NULL;
			HANDLE_ERROR(cudaFree(dNijk)); dNijk = NULL;
			HANDLE_ERROR(cudaFree(dppn)); dppn = NULL;
			HANDLE_ERROR(cudaFree(dstf)); dstf = NULL;
			HANDLE_ERROR(cudaFree(dout5)); dout5 = NULL;
			HANDLE_ERROR(cudaFree(dpEdges2)); dpEdges2 = NULL;
			HANDLE_ERROR(cudaFree(dpNodes2)); dpNodes = NULL;
			HANDLE_ERROR(cudaFree(dUniEpn)); dUniEpn = NULL;
			HANDLE_ERROR(cudaFree(dtriA)); dtriA = NULL;
			HANDLE_ERROR(cudaFree(dtriAb)); dtriAb = NULL;
			
			cudaError_t last = cudaGetLastError();
			if (last != cudaSuccess)
			{
				printf("%s\n", cudaGetErrorString(last));
			}
			//int div = 0;
			// end final cuda run ***********************************************************************

			// begin divergence calc
			double *lval1;
			lval1 = (double *)malloc(sizeof(double)*scaler * 2);

			for (int i = 0; i < scaler * 2; i++)
			{
				lval1[i] = 0.0;

			}

			// compute likelihood of different dataset parsed by 2 iterations 
			compute_likelihood(scaler, noNodes, out5, lval1);
			

			if (permNum == 0)
			{
				first_lval1 = (double *)malloc(sizeof(double) * scaler * 2);
				memcpy(first_lval1, lval1, sizeof(double) * scaler * 2);
			}


			/*******************************************************************************************************************************************/
			double *sea;
			sea = (double*)malloc(sizeof(double)*scaler);

			//scaler unique number of networks
			for (int i = 0; i < scaler; i++)
			{
				sea[i] = (lval1[i] + lval1[i + scaler]) / 2;

			}

			double js = 0;
			double logger = log(2.0);

			//final score
			js = kool(lval1, sea, 0, scaler) / 2 + kool(lval1, sea, scaler, scaler) / 2;
			assert(permNum < perms);
			jsVals[permNum] = js / logger;

			if (isnan(jsVals[0]))
			{
				printf("jsVal[0] NAN--Breaking permutation loop\n");
				jsVals[0] = -999.0;
				break;
			}
			
			
			

			cudaEventRecord(stop, 0);
			cudaEventSynchronize(stop);

			cudaEventElapsedTime(&time, start, stop);


			free(sea); sea = NULL;
			free(out5); out5 = NULL;
			free(lval1); lval1 = NULL;

			if (permNum % 100 == 0)
			{
				//print every 100 permutations
				printf("Permutation %d finished\n", permNum);
			}

		}//---------------------------------------------------------------------------
		//for loop ends for permutations.
		printf("permutation loop finished\n");
		//free prior knowledge matrix- no longer needed
		
		int nanFlag = 0;
		for (int i = 0; i < perms; i++)
		{
			if (isnan(jsVals[i]))
			{
				nanFlag = 1;
				break;
			}
		}
		if (jsVals[0] < 0 || nanFlag)
		{
			//fprintf(results, "%s %s\n", pathwayName, "GARBAGE VALUE-NAN");
			fprintf(results, "%s failed with %d genes- one of the js scores was nan\n", pathwayName, genesetlength);
			printf("nan value- quiting!\n");
			continue;
		}
		printf("\n\n\n\npermutations finished\n");
		//count how many js values are larger than initial run
		printf("Original JS : %f\n", jsVals[0]);

		double p = 0;
		
		if (perms > 0)
		{
			double mu = mean(jsVals, perms);
			double var = variance(mu, jsVals, perms);
			double alpha = (((1 - mu) / var) - (1 / mu)) * pow(mu, 2);
			double beta = alpha * (1 / mu - 1);
			printf("alpha : %f beta : %f\n", alpha, beta);
			p = boost::math::ibetac(alpha, beta, jsVals[0]);

			printf("p = %f\n", p);
			fprintf(results, "%s %f %f %d\n", pathwayName, jsVals[0], p, genesetlength);
		}
		
		if (p < pThreshold) //statistically significant
		{
			
			char networkFilePath[600];
			strcpy(networkFilePath, pathwayName);
			strcat(networkFilePath, "_Networks.txt");
			char bdeuFilePath[600];
			strcpy(bdeuFilePath, pathwayName);
			strcat(bdeuFilePath, "_BDEU_SCORES.txt");

			writeNetworkFile(networkFilePath, inputFile, classFile, pathwayName, first_unisum, first_uniEpn, genesetgenes, genesetlength, first_uniNodes, first_uniEdges, first_numEdges, uniqueNetIds);
			writeBdeuScores(bdeuFilePath, inputFile, classFile, pathwayName, class1, class2, first_scaler, first_lval1);


			//-----------------------------------------------------
			//edgeList calcs
			//edgesPerNetworkKernel --> run22 --> output Edge list
			//NOTE: genesetlength is used to represent the number of nodes aka noNodes as used in prior kernel calls
			//printf("Final run\n");

			//2 networks are being looked at and c = number of different gene combinations
			int c = (((genesetlength*genesetlength) - genesetlength) / 2);
			int numNetworks = 2;

			//host copies
			int *nodes, *edges, *out23;
			int edgesPN[3];

			out23 = (int *)malloc(sizeof(int) * c * numNetworks);

			//dev copies
			int *dout23, *dsrchAry, *dEdgesPN;

			//copy data taken from first run2 permutation
			int *ptr1 = &out23[0];
			int *ptr2 = &out23[c];
			memcpy(ptr1, edgeListData1, sizeof(int) * c);
			memcpy(ptr2, edgeListData2, sizeof(int) * c);
			ptr1 = NULL;
			ptr2 = NULL;

			//allocate device memory and copy
			HANDLE_ERROR(cudaMalloc((void **)&dout23, sizeof(int) * c * numNetworks));
			HANDLE_ERROR(cudaMalloc((void **)&dEdgesPN, sizeof(int) * (numNetworks + 1)));
			HANDLE_ERROR(cudaMalloc((void **)&dsrchAry, genesetlength * sizeof(int)));

			HANDLE_ERROR(cudaMemcpy(dout23, out23, sizeof(int) * c * numNetworks, cudaMemcpyHostToDevice));
			HANDLE_ERROR(cudaMemcpy(dsrchAry, initialSearcher, genesetlength * sizeof(int), cudaMemcpyHostToDevice));

			const int PARENTS_LIMIT = INT_MAX;
			
			//edgePerNetworkKernel << <numNetworks + 1, c, (c * sizeof(int)) >> >(dout23, dEdgesPN, dsrchAry, genesetlength, PARENTS_LIMIT, c);
			edgePerNetworkKernel << <numNetworks + 1, 1 >> >(dout23, dEdgesPN, dsrchAry, genesetlength, PARENTS_LIMIT, c);
			//edgePerNetworkKernel << <numNetworks + 1, c, (c * sizeof(int)) + (genesetlength * sizeof(int)) >> >(dout23, dEdgesPN, dsrchAry, genesetlength, PARENTS_LIMIT, c);
			
			//edgePerNetworkKernel calculates sum of edges for each network - now we need to perform the prefix calc for edgesPN on the CPU
			int tempEdgeSum[numNetworks + 1];
			HANDLE_ERROR(cudaMemcpy(tempEdgeSum, dEdgesPN, sizeof(int) * (numNetworks + 1), cudaMemcpyDeviceToHost));
			edgesPN[0] = 0;
			//calc prefix sum
			for(int i = 1; i < numNetworks + 1; i++){
				edgesPN[i] = edgesPN[i-1] + tempEdgeSum[i-1];
			}//copy results of prefix sum back to GPU for use in run22
			HANDLE_ERROR(cudaMemcpy(dEdgesPN, edgesPN, sizeof(int) * (numNetworks + 1), cudaMemcpyHostToDevice));


			//needed to calculate how long to make edge array
			int totalEdges = edgesPN[2];

			nodes = (int *)malloc(sizeof(int) * genesetlength * 2);
			edges = (int *)malloc(sizeof(int) * totalEdges);


			int *dNodes, *dEdges;
			HANDLE_ERROR(cudaMalloc((void **)&dNodes, sizeof(int) * genesetlength * 2));
			HANDLE_ERROR(cudaMalloc((void **)&dEdges, sizeof(int) * totalEdges));

			run22 << <numNetworks, genesetlength >> >(c, dEdgesPN, dout23, dNodes, genesetlength, totalEdges, dsrchAry, dEdges, PARENTS_LIMIT);

			HANDLE_ERROR(cudaMemcpy(nodes, dNodes, sizeof(int) * 2 * genesetlength, cudaMemcpyDeviceToHost));
			HANDLE_ERROR(cudaMemcpy(edges, dEdges, sizeof(int) * totalEdges, cudaMemcpyDeviceToHost));


			HANDLE_ERROR(cudaFree(dout23)); dout23 = NULL;
			HANDLE_ERROR(cudaFree(dsrchAry)); dsrchAry = NULL;
			HANDLE_ERROR(cudaFree(dEdgesPN)); dEdgesPN = NULL;
			HANDLE_ERROR(cudaFree(dNodes)); dNodes = NULL;
			HANDLE_ERROR(cudaFree(dEdges)); dEdges = NULL;
			free(out23); out23 = NULL;

			char edgeListFile[600];
			strcpy(edgeListFile, pathwayName);
			strcat(edgeListFile, "_EdgeList.txt");
			//int networkIds[2] = { 1, 2 };
			//writeNetworkFile(edgeListFile, inputFile, classFile, pathwayName, 2, edgesPN, genesetgenes, genesetlength, nodes, edges, totalEdges, networkIds);
			writeEdgeListFile(edgeListFile, inputFile, classFile, pathwayName, genesetgenes, genesetlength, nodes, edges, edgesPN, priorMatrix, class1, class2);
			
			cudaEventRecord(end, 0);
			cudaEventSynchronize(end);
			cudaEventElapsedTime(&totalTime, begin, end);

			//printf("Total Run Time : %f\n", totalTime);

			printf("Total run time : %f\n", totalTime);
			free(nodes); nodes = NULL;
			free(edges); edges = NULL;
		}

		printf("\nPathway finished.\n\n");
		free(priorMatrix); priorMatrix = NULL; //free this after writing files b/c needed for writeEdgeListFile

		diff = clock() - cpuTime;
		int msec = diff * 1000 / CLOCKS_PER_SEC;
		printf("Time taken %d seconds %d milliseconds\n", msec / 1000, msec % 1000);
		//---------------------------------------------------------------------------
		//free variables

		

		free(transferdata1);
		free(transferdata2);
		transferdata1 = NULL;
		transferdata2 = NULL;

		free(first_lval1);
		free(first_uniNodes);
		free(first_uniEdges);
		free(first_uniEpn);
		free(jsVals);
		free(uniqueNetIds);
		free(edgeListData1);
		free(edgeListData2);
		free(initialSearcher);
		first_lval1 = NULL;
		first_uniNodes = NULL;
		first_uniEdges = NULL;
		first_uniEpn = NULL;
		jsVals = NULL;
		uniqueNetIds = NULL;
		edgeListData1 = NULL;
		edgeListData2 = NULL;
		initialSearcher = NULL;

	}
	fclose(fp3);
	fclose(results);

	free(data);
	data = NULL;

	return 0;
}
