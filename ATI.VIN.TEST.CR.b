    SUBROUTINE ATI.VIN.TEST.CR
*-----------------------------------------------------------------------------
* Developer Name     : 
* Development Date   : 
* Description        : 
*-----------------------------------------------------------------------------
* Modification History:-
*-----------------------------------------------------------------------------
* Date           	: 
* Modified by    	: 
* Description		: 
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
    $INSERT I_COMMON
    $INSERT I_EQUATE
	$INSERT I_ACCOUNT
*-----------------------------------------------------------------------------
MAIN:
*-----------------------------------------------------------------------------
    GOSUB INIT
	GOSUB PROCESS
	
    RETURN
*-----------------------------------------------------------------------------
INIT:
*-----------------------------------------------------------------------------
	FN.ACCOUNT	= "F.ACCOUNT"
	F.ACCOUNT 	= ""
	CALL OPF(FN.ACCOUNT, F.ACCOUNT)
	
RETURN
*-----------------------------------------------------------------------------
PROCESS:
*-----------------------------------------------------------------------------
	Y.CREDIT.ACCT.NO	= R.NEW(FT.CREDIT.ACCT.NO)
	Y.CREDIT.CURRENCY	= R.NEW(FT.CREDIT.CURRENCY)
	
	CALL F.READ(FN.ACCOUNT, Y.CREDIT.ACCT.NO, R.ACCOUNT, F.ACCOUNT, ERR.ACCOUNT)
	Y.CATEGORY			= R.ACCOUNT<AC.CATEGORY>
	Y.CURRENCY			= R.ACCOUNT<AC.CURRENCY>
	
	IF Y.CREDIT.CURRENCY NE Y.CURRENCY THEN
		AF		= Y.CREDIT.CURRENCY
		ETEXT	= "currency tidak sesuai"
		CALL STORE.END.ERROR
	END
	
	IF Y.CATEGORY NE '1001' THEN
		AF	= Y.CREDIT.ACCT.NO
		ETEXT	= "Category tidak sesuai"
		CALL STORE.END.ERROR
	END
	
	R.NEW(FT.ORDERING.CUST)<1,1>	= "Atas Perintah Nasabah"
	R.NEW(FT.ORDERING.CUST)<1,2>   	= Y.CREDIT.ACCT.NO

RETURN
*-----------------------------------------------------------------------------
END
