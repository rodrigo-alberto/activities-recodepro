package agency.vacation.good.utils;

// @author Rodrigo Alberto;

import javax.swing.JOptionPane;

public enum SystemAlerts {
	//Success alerts;
	REGISTRY_SUCCESS("Registro cadastrado com sucesso!", "Cadastro concluído", JOptionPane.INFORMATION_MESSAGE),
    UPDATE_SUCCESS("Registro atualizado com sucesso!", "Atualização concluída!", JOptionPane.INFORMATION_MESSAGE),
    DELETE_SUCCESS("Registro excluído com sucesso!", "Exclusão concluída!", JOptionPane.INFORMATION_MESSAGE),
    
    //Error alerts;
    REGISTRY_ERROR("Falha no registro!", "Erro no cadastro do(s) registro(s)", JOptionPane.ERROR_MESSAGE),
    QUERY_ERROR("Falha na consulta!", "Erro na consulta do(s) registro(s)", JOptionPane.ERROR_MESSAGE),
    UPDATE_ERROR("Falha na atualização!", "Erro na atualização do(s) registro(s)", JOptionPane.ERROR_MESSAGE),
    DELETE_ERROR("Falha na exclusão!", "Erro na exclusão do(s) registro(s)", JOptionPane.ERROR_MESSAGE),
    
    //Restriction alerts
	RESTRICTION_ADM_ALERT("Para concluir a operação é necessário ter acesso prévio a uma conta de usuário do tipo administrativa.\n\n"
			+ "Deseja continuar?", "Alerta de restrição administrativa", JOptionPane.OK_CANCEL_OPTION),
	RESTRICTION_EXCLUSION("Atenção! Exluir este usuário excluirá também todos os Contatos e Pacotes de viagens a ele associados.\n\n"
			+ "Deseja continuar?", "Alerta de confirmação de exclusão", JOptionPane.OK_CANCEL_OPTION),
	RESTRICTION_OPERATING("Atenção! Segundo a regra de negócio atual da Good Vacation Agency, esta operação é inválida.\n\n",
			"Alerta de confirmação de exclusão", JOptionPane.INFORMATION_MESSAGE),
	RESTRICTION_OPTION(" * Opção inválida! *"),
	RESTRICTION_FORMAT(" * Formato inválido! *"),
	RESTRICTION_VERIFICATION(" * Verifique a janela pop-up gerada! *");

    private final String message;
    private String title;
    private int messageType;

    private SystemAlerts(String message) {
		this.message = message;
	}

	SystemAlerts(String message, String title, int messageType) {
        this.message = message;
        this.title = title;
        this.messageType = messageType;
    }
    
    public static void printToConsole(SystemAlerts alert) {
    	System.out.print("--------------------------------------------");
    	System.out.println("\n"+alert.message);
    	System.out.println("--------------------------------------------");
    }
    
    public static void printAlertMessage(SystemAlerts error) {
    	printToConsole(RESTRICTION_VERIFICATION);
        JOptionPane.showMessageDialog(null, error.message, error.title, error.messageType);
    }
    
    public static int printAlertConfirm(SystemAlerts alert) {
    	printToConsole(RESTRICTION_VERIFICATION);
    	return JOptionPane.showConfirmDialog(null, alert.message, alert.title, alert.messageType);
    }
       
    public static void printAlertException(Exception e) {  
		System.err.print("--------------------------------------------");
    	System.err.println("\n # Erro: "+e);
		System.err.println("--------------------------------------------");
    }
}