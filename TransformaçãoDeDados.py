
import pdfplumber
import pandas as pd
import os
import zipfile

def extrair_tabela_para_csv(pdf_path, csv_path):
    if not os.path.exists(pdf_path):
        print(f"Erro PDF nn encontrado")
        

    try:
        with pdfplumber.open(pdf_path) as pdf:
            tabelas = []
            # Percorre todas as páginas do PDF e extrai as tabelas
            for pagina in pdf.pages:
                tabela = pagina.extract_table()  # Tenta extrair uma tabela da página
                if tabela:
                    tabelas.extend(tabela)  # Adiciona os dados extraídos à lista


            if tabelas:
                df = pd.DataFrame(tabelas[1:], columns=tabelas[0])  
                df.replace('OD', 'Seg. Odontológica', inplace=True)
                df.replace('AMB', 'Seg. Ambulatorial', inplace=True)
                df.to_csv(csv_path, index=False, encoding='utf-8')  # Salva o DataFrame como CSV
                print(f"Tabela extr")
                print(tabelas)

            else:
                print("Erro")

    except Exception as e:
        print(f"Erro ao processar o PDF: {e}")

def compactar_csv_em_zip(csv_path):
    """Compacta o arquivo CSV em um arquivo ZIP com o nome 'Teste_{Luca}.zip'."""
    # Definir o nome do arquivo ZIP
    nome_zip = "Teste_{Luca}.zip"
    
    # Cria o arquivo ZIP e adiciona o CSV
    try:
        with zipfile.ZipFile(nome_zip, 'w', zipfile.ZIP_DEFLATED) as arquivoZip:
            arquivoZip.write(csv_path, os.path.basename(csv_path))  # Adiciona o CSV ao ZIP com o nome original
        print(f"Sucess")
    except Exception as e:
        print(f"Erro2")

# Função principal para executar o código
def main():
    print('oi')
    # Defina o caminho do seu PDF e onde deseja salvar o CSV
    pdf_path = r"C:\Users\Usuário\OneDrive\Documentos\Anexo1.pdf"  # Substitua pelo caminho do seu PDF
    csv_path = r"C:\Users\Usuário\OneDrive\Documentos\tabela.csv"  # Caminho de destino para o arquivo CSV
    
    # Chama a função para extrair todas as tabelas e salvar como CSV
    extrair_tabela_para_csv(pdf_path, csv_path)


    compactar_csv_em_zip(csv_path)

if __name__ == "__main__":
    main()

