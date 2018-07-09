function do_encrypt(PIN_String, RN_String, Hash_String, Mod_String, Exp_String) {

    var res = initialisePublicKeyData(Mod_String, Exp_String);
	if(res == ERR_NO_ERROR)
	{
		res = OBM_EncryptPassword_Ex(PIN_String, RN_String, Hash_String);
	//  res = OBM_EncryptPassword(PIN_String, RN_String);
	}	
   
    var Error_String = "";

    switch (res) {
    case ERR_INVALID_PIN_LENGTH:
        Error_String = "Error No: " + ERR_INVALID_PIN_LENGTH + " :  Invalid PIN Length";
        break;
    case ERR_INVALID_PIN:
        Error_String = "Error No: " + ERR_INVALID_PIN + " :  Invalid PIN";
        break;
    case ERR_INVALID_PIN_BLOCK:
        Error_String = "Error No: " + ERR_INVALID_PIN_BLOCK + " :  Invalid PIN Block";
        break;
    case ERR_INVALID_RANDOM_NUMBER_LENGTH:
        Error_String = "Error No: " + ERR_INVALID_RANDOM_NUMBER_LENGTH + " :  Invalid Random Number Length";
        break;
    case ERR_INVALID_RANDOM_NUMBER:
        Error_String = "Error No: " + ERR_INVALID_RANDOM_NUMBER + " :  Invalid Random Number";
        break;
    case ERR_INVALID_HASH:
        Error_String = "Error No: " + ERR_INVALID_HASH + " :  Invalid Hash Algorithm";
        break;
    case ERR_INVALID_PIN_MESSAGE_LENGTH:
        Error_String = "Error No: " + ERR_INVALID_PIN_MESSAGE_LENGTH + " :  Invalid PIN Message Length";
        break;
    case ERR_INVALID_RSA_KEY_LENGTH:
        Error_String = "Error No: " + ERR_INVALID_RSA_KEY_LENGTH + " :  Invalid RSA Key Length";
		break;
    case ERR_INVALID_RSA_KEY:
        Error_String = "Error No: " + ERR_INVALID_RSA_KEY + " :  Invalid RSA Key";
        break;
    case ERR_RSA_ENCRYPTION:
        Error_String = "Error No: " + ERR_RSA_ENCRYPTION + " :  RSA Encryption Failed";
        break;
    case ERR_NO_ERROR:
        Error_String = "Encryption Successful !!";
        if (C_String != "") {
            // display encrypted message    
            //document.test_sample.encrypted.value = OBM_GetEncryptedPassword();
            //document.test_sample.EP.value = OBM_GetEncodingParameter();
            var encryptedPassword = OBM_GetEncryptedPassword();
            var encodingParameter = OBM_GetEncodingParameter();
            return {
            	ok: true,
            	params: {
            		encryptedPassword : encryptedPassword,
            		encodingParameter : encodingParameter
            	}
            }

        } else {
            Error_String = "Error No: " + ERR_INVALID_OPERATION + " Null Encrypted Message";
        }
        break;

    default:
        Error_String = "Unexpected Response" + res;
    }

    return {
    	ok: false,
    	message: Error_String
    };

}

function do_encrypt_change_PIN(old_PIN_String, new_PIN_String, RN_String, Hash_String, Mod_String, Exp_String) {
    
    var res = initialisePublicKeyData(Mod_String, Exp_String);
    if(res == ERR_NO_ERROR)
    {
        res = OBM_EncryptChangePassword_Ex(old_PIN_String, new_PIN_String, RN_String, Hash_String);
        // res = OBM_EncryptChangePassword(old_PIN_String, new_PIN_String, RN_String);
    }
    
//    document.change_password.encrypted.value = "";
//    document.change_password.EP.value = "";
    var Error_String = "";
    
    switch (res) {
        case ERR_INVALID_PIN_LENGTH:
            Error_String = "Error No: " + ERR_INVALID_PIN_LENGTH + " :  Invalid PIN Length";
            break;
        case ERR_INVALID_PIN:
            Error_String = "Error No: " + ERR_INVALID_PIN + " :  Invalid PIN";
            break;
        case ERR_INVALID_PIN_BLOCK:
            Error_String = "Error No: " + ERR_INVALID_PIN_BLOCK + " :  Invalid PIN Block";
            break;
        case ERR_INVALID_RANDOM_NUMBER_LENGTH:
            Error_String = "Error No: " + ERR_INVALID_RANDOM_NUMBER_LENGTH + " :  Invalid Random Number Length";
            break;
        case ERR_INVALID_RANDOM_NUMBER:
            Error_String = "Error No: " + ERR_INVALID_RANDOM_NUMBER + " :  Invalid Random Number";
            break;
        case ERR_INVALID_HASH:
            Error_String = "Error No: " + ERR_INVALID_HASH + " :  Invalid Hash Algorithm";
            break;
        case ERR_INVALID_PIN_MESSAGE_LENGTH:
            Error_String = "Error No: " + ERR_INVALID_PIN_MESSAGE_LENGTH + " :  Invalid PIN Message Length";
            break;
        case ERR_INVALID_RSA_KEY_LENGTH:
            Error_String = "Error No: " + ERR_INVALID_RSA_KEY_LENGTH + " :  Invalid RSA Key Length";
            break;
        case ERR_INVALID_RSA_KEY:
            Error_String = "Error No: " + ERR_INVALID_RSA_KEY + " :  Invalid RSA Key";
            break;
        case ERR_RSA_ENCRYPTION:
            Error_String = "Error No: " + ERR_RSA_ENCRYPTION + " :  RSA Encryption Failed";
            break;
        case ERR_NO_ERROR:
            Error_String = "Encryption Successful !!";
            if (C_String != "") {
                // display encrypted message
//                document.change_password.encrypted.value = OBM_GetEncryptedPassword();
//                document.change_password.EP.value = OBM_GetEncodingParameter();
                var encryptedPassword = OBM_GetEncryptedPassword();
                var encodingParameter = OBM_GetEncodingParameter();
                return {
                    ok: true,
                        params: {
                            encryptedPassword : encryptedPassword,
                            encodingParameter : encodingParameter
                        }
                    }
                
            } else {
                Error_String = "Error No: " + ERR_INVALID_OPERATION + " Null Encrypted Message";
            }
            break;
            
        default:
            Error_String = "Unexpected Response" + res;
    }
    
    return {
        ok: false,
        message: Error_String
    };
    
}