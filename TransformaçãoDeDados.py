
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
            for pagina in pdf.pages:
                tabela = pagina.extract_table() 
                if tabela:
                    tabelas.extend(tabela)


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
        print("Erro ao processar PDF")

def compactar_csv_em_zip(csv_path):
    nome_zip = "Teste_{Luca}.zip"
    
    try:
        with zipfile.ZipFile(nome_zip, 'w', zipfile.ZIP_DEFLATED) as arquivoZip:
            arquivoZip.write(csv_path, os.path.basename(csv_path))  
        print(f"Sucess")
    except Exception as e:
        print(f"Erro2")


def main():
    print('Funcionando')
    
    pdf_path = r"C:\Users\Usuário\OneDrive\Documentos\Anexo1.pdf"  
    csv_path = r"C:\Users\Usuário\OneDrive\Documentos\tabela.csv"  
    

    extrair_tabela_para_csv(pdf_path, csv_path)


    compactar_csv_em_zip(csv_path)

if __name__ == "__main__":
    main()

