import zipfile
import os
import subprocess

def compactar_zip(arquivos, nome_saida):
    with zipfile.ZipFile(nome_saida, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for arquivo in arquivos:
            zipf.write(arquivo, arcname=os.path.basename(arquivo))
    print("ZIP criado")

def compactar_rar(arquivos, nome_saida):
    rar_exe = r"C:\Program Files\WinRAR\WinRAR.exe"  # padrao
    if not os.path.exists(rar_exe):
        print("erro")
        return

    comando = [rar_exe, "a", "-r", nome_saida] + arquivos
    subprocess.run(comando, shell=True)
    print("RAR criado")


def main():
    arquivos_pdf = [r"C:\Users\Usuário\OneDrive\Documentos\Anexo1.pdf", r"C:\Users\Usuário\OneDrive\Documentos\Anexo2.pdf"] 

    compactar_zip(arquivos_pdf, r"C:\Users\Usuário\OneDrive\Documentos\arquivos.zip")
    compactar_rar(arquivos_pdf, r"C:\Users\Usuário\OneDrive\Documentos\arquivos.rar")

if __name__ == '__main__':
    main()
    
