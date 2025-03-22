CREATE PROCEDURE [dbo].[IPALSP_User] 
     @Nom_Login					varchar(30)		      = NULL, 
     @Nom_Senha					varchar(20)	          = NULL, 
     @Nom_Email					varchar(40)           = NULL, 
     @Nome						varchar(70)		      = NULL,  
     @Atribuicao				varchar(30)           = NULL,  
     @TipoVoz					varchar(15)           = NULL,  
     @Instrumento				varchar(25)           = NULL,  
     @SegundoInstrumento		varchar(25)           = NULL,  
     @Num_TipoLogin				int                   = NULL,  
     @Cod_Erro					int                   = NULL OUTPUT, 
     @Msg_Erro					varchar(255)          = NULL OUTPUT 
 AS 
 BEGIN 
     -- Função: Registrar os usuários da plataforma 
     -- Scripts: Procs_IPAL_User
     -- Data: 14/06 
 
     SELECT @Cod_Erro = CASE  
         WHEN (@Nom_Login          IS NULL OR @Nom_Login     = '') OR                                 
              (@Nom_Senha          IS NULL OR @Nom_Senha     = '') OR       
              (@Nom_Email          IS NULL OR @Nom_Email     = '') OR       
              (@Nome               IS NULL OR @Nome          = '') OR 
              (@Atribuicao         IS NULL OR @Atribuicao    = '') OR 
              (@TipoVoz            IS NULL OR @TipoVoz       = '') OR 
              (@Num_TipoLogin      IS NULL OR @Num_TipoLogin   = '') 
         THEN 002 -- CAMPO VAZIO             
         ELSE 000 
     END 
 
     IF @Cod_Erro = 000 
     BEGIN 
         INSERT INTO [dbo].[Ipal_User] (
			 Nom_Login, Nom_Senha, Nom_Email, Nome, Atribuicao, 
             TipoVoz, Instrumento, SegundoInstrumento, Num_TipoLogin, 
             Inst_Criacao) 
         VALUES ( 
             @Nom_Login, @Nom_Senha, @Nom_Email, @Nome, @Atribuicao,         
             @TipoVoz, @Instrumento, @SegundoInstrumento, @Num_TipoLogin,
             getdate()) 
     END 
     
     SELECT @Msg_Erro = [dbo].[IPALF_User_MensErro] (@Cod_Erro)
 END 