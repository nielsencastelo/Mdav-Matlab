void BuscaLocal::run()
{
    
    //Enquanto retornar 1, ou seja, enquanto tiver movimentos pra fazer, faça.
    while(FirstImprov()); //Metodo First Improvement
    //while(BestImprov()); //Metodo Best Improvement
	
    cout << cont << endl;
	
	//Calculo do IL.
    float SST = Calcular_SST();
    float SSE = Calcular_SSE(GruposValidados);
    float IL = (SSE/SST)*100.0;

    cout << "Novo IL: " << IL << endl;
	
	//Validação simples para saber se os grupos possuem tamanho menor que g.
    for(int i = 0; i<GruposValidados.size(); i++)
    {
        Cluster * CL = GruposValidados[i];

        if(CL->subdados.size()<g)
        {
            cout << "Grupo " << i << " possui tamanho menor que " << g << endl;
        }
    }

}

//Metodo First Improvement
int BuscaLocal::FirstImprov()
{
    int flag_mov = 0; //Flag de retorno de movimento, se fizer movimento sera retornado 1 para que volte novamente ao metodo.
  
	/*
	 *  GruposValidados possui os grupos validados pelo v-mdav, tais grupos possuem referencias aos grupos de n'
	 */
  
    //Iniciar processo de custo de movimento
    for(int i = 0; i<GruposValidados.size();i++)
    {
        Cluster * CL_A = GruposValidados[i]; //Recupera um grupo dos validados. (Grupo A)
		//Se gRed = -1, significa que o grupo nao possui grupos de n' associados.
        //Se o grupo A possuir elementos de n', faça:
        if(CL_A->gRed!=-1)
        {
            for(int j = 0; j<GruposValidados.size(); j++)
            {
                Cluster * CL_B = GruposValidados[j]; //Recupera um grupo dos validados. (Grupo B)
                if(i!=j) //nao fazer test com ele mesmo.
                {
                    Cluster * CL_Red = GruposReduzidos[CL_A->gRed]; //Recupera o grupo n' do grupo A.
                    int tamA = CL_A->subdados.size() - CL_Red->subdados.size(); //Tamanho do grupo A sem o grupo de n'
                    if(tamA >= g) //Se tamanho do grupo A atender o criterio do g, calcule o custo.
                    {
                        float custo = CustoMovimento(CL_A, CL_B); //Custo do Movimento do grupo de n' de A para B.
                        if(custo < 0) // Se o custo for negativo, faça o movimento.
                        {
                            FazerMovimento(CL_A, CL_B); //Fazer movimento de n' de A para B.
                            flag_mov = 1; //Ativa o flag de retorno.
                            break; //Sai do laço j, pois grupo A nao possui mais grupo n' associado.
                        }
                    }

                }
            }//fim laço J.
        }
    }

    return flag_mov; //Retorna flag de movimento.
}

//Metodo de custo de moivmento
float BuscaLocal::CustoMovimento(Cluster *GrupoA, Cluster *GrupoB)
{
    float custo = 0.0; //Inicializa o custo

    Cluster * CL_Red = GruposReduzidos[GrupoA->gRed]; //Recupera o grupo de n' associado ao grupo A

    float normAt, normBt; //Inicializa variaveis de calculos
    normAt = 0.0;
    normBt = 0.0;

    int tamA, tamB, tamT; //Variaveis de tamanho

    tamA = GrupoA->subdados.size(); //Tamanho do grupo A
    tamB = GrupoB->subdados.size(); //Tamanho do grupo B
    tamT = CL_Red->subdados.size(); //Tamanho do grupo n' de A.
	
	//Calcula a norma 
    for(int i = 0; i<coluna; i++)
    {
        normAt += (GrupoA->centroide[i] - CL_Red->centroide[i])*(GrupoA->centroide[i] - CL_Red->centroide[i]);
        normBt += (GrupoB->centroide[i] - CL_Red->centroide[i])*(GrupoB->centroide[i] - CL_Red->centroide[i]);
    }
	
	//Calculo do custo
    custo = (((tamB*tamT)*normBt)/(tamB+tamT)) - (((tamA*tamT)*normAt)/(tamA-tamT));

    return custo; //Retorna o custo
}

//Metodo do movimento
void BuscaLocal::FazerMovimento(Cluster *GrupoA, Cluster *GrupoB)
{
    Cluster * CL_Red = GruposReduzidos[GrupoA->gRed]; //Recupera o grupo de n' associado a A.

    AtualizaCentrosAB(GrupoA, GrupoB); //Atualiza os centrois do grupo A e B.
	
	//Adicionar os elementos de n' de A para B.
    for(int i = 0; i<CL_Red->subdados.size(); i++)
    {
        Dado * DadoRed = CL_Red->subdados[i]; //Recupera um dado de n' de A.
		
		//Remoção do dado de n' que pertence ao grupo A
        for(int j = 0; j<GrupoA->subdados.size(); j++)
        {
            Dado * DadoA = GrupoA->subdados[j];
            if(DadoA->linha_ref == DadoRed->linha_ref)
            {
                GrupoA->subdados.erase(GrupoA->subdados.begin()+j);
                j=0;
            }
        }
        GrupoB->subdados.push_back(DadoRed); //Adiciona dado de n' de A em B.
    }
	
	//Se o grupoB nao possuia elementos de n' associados a ele, agora possuirá.
    if(GrupoB->gRed == -1)
    {
        GrupoB->gRed = GrupoA->gRed;
    }

    GrupoA->gRed = -1; //GrupoA nao possui mais elementos de n' associados a ele.

}

//Metodo para atualizar centros.
void BuscaLocal::AtualizaCentrosAB(Cluster *GrupoA, Cluster *GrupoB)
{
    Cluster * CL_Red = GruposReduzidos[GrupoA->gRed]; //Recupera o grupo de n' de A.

    int tamA, tamB, tamT; //Variaveis de tamanho
    tamA = GrupoA->subdados.size(); //Tamanho de A
    tamB = GrupoB->subdados.size(); //Tamanho de B
    tamT = CL_Red->subdados.size(); //Tamanho de n' de A.
	
	//Atualizacao dos centroides
    for(int i = 0; i<coluna; i++)
    {
        GrupoA->centroide[i] = ( (tamA*GrupoA->centroide[i]) - (tamT*CL_Red->centroide[i]) )/(tamA - tamT);
        GrupoB->centroide[i] = ( (tamB*GrupoB->centroide[i]) + (tamT*CL_Red->centroide[i]) )/(tamB + tamT);
    }

}

//Metodo Best Improvement
int BuscaLocal::BestImprov()
{
    int flag_mov = 0; //Flag de movimento
    int flag_ret = 0; //Flag de retorno de movimento, se houver movimentos retonará 1 e entrará novamente no metodo.
    int menorCusto = 0; //Inicializa menor custo do movimento
    int gMov; //Variavel que guarda qual grupo possui o menor custo.

    //Iniciar processo de custo de movimento
    for(int i = 0; i<GruposValidados.size();i++)
    {
        Cluster * CL_A = GruposValidados[i]; //Recupera um grupo dos validados. (Grupo A)
		//Se gRed = -1, significa que o grupo nao possui grupos de n' associados.
        //Se o grupo A possuir elementos de n', faça:
        if(CL_A->gRed!=-1)
        {
            for(int j = 0; j<GruposValidados.size(); j++)
            {
                Cluster * CL_B = GruposValidados[j]; //Recupera um grupo dos validados. (Grupo B))
                
                if(i!=j) //Nao fazer test com ele mesmo.
                {
                    Cluster * CL_Red = GruposReduzidos[CL_A->gRed]; //Recupera o grupo de n' associado ao grupo A
                    int tamA = CL_A->subdados.size() - CL_Red->subdados.size(); //Calcula o tamanho de A sem n'
                    if(tamA >= g) //Se tamanho de A sem n' atender o criterio do g, faça a analise de custo.
                    {
                        float custo = CustoMovimento(CL_A, CL_B); //Calcula o custo do movimento.
                        if(custo < menorCusto) //Gravar o menor custo
                        {
                            menorCusto = custo; //menor custo
                            gMov = j; //grupo B que possui o menor custo.
                            flag_mov = 1; //ativa flag para fazer movimento ao final do laço J
                        }
                    }
                }
            }//fim laço J.
			
            if(flag_mov) //Se houver movimento para fazer, faça:
            {
                Cluster * CL_B = GruposValidados[gMov]; //Recupera o grupo B que possui menor custo de movimento.
                FazerMovimento(CL_A, CL_B); //Fazer o movimento.
                flag_mov = 0; //Reinicia variavel de movimento.
                flag_ret = 1; //Ativa flag de retorno de movimento, irá chamar novamente o metodo best improv ao final.
            }
        }
    }

    return flag_ret; //Retorna o flag se houve movimento ou nao.
}